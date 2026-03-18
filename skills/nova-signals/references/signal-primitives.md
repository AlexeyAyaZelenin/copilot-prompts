# Signal Primitives

## Use This Reference When

- Replacing component-local `BehaviorSubject`, mutable fields, or template getters
- Building a local view model with `computed`
- Debugging why an `OnPush` template does or does not update

## Core Rules

- Use `signal(initialValue)` for mutable local state
- Read signals by calling them, such as `this.count()`
- Use `.set(nextValue)` when you already know the next value
- Use `.update((current) => nextValue)` when the next value depends on the current one
- Prefer immutable updates for arrays and objects so downstream code sees clear reference changes
- Use `computed` for derived values; it is lazy, memoized, and read-only
- Keep signal state local unless the state truly belongs in Store or ComponentStore

## Writable Signals Example

```typescript
import { ChangeDetectionStrategy, Component, computed, signal } from '@angular/core';

@Component({
    selector: 'nova-counter',
    standalone: true,
    changeDetection: ChangeDetectionStrategy.OnPush,
    template: `
        <button type="button" (click)="decrement()">-</button>
        <span>{{ count() }}</span>
        <button type="button" (click)="increment()">+</button>
        <p>{{ countLabel() }}</p>
    `
})
export class CounterComponent {
    readonly count = signal(0);
    readonly countLabel = computed(() => `Current count: ${this.count()}`);

    increment(): void {
        this.count.update((count) => count + 1);
    }

    decrement(): void {
        this.count.update((count) => count - 1);
    }
}
```

## Computed Behavior

- Computed signals only track the signals they actually read
- Dependencies can be added or removed when control flow inside the derivation changes
- Because results are memoized, expensive filtering or mapping is usually fine inside `computed`
- Do not try to `.set()` or `.update()` a computed signal

## `OnPush` Integration

- When an `OnPush` component reads a signal in its template, Angular tracks that read as a dependency
- Updating the signal marks the component for checking on the next change detection pass
- This removes most local `markForCheck()` calls for normal signal-driven UI state
- Mutating nested data in place can still create confusing behavior if consumers rely on reference changes

## Choose Something Else When

- The state is shared across routes or features and needs actions, selectors, or effects
- The component needs RxJS-heavy orchestration that already fits ComponentStore or Store better