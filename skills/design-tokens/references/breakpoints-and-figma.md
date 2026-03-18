# Breakpoints And Figma Mapping

## Breakpoints

| Name | Value | Usage |
|------|-------|-------|
| `small` | `700px` | Mobile or tablet |
| `laptop` | `1366px` | Laptop screens |
| `standard` | `1600px` | Standard monitors |
| `large_monitor` | `1920px` | Large monitors |

Use with the responsive mixin:

```scss
@use 'assets/scss/mixins';

.component {
    width: 100%;

    @include mixins.respond-to(laptop) {
        width: 50%;
    }
}
```

## Figma Color Mapping

| Figma Color | Nova Variable |
|------------|---------------|
| Primary Blue Grey | `vars.$color-primary` |
| Accent Orange | `vars.$accent` |
| Success Green | `vars.$color-confirmation` |
| Warning Yellow | `vars.$color-warning` |
| Error Red | `vars.$color-error` |
| Neutral White | `vars.$color-neutral` |
| Neutral Black | `vars.$color-neutral-900` |
