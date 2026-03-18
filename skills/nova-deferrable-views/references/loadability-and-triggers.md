# Loadability And Triggers

Nova is on Angular v17, where deferrable views were introduced. Prefer the v17 semantics here for Nova.

## Core Rules

- Use `@defer` for heavy or non-critical content, not as a blanket performance trick
- Prefer `@defer` for below-the-fold or optional UI to avoid layout shift
- Dependencies inside a defer block must be standalone to be truly deferred
- Deferred dependencies must not be referenced elsewhere in the same file outside the `@defer` block
- For nested defer blocks, use different trigger conditions to avoid cascading requests

## Defer-Loadable Dependencies

Angular v17 can defer:

- Standalone components
- Standalone directives
- Standalone pipes

Angular v17 cannot truly defer a dependency if:

- It is not standalone
- It is referenced from the same file outside the defer block

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

## Trigger Guide

Common triggers:

- `on idle`
- `on viewport`
- `on interaction`
- `on hover`
- `on immediate`
- `on timer(500ms)`
- `when condition`

### Rules

- Multiple `on` triggers are OR conditions
- Mixing `on` and `when` is also OR logic
- `when` is one-way; Angular does not revert to the placeholder when it becomes false later

## Trigger Selection Heuristics

- Use `on viewport` for below-the-fold sections
- Use `on interaction` for drawers, tabs, popovers, and expandable sections
- Use `on idle` for low-priority widgets likely to be needed soon
- Use `prefetch on idle` with `on interaction` for faster perceived interaction
- Avoid `on immediate` for above-the-fold content unless there is a specific reason
