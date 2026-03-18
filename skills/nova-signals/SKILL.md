---
name: nova-signals
description: Nova-only Angular v17 signals guidance. Use only when working in the Nova application and working with `signal`, `computed`, `effect`, `input`, `model`, `output`, signal queries, render hooks, or RxJS interop such as `toSignal` and `toObservable`. Read the matching file in `references/` for the specific API surface.
---

# Nova Signals

Nova is on Angular v17. Use this skill for Angular v17 signal APIs and function-based authoring patterns, not the latest Angular docs.

Several signal-adjacent APIs were still developer preview in v17, including `effect`, signal inputs, model inputs, `output()`, signal queries, render hooks, and the RxJS interop package. Prefer the v17 behavior captured here when it differs from newer Angular examples.

## When to Use This Skill

- Replacing component-local `BehaviorSubject` or ad hoc mutable state with `signal`
- Deriving UI state with `computed`
- Reacting to signal changes with `effect`
- Converting `@Input()` patterns to `input()` or `model()`
- Converting `@Output()` patterns to `output()`
- Converting `@ViewChild()` or `@ContentChild()` patterns to signal queries
- Running browser-only DOM work with `afterRender` or `afterNextRender`
- Bridging Observables and signals with `toSignal` or `toObservable`
- Debugging `OnPush` rendering or signal dependency tracking

## Load The Smallest Relevant Reference

Read the closest matching file before giving detailed guidance or generating code:

- Overview and source coverage: [references/README.md](references/README.md)
- Local state, `computed`, and `OnPush`: [references/signal-primitives.md](references/signal-primitives.md)
- `effect`, cleanup, `untracked`, and equality: [references/effects-and-advanced.md](references/effects-and-advanced.md)
- `input()`, `model()`, and `output()`: [references/component-authoring.md](references/component-authoring.md)
- Signal queries and render hooks: [references/queries-and-render-hooks.md](references/queries-and-render-hooks.md)
- `toSignal()` and `toObservable()`: [references/rxjs-interop.md](references/rxjs-interop.md)

## Core Rules

- Prefer signals over `BehaviorSubject` for component-local state
- Use `computed` for derived state, not `effect`
- Use `effect` only for real side effects such as logging, persistence, or imperative integration
- Use `output()` for new function-based component events instead of adding fresh `EventEmitter` usage
- Use signal queries only in component or directive property initializers
- Treat `afterRender` and `afterNextRender` as browser-only DOM hooks and always specify a non-default phase
- Use `toSignal` and `toObservable` only at clear signal and Observable boundaries
- In Nova, keep components standalone, prefer `ChangeDetectionStrategy.OnPush`, use non-relative imports, and import RxJS operators directly from `rxjs`

## Quick Decision Guide

| Need | Use |
|------|-----|
| Mutable local component state | `signal` |
| Derived state | `computed` |
| Imperative side effect | `effect` |
| Reactive one-way component input | `input` |
| Writable two-way component input | `model` |
| Custom event output | `output` |
| Reactive child reference | Signal queries |
| Browser-only DOM callback after render | `afterRender` or `afterNextRender` |
| Observable to signal bridge | `toSignal` |
| Signal to Observable bridge | `toObservable` |
| Shared feature state with actions, selectors, and effects | `nova-state-management` |