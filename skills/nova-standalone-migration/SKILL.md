---
name: nova-standalone-migration
description: Nova-only Angular v17 standalone migration guidance. Use only when working in the Nova application and migrating NgModule-based features to standalone components, removing unnecessary modules, or switching bootstrapping to standalone APIs.
---

# Nova Standalone Migration

Nova is on Angular v17 and still has module-to-standalone migration work. Use this skill when migrating a feature area from NgModules to standalone APIs or when reviewing schematic output.

This skill is about migration workflow, not just authoring new standalone components.

## When to Use This Skill

- Migrating a feature area from NgModules to standalone components
- Running Angular's standalone schematic incrementally
- Removing leftover feature or shared modules
- Switching root bootstrap from `bootstrapModule` to `bootstrapApplication`
- Converting lazy routes from module-based patterns to standalone route files

## Prerequisites

Angular's v17 migration guide calls out three prerequisites:

1. The project must be on Angular 15.2 or later.
2. The project must build without compilation errors.
3. Work should be on a clean branch with all changes saved.

For Nova specifically, also follow the repo rule to start the `nova-watch-start-no-open` task and keep the app compiling while migrating.

## Core Rules

- Migrate in the official order; do not skip ahead to bootstrapping changes first
- Prefer path-scoped migrations so a feature can be migrated incrementally
- Compile and manually review after each schematic run
- Expect manual fixes, especially in tests and complex module wiring
- Keep existing behavior stable before doing follow-up cleanup or modernization
- Use provider functions such as `provideRouter` when available; use `importProvidersFrom` only when a library still exposes NgModule-only configuration

## Official Schematic Workflow

Angular's standalone migration is a three-step process. Run the schematic multiple times and verify the app between steps.

```text
1. ng g @angular/core:standalone
   Select: Convert all components, directives and pipes to standalone

2. ng g @angular/core:standalone
   Select: Remove unnecessary NgModule classes

3. ng g @angular/core:standalone
   Select: Bootstrap the project using standalone APIs
```

Use the schematic `path` option when migrating incrementally so only part of the app is transformed at a time.

## What Each Step Does

### 1. Convert declarations to standalone

The schematic:

- Adds `standalone: true`
- Populates component `imports`
- Leaves bootstrapped root declarations for the later bootstrap step

Expect to review:

- Missing imports in templates with unusual patterns
- TestBed setup in specs
- Directives or pipes referenced through wrappers or dynamic metadata

### 2. Remove unnecessary NgModules

The schematic can delete modules only when they are safe to remove. A module is generally not removable if it still has:

- `declarations`
- `providers`
- `bootstrap`
- `imports` tied to `ModuleWithProviders`
- class members beyond an empty constructor

If the schematic cannot clean up a reference automatically, it leaves:

`/* TODO(standalone-migration): clean up removed NgModule reference manually */`

Treat those TODOs as required follow-up work, not optional comments.

### 3. Switch to standalone bootstrapping APIs

This step changes root bootstrapping from `bootstrapModule` to `bootstrapApplication`, converts the root component to standalone, and attempts to move root-level providers and imports into the new bootstrap configuration.

## Migration Patterns That Commonly Follow

### Standalone component imports

After migration, component dependencies move into the component's `imports` array.

- Import standalone components, directives, and pipes directly
- Import legacy NgModules directly when a library is not yet standalone-aware

### Provider migration

As modules disappear, provider setup often moves to:

- `bootstrapApplication(..., { providers: [...] })`
- route-level `providers`
- `providedIn: 'root'` services

Use `importProvidersFrom` only when a dependency still requires NgModule-based provider configuration.

### Router migration

Standalone routing usually moves toward:

- `loadComponent` for lazily loaded standalone components
- `loadChildren` returning route arrays instead of feature modules
- route-scoped `providers` instead of module-scoped DI

## Manual Cleanup Checklist

- Remove leftover empty modules that the schematic could not safely delete
- Replace module-only routing shells with standalone route definitions where appropriate
- Move shared declarations into direct component imports
- Collapse wrapper modules that only re-export declarations
- Revisit tests that still declare migrated components in `declarations` instead of `imports`

## Common Problems From Angular's Guide

- Existing compilation errors block correct migration analysis
- Files outside the relevant `tsconfig` are ignored by the schematic
- Metadata that cannot be statically analyzed may be skipped
- Unit tests may need manual import fixes because they are not AoT compiled
- Custom wrappers around Angular APIs can hide code from the schematic

## Example Direction of Travel

Before migration:

- Feature module declares components and imports `CommonModule`
- Route lazy loads a module
- Root app bootstraps with `bootstrapModule(AppModule)`

After migration:

- Components are standalone and import what they use directly
- Routes lazy load standalone components or route arrays
- Root app bootstraps with `bootstrapApplication(AppComponent, { providers: [...] })`

## Review Checklist

- Was the migration run in the correct three-step order?
- Is the feature still compiling after each step?
- Are leftover `NgModule` references intentional or just uncleaned migration output?
- Should route-level providers replace module-level scoping here?
- Are tests importing standalone components correctly?
- Is `importProvidersFrom` only being used where no `provideX` API exists yet?