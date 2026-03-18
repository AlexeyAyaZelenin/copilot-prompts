# Migration And Review

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

Prefer simplifying that temporary helper call to a direct identity expression once the migration is stable.

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

## Behavioral Differences

- `@for` requires `track`; `*ngFor` did not
- `@for` supports `@empty`
- `@for` does not support custom `IterableDiffer` implementations
- `@switch` supports better type narrowing and removes wrapper boilerplate

## Common Pitfalls

- Translating old `trackBy` logic to `track $index`
- Leaving complex boolean logic inline in the template
- Forgetting `@empty` and duplicating no-data logic elsewhere
- Nesting many `@if` branches where a computed view model would be clearer
- Assuming `@switch` supports JavaScript-style fallthrough

## Review Checklist

- Are all new templates using built-in control flow instead of structural directives?
- Does every `@for` have a stable `track` expression?
- Should an `@empty` block exist for this collection?
- Would a computed signal or getter make the template easier to read?
- Was old `trackBy` logic migrated safely instead of simplified incorrectly?
