# Migration Workflow

Nova is on Angular v17 and still has module-to-standalone migration work. This skill is about migration workflow, not just authoring new standalone components.

## Prerequisites

Angular's v17 migration guide calls out three prerequisites:

1. The project must be on Angular 15.2 or later.
2. The project must build without compilation errors.
3. Work should be on a clean branch with all changes saved.

For Nova specifically, start `nova-watch-start-no-open` and keep the app compiling while migrating.

## Core Rules

- Migrate in the official order
- Prefer path-scoped migrations so features can be migrated incrementally
- Compile and manually review after each schematic run
- Expect manual fixes, especially in tests and complex module wiring
- Keep existing behavior stable before follow-up cleanup or modernization
- Use provider functions such as `provideRouter` when available; use `importProvidersFrom` only when a library still exposes NgModule-only configuration

## Official Schematic Workflow

```text
1. ng g @angular/core:standalone
   Select: Convert all components, directives and pipes to standalone

2. ng g @angular/core:standalone
   Select: Remove unnecessary NgModule classes

3. ng g @angular/core:standalone
   Select: Bootstrap the project using standalone APIs
```

Use the schematic `path` option when migrating incrementally.

## What Each Step Does

### 1. Convert declarations to standalone

- Adds `standalone: true`
- Populates component `imports`
- Leaves bootstrapped root declarations for the later bootstrap step

### 2. Remove unnecessary NgModules

A module is generally not removable if it still has:

- `declarations`
- `providers`
- `bootstrap`
- `imports` tied to `ModuleWithProviders`
- class members beyond an empty constructor

If the schematic cannot clean up a reference automatically, it leaves a standalone-migration TODO comment. Treat those TODOs as required follow-up work.

### 3. Switch to standalone bootstrapping APIs

This changes root bootstrapping from `bootstrapModule` to `bootstrapApplication`, converts the root component to standalone, and moves root-level providers and imports into bootstrap configuration where possible.
