# Browser-Only Logic And Hydration Constraints

## Browser-Only Code

Server-rendered components cannot assume browser globals such as `window`, `document`, `navigator`, or layout-dependent DOM APIs are available.

Use render hooks for browser-only work:

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
    selector: 'nova-chart-panel',
    standalone: true,
    changeDetection: ChangeDetectionStrategy.OnPush,
    template: `<div #chartHost></div>`
})
export class ChartPanelComponent {
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

### Rules

- Render hooks run only in the browser
- Always specify a non-default phase
- Do not assume the app is fully hydrated before the callback runs

## Hydration Constraints

Hydration expects the server and client DOM trees to match. Common failure sources in Angular v17:

- Direct DOM manipulation with native browser APIs
- Invalid HTML such as missing `<tbody>` in a table or invalid nesting
- Different `preserveWhitespaces` settings between browser and server builds
- CDN or edge tooling that removes Angular comment nodes
- Custom or noop Zone.js implementations with incompatible timing
