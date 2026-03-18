# Templates And Forms

## Template Standards

```html
@if (isVisible) {
<div>Content</div>
} @else {
<div>Alternative</div>
}

@for (item of items; track item.id) {
<span>{{ item.name }}</span>
}

@if (shouldDisplay) {
<div>Content</div>
}

@defer (on viewport) {
<nova-heavy-widget />
} @placeholder {
<nova-widget-skeleton />
}
```

### Rules

- Always provide a stable `track` expression in `@for`
- Avoid `track $index` unless the list has no unique identifier
- Keep template expressions simple; move complex logic to computed signals or getters

## Typed Forms

```typescript
interface LoginForm {
    email: FormControl<string>;
    password: FormControl<string>;
    rememberMe: FormControl<boolean>;
}

form = new FormGroup<LoginForm>({
    email: new FormControl('', { nonNullable: true }),
    password: new FormControl('', { nonNullable: true }),
    rememberMe: new FormControl(false, { nonNullable: true })
});
```
