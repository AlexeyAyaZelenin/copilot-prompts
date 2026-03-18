# For Blocks And Tracking

## Core Rules

- Always provide a stable `track` expression for `@for`
- Avoid `track $index` unless the list is static and has no stable identity
- Use `@empty` instead of separate wrapper conditionals for empty collection states
- Prefer `Array` values when possible for best `@for` performance

## `@for`

```html
@for (job of jobs(); track job.jobId; let idx = $index, first = $first) {
<div>
    <span>{{ idx + 1 }}</span>
    <span>{{ job.title }}</span>
    @if (first) {
    <span>Primary</span>
    }
</div>
} @empty {
<div>No jobs found.</div>
}
```

## Context Variables

- `$count`
- `$index`
- `$first`
- `$last`
- `$even`
- `$odd`

Use aliases when nesting loops so the template stays readable.

## Tracking Guidance

- Prefer business identifiers such as `item.id`, `job.jobId`, or `user.userId`
- If existing code already has a reliable `trackBy` helper, you can temporarily call it: `track itemId($index, item)`
- Avoid object references as identities when immutable refreshes recreate objects often
- Use `track $index` only for truly static lists that never reorder
