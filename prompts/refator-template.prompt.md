---
description: 'Refator template using refactor-component-template agent for selected or directory HTML files'
model: GPT-5.4 (copilot)
---

Use the `refactor-component-template` custom agent for the current selection scope.

Target resolution rules:

1. Try to use the currently selected/active file from editor context.
2. If that file is missing or is not an `.html` file:
- Inspect the same directory as the active file.
- Collect all `.html` files from that directory (non-recursive).
3. If exactly one `.html` file is found, use it.
4. If multiple `.html` files are found, run the `refactor-component-template` agent separately for each file (one invocation per file, sequentially).
5. If no `.html` files are found, report that clearly and stop.

Execution requirements:

- Pass each resolved file path explicitly to `refactor-component-template`.
- Preserve runtime behavior unless explicitly requested otherwise.
- Keep edits minimal and scoped to each file.
- Ensure the parent orchestrator flow is used so test subagent runs after refactor subagents.

Final output:

- Resolved target file list.
- Per-file agent invocation status.
- Consolidated summary of changed files and validation outcomes.
