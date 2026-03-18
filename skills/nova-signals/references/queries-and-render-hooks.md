# Signal Queries And Render Hooks

## Use This Reference When

- Replacing `@ViewChild`, `@ViewChildren`, `@ContentChild`, or `@ContentChildren`
- Reacting to child references in `computed` or `effect`
- Doing browser-only DOM reads or writes after render

## Signal Queries

- `viewChild` and `viewChildren` read from the component's own template
- `contentChild` and `contentChildren` read from projected content
- Query declaration functions are compiler-recognized and can only be used in component or directive property initializers
- Child queries return `undefined` until a result is available unless marked `required`
- Children queries return an empty array until results are available
- Required child queries remove `undefined` from the type but throw if no match exists or if the query is read before results are ready
- Signal query results are computed lazily when read
- Results can change over time as `@if`, `@for`, or imperative view changes add or remove matches
- `read` lets you choose a different token for matched nodes
- Content queries also support `descendants`

```typescript
import { ChangeDetectionStrategy, Component, ElementRef, computed, viewChild, viewChildren } from '@angular/core';

@Component({
    selector: 'nova-toolbar',
    standalone: true,
    changeDetection: ChangeDetectionStrategy.OnPush,
    template: `
        <input #searchBox type="search" />
        <button #action type="button">Save</button>
        <button #action type="button">Cancel</button>
    `
})
export class ToolbarComponent {
    readonly searchBox = viewChild<ElementRef<HTMLInputElement>>('searchBox');
    readonly actionButtons = viewChildren<ElementRef<HTMLButtonElement>>('action');
    readonly hasActions = computed(() => this.actionButtons().length > 0);
}
```

## Render Hooks

- `afterRender()` runs after each render
- `afterNextRender()` runs once after the next render
- Both run only in the browser
- Always specify a non-default `phase` to avoid performance problems
- Do not assume hydration is complete when the callback runs
- Use these hooks for imperative DOM integration, measurements, or third-party widgets
- Do not use render hooks for normal reactive state changes that belong in signals, `computed`, or template bindings

```typescript
import {
    AfterRenderPhase,
    ChangeDetectionStrategy,
    Component,
    ElementRef,
    afterNextRender,
    viewChild
} from '@angular/core';

@Component({
    selector: 'nova-chart-host',
    standalone: true,
    changeDetection: ChangeDetectionStrategy.OnPush,
    template: `<div #chartHost></div>`
})
export class ChartHostComponent {
    readonly chartHost = viewChild.required<ElementRef<HTMLDivElement>>('chartHost');

    constructor() {
        afterNextRender(() => {
            this.initializeChart(this.chartHost().nativeElement);
        }, { phase: AfterRenderPhase.Write });
    }

    private initializeChart(element: HTMLDivElement): void {
        void element;
    }
}
```