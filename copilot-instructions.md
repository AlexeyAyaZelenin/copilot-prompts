# Nova Instructions

Nova is an Angular v17 enterprise healthcare application for Aya Healthcare's internal operations. It supports recruiting, compliance, billing, payroll, and clinical workflows with 50+ feature modules.

## Quick Reference

| Topic                                   | Skill                         |
| --------------------------------------- | ----------------------------- |
| Project structure, tech stack           | `nova-architecture`           |
| Running app, compilation, pitfalls      | `nova-development-workflow`   |
| Component patterns and forms            | `nova-angular-standards`      |
| Built-in control flow blocks            | `nova-control-flow`           |
| Angular v17 signals and authoring APIs  | `nova-signals`                |
| Deferrable views (`@defer`)             | `nova-deferrable-views`       |
| SSR and hydration                       | `nova-ssr-hydration`          |
| Standalone migration                    | `nova-standalone-migration`   |
| NgRx and ComponentStore patterns        | `nova-state-management`       |
| Login, permissions, guards              | `nova-auth`                   |
| LaunchDarkly patterns                   | `nova-feature-flags`          |
| Unit testing patterns                   | `unit-tests`                  |
| Strict TypeScript migration rules       | `typescript-strict-migration` |
| Colors, typography, spacing             | `design-tokens`               |
| SCSS patterns, mixins, responsive       | `nova-styling`                |
| Material/Kendo components               | `nova-components`             |
| Icons usage                             | `nova-icons`                  |
| Figma to Angular                        | `figma-to-angular`            |
| Removing feature flags                  | `nova-remove-feature-flag`    |

## Critical Workflow

**ALWAYS run `nova-watch-start-no-open` task** and monitor its output before making changes, unless the changes only affect unit tests. Never run tests or declare work complete with compilation errors.

## Core Rules

- **Standalone components** with `nova-` selector prefix
- **New control flow**: `@if`, `@for` not `*ngIf`, `*ngFor`
- **Non-relative imports**: `import { X } from 'src/app/feature/x'`
- **RxJS**: Import from `rxjs`, not `rxjs/operators`
- **No `any` types** - use specific types or `unknown`
- **Jasmine + Spectator** for tests, not Jest/TestBed
- **Test include globs**: For `npm test -- --include=...`, use `**/...spec.ts` patterns and never prefix with `src/app/`
- **No inline styles, `::ng-deep`, or `!important`**

## Documentation

- **Developer Onboarding**: https://ayadev.atlassian.net/wiki/spaces/ARCH/pages/252903461
- **Getting Started Guide**: https://ayadev.atlassian.net/wiki/spaces/ARCH/pages/556367921
