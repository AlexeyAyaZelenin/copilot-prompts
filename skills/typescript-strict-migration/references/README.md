# TypeScript Strict Migration References

This skill is split into focused reference files so you can load only the rules that match the failing diagnostics. Guidance is Nova-only and aims to fix strict TypeScript or template compile errors without changing runtime behavior.

## Route By Task

- Use [typing.md](typing.md) for concrete typing, assertions, event types, and nullable observables
- Use [initialization.md](initialization.md) for field defaults, route or query ids, and lifecycle-assigned members
- Use [null-safety.md](null-safety.md) for DOM guards, header access, and uncertain values
- Use [angular-patterns.md](angular-patterns.md) for template-bound callbacks, `@Input`, `@ViewChild`, async bindings, and fallback rendering
- Use [ngrx-reducers.md](ngrx-reducers.md) for reducer signatures, feature-state nullability, and selected-entity sentinels
- Use [tests-and-mocks.md](tests-and-mocks.md) for typed test doubles, selector overrides, and mock shape fixes
- Use [safety-and-hygiene.md](safety-and-hygiene.md) for behavior-preservation and minimal-change guardrails

## Scope

- This skill defines code-fix rules only
- Orchestration concerns such as wave planning, compile gating, and checklist tracking belong in the agent workflow
- Preserve runtime behavior unless requirements or tests explicitly change it

## Example Pattern

- When adding examples, prefer a two-line shape directly under the rule
- `Before: <old pattern>`
- `After: <new pattern>`
- Keep examples one-liners unless a multi-line snippet is required for clarity
- Use concrete app-domain types such as `CandidateContract` and `PicklesState` instead of placeholders when possible
- Prefer examples based on observed Nova code rather than synthetic anti-patterns

## Cross-Skill Boundaries

- Use `nova-angular-standards` for broader Angular component, forms, and import conventions
- Use `nova-state-management` for broader NgRx guidance beyond strict-migration typing fixes
- Use `unit-tests` for general testing design when the issue is not primarily a strict typing failure
