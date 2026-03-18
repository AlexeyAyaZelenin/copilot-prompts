# If And Switch Blocks

Nova is on Angular v17, where built-in control flow blocks were introduced. Angular v17 documents them as developer preview, so prefer the v17 behavior captured here.

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

You can capture an expression result with `as`.

```html
@if (users$ | async; as users) {
<span>{{ users.length }}</span>
}
```

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

### Rules

- `@switch` compares using `===`
- There is no fallthrough
- `@default` is optional
