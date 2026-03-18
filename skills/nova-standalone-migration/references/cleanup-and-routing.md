# Cleanup And Routing

## Migration Patterns That Commonly Follow

### Standalone component imports

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

- Remove leftover empty modules the schematic could not safely delete
- Replace module-only routing shells with standalone route definitions where appropriate
- Move shared declarations into direct component imports
- Collapse wrapper modules that only re-export declarations
- Revisit tests that still declare migrated components in `declarations` instead of `imports`

## Common Problems

- Existing compilation errors block correct migration analysis
- Files outside the relevant `tsconfig` are ignored by the schematic
- Metadata that cannot be statically analyzed may be skipped
- Unit tests may need manual import fixes because they are not AoT compiled
- Custom wrappers around Angular APIs can hide code from the schematic

## Review Checklist

- Was the migration run in the correct three-step order?
- Is the feature still compiling after each step?
- Are leftover `NgModule` references intentional or just uncleaned migration output?
- Should route-level providers replace module-level scoping here?
- Are tests importing standalone components correctly?
- Is `importProvidersFrom` only being used where no `provideX` API exists yet?
