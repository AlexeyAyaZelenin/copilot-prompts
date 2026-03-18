---
name: nova-control-flow
description: Nova-only Angular v17 built-in control flow guidance. Use only when working in the Nova application and implementing or migrating `@if`, `@for`, `@switch`, `@empty`, or replacing `*ngIf`, `*ngFor`, and `ngSwitch`.
---

# Nova Control Flow

Nova is on Angular v17, where built-in control flow blocks were introduced. Use this skill for deeper guidance on `@if`, `@for`, and `@switch` beyond the short rules in `nova-angular-standards`.

Angular v17 documents built-in control flow as developer preview. Follow the v17 behavior and syntax here instead of newer Angular docs.

## When to Use This Skill

- Migrating `*ngIf`, `*ngFor`, or `ngSwitch` to built-in control flow
- Reviewing `track` expressions in `@for` blocks
- Replacing `else` templates with inline `@else` branches
- Adding `@empty` states for collections
- Debugging nested control flow or contextual variables like `$index`

## Core Rules

- Use `@if`, `@else if`, `@else`, `@for`, `@empty`, and `@switch` in new Nova templates
- Keep conditional expressions readable; move complex logic to the component class or a computed signal
- Always provide a stable `track` expression for `@for`
- Avoid `track $index` unless the list is static and has no stable identity
- Use `@empty` instead of separate wrapper conditionals for empty collection states
- Prefer `Array` values when possible for best `@for` performance

## `@if`

Use `@if` for conditional rendering and `@else if` or `@else` for alternate branches.

```html
@if (vm().canEdit) {
<button type="button">Edit</button>
} @else if (vm().isReadOnly) {
<span>Read only</span>
} @else {
<span>Unavailable</span>
}
```

You can capture the result of an expression with `as`.

```html
@if (users$ | async; as users) {
<span>{{ users.length }}</span>
}
```

## `@for`

Use `@for` for iteration. Angular v17 requires a `track` expression so the framework can perform minimal DOM updates.

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

Context variables available inside `@for` include:

- `$count`
- `$index`
- `$first`
- `$last`
- `$even`
- `$odd`

Use aliases when nesting loops so the template stays readable.

### Tracking Guidance

Choose a `track` expression with stable identity:

- Prefer business identifiers such as `item.id`, `job.jobId`, or `user.userId`
- If existing code already has a reliable `trackBy` helper, you can temporarily call it: `track itemId($index, item)`
- Avoid object references as identities when immutable refreshes recreate objects often
- Use `track $index` only for truly static lists that never reorder

## `@switch`

Use `@switch` for mutually exclusive branches driven by one expression.

```html
@switch (vm().status) {
  @case ('loading') {
  <nova-spinner />
  }
  @case ('error') {
  <div>Failed to load.</div>
  }
  @default {
  <div>Ready</div>
  }
}
```

Rules:

- `@switch` compares using `===`
- There is no fallthrough
- `@default` is optional

## Migration Patterns

### `*ngIf` to `@if`

Before:

```html
<div *ngIf="user; else noUser">{{ user.name }}</div>
<ng-template #noUser>No user</ng-template>
```

After:

```html
@if (user) {
<div>{{ user.name }}</div>
} @else {
<div>No user</div>
}
```

### `*ngFor` to `@for`

Before:

```html
<div *ngFor="let item of items; trackBy: trackItem">{{ item.name }}</div>
```

After:

```html
@for (item of items; track trackItem($index, item)) {
<div>{{ item.name }}</div>
}
```

Prefer simplifying that temporary call to a direct identity expression once the migration is stable.

### `ngSwitch` to `@switch`

Before:

```html
<ng-container [ngSwitch]="status">
    <div *ngSwitchCase="'ready'">Ready</div>
    <div *ngSwitchDefault>Fallback</div>
</ng-container>
```

After:

```html
@switch (status) {
  @case ('ready') {
  <div>Ready</div>
  }
  @default {
  <div>Fallback</div>
  }
}
```

## Behavioral Differences From Legacy Structural Directives

- `@for` requires `track`; `*ngFor` did not
- `@for` supports `@empty`
- `@for` does not support custom `IterableDiffer` implementations
- `@switch` supports better type narrowing and does not require wrapper container boilerplate

## Common Pitfalls

- Translating old `trackBy` logic to `track $index` and losing stable identity
- Leaving complex boolean logic inline in the template
- Forgetting `@empty` and duplicating no-data logic elsewhere
- Nesting many `@if` branches where a computed view model would be clearer
- Assuming `@switch` supports fallthrough like JavaScript `switch`

## Review Checklist

- Are all new templates using built-in control flow instead of structural directives?
- Does every `@for` have a stable `track` expression?
- Should an `@empty` block exist for this collection?
- Would a computed signal or getter make the template easier to read?
- Was old `trackBy` logic migrated safely instead of simplified incorrectly?