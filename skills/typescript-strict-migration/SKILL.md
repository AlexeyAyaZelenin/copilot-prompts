---
name: typescript-strict-migration
description: Nova-only strict TypeScript migration code-fix rules. Use only when working in the Nova application and fixing strict diagnostics or resolving TypeScript/template compile errors while preserving runtime behavior. Read the matching file in `references/` for the specific rule area.
---

# TypeScript Strict Migration

Use this skill as the rule authority for Nova strict TypeScript migration work. It covers code-fix rules for strict diagnostics and template compile errors while preserving runtime behavior.

## When To Use This Skill

- Fixing strict TypeScript diagnostics in Nova components, services, reducers, or tests
- Resolving template type errors or nullable binding mismatches
- Repairing strict migration fallout around initialization, `@Input`, `@ViewChild`, or selector outputs
- Correcting NgRx reducer state types after nullability mismatches
- Fixing test mocks or selector overrides that broke under stricter typing

## Load The Smallest Relevant Reference

Read the closest matching file before giving detailed guidance or generating code:

- Overview, scope, and example shape: [references/README.md](references/README.md)
- Concrete typing and assertion rules: [references/typing.md](references/typing.md)
- Initialization, defaults, and lifecycle assignment: [references/initialization.md](references/initialization.md)
- Null guards and uncertain values: [references/null-safety.md](references/null-safety.md)
- Angular component and template patterns: [references/angular-patterns.md](references/angular-patterns.md)
- NgRx reducer migration rules: [references/ngrx-reducers.md](references/ngrx-reducers.md)
- Typed test doubles and mocks: [references/tests-and-mocks.md](references/tests-and-mocks.md)
- Behavior-preservation and minimal-change guardrails: [references/safety-and-hygiene.md](references/safety-and-hygiene.md)

## Core Rules

- Never use `any`; use concrete types or `unknown`
- Preserve runtime behavior; new guards or fallback defaults are behavior changes unless already intended
- Prefer nullable types or definite assignment over fake initializers
- Keep changes minimal and focused on the strictness failure being fixed
- Do not add code comments as part of strict cleanup
