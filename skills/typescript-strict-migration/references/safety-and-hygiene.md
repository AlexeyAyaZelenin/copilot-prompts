# Behavior Safety And Code Hygiene

## Behavior Safety

- Do: preserve existing business logic and API contracts
- Before: remove or gate an existing dispatch during strict typing cleanup without requirement changes
- After: keep the original dispatch contract and change behavior only with explicit requirement or test updates

- Do not: replace nullable dates with `new Date()` unless that is explicitly intended behavior

## Code Hygiene

- Do: keep changes minimal and focused on strictness fixes
- Before: `sortFn(a, b): number { ... }`
- After: `sortFn(a: Lookup, b: Lookup): number { ... }`

- Do not: add code comments
