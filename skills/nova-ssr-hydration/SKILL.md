---
name: nova-ssr-hydration
description: Nova-only Angular v17 SSR and hydration guidance. Use only when working in the Nova application and implementing or debugging server-side rendering, `provideClientHydration`, transfer cache, `ngSkipHydration`, or browser-only render hooks.
---

# Nova SSR and Hydration

Nova is on Angular v17. Use this skill when work touches server-side rendering, hydration constraints, transfer cache, or browser-only DOM code.

SSR and hydration are tightly connected in Angular v17. Treat them as one workflow: server rendering creates the initial HTML, and hydration restores the app on the client without tearing down that DOM.

## When to Use This Skill

- Enabling or reviewing SSR in Angular v17
- Debugging hydration mismatch errors
- Moving browser-only logic out of server execution paths
- Configuring transfer cache for `HttpClient`
- Deciding whether `ngSkipHydration` is an acceptable temporary workaround

## Core Rules

- Keep server and client DOM output structurally identical
- Avoid direct DOM manipulation during initial render paths
- Treat `ngSkipHydration` as a last resort, not a normal pattern
- Use `afterRender` or `afterNextRender` for browser-only DOM work
- Keep whitespace configuration consistent between browser and server builds
- Make sure CDN optimizations do not strip Angular comment nodes from SSR HTML
- Assume hydration can fail if third-party libraries mutate the DOM before Angular claims it

## SSR Setup

Angular v17 SSR creates a server entry point and uses `CommonEngine` to render the app on the server.

Typical CLI flow:

- New app: `ng new --ssr`
- Existing app: `ng add @angular/ssr`

Angular's SSR guide highlights these files in the default setup:

- `server.ts`
- `src/main.server.ts`
- `src/app/app.config.server.ts`

## Hydration Setup

In custom or explicit setups, add `provideClientHydration()` to the bootstrapping providers used by the client and make sure the equivalent provider setup is present on the server side as well.

```typescript
import { bootstrapApplication } from '@angular/platform-browser';
import { provideClientHydration } from '@angular/platform-browser';
import { provideRouter } from '@angular/router';
import { AppComponent } from './app/app.component';
import { APP_ROUTES } from './app/app.routes';

bootstrapApplication(AppComponent, {
    providers: [
        provideRouter(APP_ROUTES),
        provideClientHydration()
    ]
});
```

In Angular v17 CLI SSR workflows, hydration may already be wired for you. When working in a custom bootstrap flow, verify it explicitly.

## Transfer Cache

Angular v17 caches `HttpClient` GET and HEAD requests on the server and reuses them during the initial client render. This reduces duplicate requests during hydration.

Use `withHttpTransferCacheOptions` when you need to customize the behavior.

```typescript
import { bootstrapApplication } from '@angular/platform-browser';
import {
    provideClientHydration,
    withHttpTransferCacheOptions
} from '@angular/platform-browser';

bootstrapApplication(AppComponent, {
    providers: [
        provideClientHydration(
            withHttpTransferCacheOptions({
                includePostRequests: true
            })
        )
    ]
});
```

Only opt into caching POST requests if the semantics are clearly safe for your use case.

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

Rules:

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

If a component changes DOM structure outside Angular before hydration finishes, Angular may throw DOM mismatch errors.

## `ngSkipHydration`

Use `ngSkipHydration` only when a component cannot yet be made hydration-safe.

```typescript
@Component({
    selector: 'nova-legacy-chart',
    standalone: true,
    host: { ngSkipHydration: 'true' },
    template: `<div></div>`
})
export class LegacyChartComponent {}
```

Rules:

- Apply it only to component host nodes
- Do not put it on the root app component unless you intend to effectively disable hydration for the whole app
- Treat it as temporary technical debt and remove it after the component is refactored

## Third-Party Library Guidance

Libraries that manipulate the DOM directly, such as charting or visualization libraries, are common hydration problems.

Preferred order:

1. Refactor to use Angular-friendly rendering patterns.
2. Move imperative setup into render hooks.
3. Use `ngSkipHydration` only if the component still cannot hydrate safely.

## Common Pitfalls

- Using `window` or `document` during component construction or template evaluation
- Assuming hydration tolerates direct `appendChild`, `innerHTML`, or DOM reparenting
- Forgetting that SSR plus service worker means only the first request is server-rendered
- Enabling CDN HTML optimization that strips Angular comment nodes
- Leaving mismatched whitespace settings between browser and server tsconfig files

## Review Checklist

- Does this code produce the same DOM structure on the server and client?
- Are browser-only APIs isolated to render hooks or other browser-only paths?
- Is transfer cache behavior correct for the requests involved?
- Is `ngSkipHydration` being used only as a temporary escape hatch?
- Could a third-party DOM library be causing the mismatch?