# Nova Signals References

This skill is split into focused reference files so you can load only the part that matches the task. All guidance targets the archived Angular v17 docs used by Nova, not newer Angular releases.

## Route By Task

- Use [signal-primitives.md](signal-primitives.md) for `signal`, `computed`, dependency tracking, and `OnPush` rendering
- Use [effects-and-advanced.md](effects-and-advanced.md) for `effect`, cleanup, `untracked`, and equality functions
- Use [component-authoring.md](component-authoring.md) for `input()`, `model()`, `output()`, and component API design
- Use [queries-and-render-hooks.md](queries-and-render-hooks.md) for signal queries, result timing, and DOM work with `afterRender` or `afterNextRender`
- Use [rxjs-interop.md](rxjs-interop.md) for `toSignal` and `toObservable`

## Angular v17 Scope

These APIs were still developer preview in Angular v17 and should be treated as version-specific:

- `effect`
- Signal inputs via `input()`
- Model inputs via `model()`
- `output()`
- Signal queries
- `afterRender()` and `afterNextRender()`
- `@angular/core/rxjs-interop`

When current Angular guidance differs, prefer the v17 behavior documented in this skill.

## Cross-Skill Boundaries

- Use `nova-control-flow` for `@if`, `@for`, `@switch`, and `@empty`
- Use `nova-state-management` when state is shared across a feature or needs NgRx Store or ComponentStore
- Use `nova-ssr-hydration` for broader SSR and hydration concerns beyond render-hook timing

## Source Coverage

This skill was refreshed from these Angular v17 pages:

- `guide/signals`
- `guide/signal-inputs`
- `guide/model-inputs`
- `guide/signal-queries`
- `guide/rxjs-interop`
- `api/core/output`
- `api/core/afterRender`
- `api/core/afterNextRender`