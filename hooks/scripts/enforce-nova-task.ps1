# Hook contract: VS Code sends JSON payload to stdin.
$raw = [Console]::In.ReadToEnd()
if ([string]::IsNullOrWhiteSpace($raw)) {
    Write-Output '{"continue":true}'
    exit 0
}

try {
    # Parse defensively; on malformed payload, fail open.
    $payload = $raw | ConvertFrom-Json -Depth 20
}
catch {
    Write-Output '{"continue":true}'
    exit 0
}

# This script enforces only PreToolUse events.
if ($payload.hookEventName -ne 'PreToolUse') {
    Write-Output '{"continue":true}'
    exit 0
}

# Multi-root note:
# If both Nova and Connect are open as workspace roots, both hooks can run.
# Workaround (optional): scope by payload.cwd and return continue=true when cwd
# is not under this app root.
# Example guard:
# $cwd = [string]$payload.cwd
# if ($cwd -notmatch '\\Nova(?:\\|$)') {
#     Write-Output '{"continue":true}'
#     exit 0
# }

# Scope enforcement to manual terminal commands only.
$toolName = [string]$payload.tool_name
$toolNameNorm = $toolName.ToLowerInvariant()
$terminalToolNames = @('run_in_terminal', 'runinterminal', 'execute/runinterminal', 'execute.runinterminal')
if ($terminalToolNames -notcontains $toolNameNorm) {
    Write-Output '{"continue":true}'
    exit 0
}

$command = [string]$payload.tool_input.command
if ([string]::IsNullOrWhiteSpace($command)) {
    Write-Output '{"continue":true}'
    exit 0
}

$cmd = $command.ToLowerInvariant()

# Manual start/build commands are blocked to force consistent VS Code task usage.
# Test commands intentionally remain allowed.
$blockedPatterns = @(
    '\bnpm\s+run\s+start(?:[:\w-]*)?\b',
    '\bnpm\s+start\b',
    '\bng\s+serve\b',
    '\bnpm\s+run\s+build(?:[:\w-]*)?\b',
    '\bnpm\s+build\b',
    '\bng\s+build\b'
)

$shouldBlock = $false
foreach ($pattern in $blockedPatterns) {
    if ($cmd -match $pattern) {
        $shouldBlock = $true
        break
    }
}

if (-not $shouldBlock) {
    Write-Output '{"continue":true}'
    exit 0
}

# Deny with an actionable reason that points to the approved task.
$result = @{
    hookSpecificOutput = @{
        hookEventName = 'PreToolUse'
        permissionDecision = 'deny'
        permissionDecisionReason = 'Manual start/build commands are blocked in Nova. Use VS Code watch task "nova-watch-start-no-open" for compile feedback; test-related npm commands are allowed.'
    }
}

$result | ConvertTo-Json -Depth 10 -Compress
exit 0