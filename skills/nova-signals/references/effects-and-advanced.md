# Effects And Advanced Reactivity

## Use This Reference When

- Logging or persisting signal-backed state
- Reacting to input changes without `ngOnChanges`
- Integrating timers, third-party libraries, or imperative DOM APIs
- Avoiding accidental dependencies inside reactive code

## Core Rules

- Use `effect` for side effects only
- Effects run at least once and rerun when their tracked signal reads change
- Effects track dependencies dynamically based on what was read during the latest execution
- Effects run asynchronously during change detection in Angular v17
- Creating an effect requires an injection context unless you pass an `Injector`
- Effects are destroyed with their enclosing component, directive, or service

## Good Uses

- Analytics or logging
- Syncing to `localStorage` or `sessionStorage`
- Starting imperative widget or chart updates
- Responding to signal inputs when `computed` is not enough

## Avoid

- Propagating state from one signal into another
- Replacing straightforward `computed` logic with imperative code
- Creating circular update flows
- Writing to signals from effects unless there is no cleaner design; Angular v17 blocks this by default unless explicitly enabled

## Cleanup

- Use the `onCleanup` callback to cancel timers, requests, or subscriptions started by the effect
- Cleanup runs before the next effect execution and when the effect is destroyed

```typescript
import { effect } from '@angular/core';

private readonly autosaveEffect = effect((onCleanup) => {
    const draft = this.formValue();
    const timeoutId = window.setTimeout(() => this.saveDraft(draft), 500);

    onCleanup(() => window.clearTimeout(timeoutId));
});
```

## Advanced Tools

### `untracked`

- Use `untracked` when a signal read is incidental and should not become a dependency
- This is useful for logging helpers or audit calls that happen inside an effect

```typescript
import { effect, untracked } from '@angular/core';

private readonly auditEffect = effect(() => {
    const user = this.currentUser();
    const count = untracked(this.itemCount);

    this.auditService.record({ user, count });
});
```

### Equality functions

- Pass `equal` to `signal` or `computed` only when semantically identical values should not trigger downstream work
- Prefer simple immutable updates first; custom equality is a targeted optimization, not the default