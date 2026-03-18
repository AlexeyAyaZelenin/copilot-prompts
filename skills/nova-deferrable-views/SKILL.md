---
name: nova-deferrable-views
description: Nova-only Angular v17 deferrable views guidance. Use only when working in the Nova application and implementing or reviewing `@defer`, placeholder/loading/error blocks, defer triggers, prefetching, or testing deferred content.
---

# Nova Deferrable Views

Nova is on Angular v17, where deferrable views were introduced. Use this skill for `@defer` blocks, trigger selection, placeholder strategy, and testing.

Angular v17 documents deferrable views as a major new feature. Treat the v17 semantics here as the source of truth for Nova.

## When to Use This Skill

- Deferring heavy charts, calendars, data grids, or rarely visited widgets
- Reducing initial bundle cost for below-the-fold content
- Adding placeholders, loading indicators, or error states around deferred UI
- Testing or debugging `@defer` behavior
- Reviewing whether a component is actually defer-loadable

## Core Rules

- Use `@defer` for heavy or non-critical content, not as a blanket performance trick
- Prefer `@defer` for below-the-fold or optional UI to avoid layout shift
- Dependencies inside a defer block must be standalone to be truly deferred
- Deferred dependencies must not be referenced elsewhere in the same file outside the `@defer` block, including `ViewChild`-style references
- `@placeholder`, `@loading`, and `@error` dependencies are eagerly loaded
- Always provide a `@placeholder` for user-facing defer blocks unless blank space is intentional
- For nested defer blocks, use different trigger conditions to avoid cascading network requests
- On SSR or SSG, Angular renders only the placeholder state on the server and ignores triggers

## Defer-Loadable Dependencies

Angular v17 can defer:

- Standalone components
- Standalone directives
- Standalone pipes

Angular v17 cannot truly defer a dependency if:

- It is not standalone
- It is referenced from the same file outside the defer block

Transitive dependencies can still be NgModule-based. The direct dependency used by the defer block is what must be standalone.

## Basic Pattern

```html
@defer (on viewport; prefetch on idle) {
<nova-heavy-grid />
} @placeholder (minimum 500ms) {
<nova-grid-skeleton />
} @loading (after 150ms; minimum 750ms) {
<nova-spinner />
} @error {
<div>Unable to load this section.</div>
}
```

This pattern works well for expensive content that is not required for the first paint.

## Trigger Guide

`@defer` supports `on` triggers, `when` conditions, or both.

Common triggers:

- `on idle`: default behavior, good for low-priority content
- `on viewport`: load when placeholder enters the viewport
- `on interaction`: load when the user clicks or presses a trigger element
- `on hover`: load when a user hovers or focuses the trigger area
- `on immediate`: fetch right after the initial client render finishes
- `on timer(500ms)`: fetch after a fixed delay
- `when condition`: fetch when an expression becomes truthy

Rules:

- Multiple `on` triggers are OR conditions
- Mixing `on` and `when` is also OR logic
- `when` is a one-way swap; if the expression later becomes false, Angular does not revert to the placeholder

## Trigger Selection Heuristics

- Use `on viewport` for below-the-fold sections
- Use `on interaction` for drawers, tabs, popovers, and expandable sections
- Use `on idle` for low-priority widgets likely to be needed soon
- Use `prefetch on idle` with `on interaction` when you want faster perceived interaction without paying the full initial render cost
- Avoid `on immediate` for above-the-fold content unless you have a very specific reason

## Placeholders, Loading, and Error States

Use each sub-block intentionally:

- `@placeholder`: what the user sees before loading begins
- `@loading`: what the user sees while deferred code is fetching
- `@error`: what the user sees if loading fails

Guidance:

- Keep placeholders visually stable so the loaded content does not cause major layout shift
- Use the `minimum` parameter to avoid flicker when content loads quickly
- Use `after` on `@loading` so spinners only appear when the load is actually noticeable

## SSR and Hybrid Rendering Behavior

In Angular v17 SSR and SSG:

- The server renders the placeholder state only, or nothing if no placeholder exists
- Trigger logic does not run on the server
- Client-side hydration or rendering will later activate the defer behavior

This makes placeholders important for both performance and user experience.

## Common Pitfalls

- Deferring content that is visible at first paint and causing CLS
- Expecting a non-standalone dependency inside `@defer` to be split into a lazy chunk
- Referencing a deferred component elsewhere in the same file and accidentally forcing eager loading
- Nesting `@defer (on immediate)` blocks that all fire at once
- Forgetting that placeholder and loading dependencies are eagerly loaded

## Testing Deferrable Views

Angular v17 includes TestBed support for stepping through defer states.

```typescript
import { Component } from '@angular/core';
import { DeferBlockBehavior, DeferBlockState, TestBed } from '@angular/core/testing';

it('renders the defer block states', async () => {
    TestBed.configureTestingModule({
        deferBlockBehavior: DeferBlockBehavior.Manual
    });

    @Component({
        standalone: true,
        template: `
            @defer {
                <nova-heavy-grid />
            } @placeholder {
                Placeholder
            } @loading {
                Loading
            }
        `
    })
    class HostComponent {}

    const fixture = TestBed.createComponent(HostComponent);
    const deferBlock = (await fixture.getDeferBlocks())[0];

    await deferBlock.render(DeferBlockState.Loading);
    await deferBlock.render(DeferBlockState.Complete);
});
```

Use manual mode when tests need to assert placeholder, loading, and complete states independently.

## Review Checklist

- Is this content heavy or optional enough to justify `@defer`?
- Are the direct deferred dependencies standalone?
- Is the trigger appropriate for how users actually reach the content?
- Does the placeholder prevent layout shift and avoid empty UI?
- Are nested defer blocks using different trigger conditions?
- Does the test strategy cover the states that matter?