---
name: refactor-template-update-if
description: Nova-only guidance for updating Angular template if-conditions, migrating to @if, removing dead else branches, and simplifying conditional rendering while preserving behavior.
---

# Refactor Template Update If (Nova)

Use this skill when refactoring conditional rendering in Nova Angular templates.

## Goal

Refactor template conditional logic to improve clarity and maintainability while preserving behavior unless behavior changes are explicitly requested.

## Constraints

- Operate only in Nova component/template scope unless scope is explicitly broadened.
- Prefer Angular v17 control flow, especially `@if` and related blocks.
- Keep edits minimal and localized to requested files and blocks.
- Preserve existing bindings, events, and rendering behavior unless behavior changes are explicitly requested.
- Do not run tests in this step; return handoff details for parent-level validation.

## Workflow

1. Inspect requested template blocks and linked component state, inputs, and selectors.
2. Classify intent:
- behavior-preserving cleanup
- explicit behavior change
3. Apply safe conditional refactors:
- migrate `*ngIf` to `@if` where appropriate
- simplify compound conditions after removing obsolete terms
- remove dead or unreachable `else` branches
- collapse duplicated conditional fragments
4. Validate statically:
- imports and symbol references
- selector and input usage
- template references and bound properties
5. Return changed files and validation handoff notes for parent-level test execution.

## Decision Rules

- If intent is ambiguous, default to behavior-preserving refactor and state assumptions.
- If a condition is tied to a removed feature flag, keep the always-enabled path and remove the disabled path.
- If simplification has elevated risk, make the smallest safe change first and report deferred opportunities.

## Output Checklist

- Summary of conditional updates and why.
- Changed files.
- Behavior-impact notes and assumptions.
- Validation handoff notes for test execution.
- Open questions for risky deferred simplifications.
