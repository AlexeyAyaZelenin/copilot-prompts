# Component Authoring APIs

Use this reference for the Angular v17 function-based authoring APIs that shape component contracts. In v17, `input()`, `model()`, and `output()` were still developer preview and should be treated as version-specific.

## Signal Inputs

- Declare `input()` and `input.required()` as class property initializers
- `input<T>()` creates an optional input and returns `T | undefined` when no initial value is supplied
- `input(initialValue)` creates an optional input with a concrete default
- `input.required<T>()` creates a required input without a dummy initializer
- Inputs are read-only signals, so consume them with `this.someInput()`
- Use `computed` for derived values and `effect` for side effects when inputs change
- Use `alias` when the public binding name should differ from the class member
- Use `transform` only for pure coercion or parsing; do not use transforms to change meaning

```typescript
import { ChangeDetectionStrategy, Component, computed, input } from '@angular/core';

@Component({
    selector: 'nova-user-badge',
    standalone: true,
    changeDetection: ChangeDetectionStrategy.OnPush,
    template: `{{ displayName() }}`
})
export class UserBadgeComponent {
    readonly firstName = input.required<string>();
    readonly lastName = input<string>('');
    readonly displayName = computed(() => `${this.firstName()} ${this.lastName()}`.trim());
}
```

## Model Inputs

- `model()` creates a writable input intended for two-way binding
- Model inputs can be bound to either a signal or a plain property in the parent
- Angular creates an implicit `<name>Change` output for every model input
- Model inputs support `required` and `alias`
- Model inputs do not support transforms
- Use them for components whose job is to modify a value, such as custom controls
- Do not use `model()` just to avoid declaring normal local component state

```typescript
import { ChangeDetectionStrategy, Component, input, model } from '@angular/core';

@Component({
    selector: 'nova-toggle',
    standalone: true,
    changeDetection: ChangeDetectionStrategy.OnPush,
    template: `
        <button type="button" [disabled]="disabled()" (click)="toggle()">
            {{ checked() ? 'On' : 'Off' }}
        </button>
    `
})
export class ToggleComponent {
    readonly checked = model(false);
    readonly disabled = input(false);

    toggle(): void {
        this.checked.update((checked) => !checked);
    }
}
```

## Outputs

- `output<T>()` declares a component or directive output and returns an emitter ref
- Emit values with `.emit(...)`
- Parents can consume the output through template event bindings or programmatic subscription
- In Nova, prefer `output()` for new function-based component APIs so the contract matches the other signal-era authoring APIs
- Keep output payloads focused and typed

```typescript
import { ChangeDetectionStrategy, Component, output, signal } from '@angular/core';

@Component({
    selector: 'nova-stepper',
    standalone: true,
    changeDetection: ChangeDetectionStrategy.OnPush,
    template: `
        <button type="button" (click)="previous()">Back</button>
        <button type="button" (click)="next()">Next</button>
    `
})
export class StepperComponent {
    readonly step = signal(0);
    readonly stepChanged = output<number>();

    next(): void {
        this.step.update((step) => step + 1);
        this.stepChanged.emit(this.step());
    }

    previous(): void {
        this.step.update((step) => Math.max(0, step - 1));
        this.stepChanged.emit(this.step());
    }
}
```