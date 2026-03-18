# Skip Hydration And Review

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

### Rules

- Apply it only to component host nodes
- Do not put it on the root app component unless you intend to disable hydration broadly
- Treat it as temporary technical debt and remove it after refactoring

## Third-Party Library Guidance

Libraries that manipulate the DOM directly are common hydration problems.

Preferred order:

1. Refactor to use Angular-friendly rendering patterns.
2. Move imperative setup into render hooks.
3. Use `ngSkipHydration` only if the component still cannot hydrate safely.

## Common Pitfalls

- Using `window` or `document` during construction or template evaluation
- Assuming hydration tolerates `appendChild`, `innerHTML`, or DOM reparenting
- Forgetting that SSR plus service worker means only the first request is server-rendered
- Enabling CDN HTML optimization that strips Angular comment nodes
- Leaving mismatched whitespace settings between browser and server builds

## Review Checklist

- Does this code produce the same DOM structure on the server and client?
- Are browser-only APIs isolated to render hooks or other browser-only paths?
- Is transfer cache behavior correct for the requests involved?
- Is `ngSkipHydration` being used only as a temporary escape hatch?
- Could a third-party DOM library be causing the mismatch?
