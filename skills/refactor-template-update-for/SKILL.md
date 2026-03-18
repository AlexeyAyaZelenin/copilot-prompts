---
name: refactor-template-update-for
description: Nova-only guidance for updating Angular template loops, migrating *ngFor to @for, and simplifying iteration blocks while preserving behavior.
---

# Refactor Template Update For (Nova)

Use this skill when refactoring list iteration in Nova Angular templates.

## Goal

Refactor template loop logic for readability and maintainability while preserving runtime behavior unless behavior changes are explicitly requested.

## Constraints

- Operate only in Nova component/template scope unless scope is explicitly broadened.
- Prefer Angular v17 loop control flow with `@for` where appropriate.
- Preserve rendering order, item identity tracking semantics, and bound events.
- Keep edits minimal and localized to requested loop blocks.
- Do not run tests in this step; return handoff details for parent-level validation.

## Workflow

1. Inspect requested loop blocks and related inputs/selectors used by iteration.
2. Classify intent:
- behavior-preserving cleanup
- explicit behavior change
3. Apply safe loop refactors:
- migrate `*ngFor` to `@for` where appropriate
- preserve `trackBy`/identity behavior when migrating
- simplify duplicated list-rendering fragments
- remove dead loop wrappers when safe
4. Validate statically:
- loop variable usage and scope
- binding and event continuity
- selector/input references for iterated data
5. Return changed files and validation handoff notes for parent-level test execution.

## Decision Rules

- If tracking behavior is unclear, keep existing identity semantics intact rather than simplifying aggressively.
- If intent is ambiguous, default to behavior-preserving migration and state assumptions.
- If refactor risk is high, apply minimal safe migration and report deferred cleanup opportunities.

## Output Checklist

- Summary of loop updates and why.
- Changed files.
- Behavior-impact notes and assumptions.
- Validation handoff notes for test execution.
- Open questions for risky deferred simplifications.
