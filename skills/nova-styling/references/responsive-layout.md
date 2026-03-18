# Responsive Layout

## Breakpoint Mixin

```scss
@use 'assets/scss/mixins';

.component {
    width: 100%;

    @include mixins.respond-to(laptop) {
        width: 50%;
    }

    @include mixins.respond-to(large_monitor) {
        width: 33%;
    }
}
```

## Available Breakpoints

| Name | Value |
|------|-------|
| `small` | `700px` |
| `laptop` | `1366px` |
| `standard` | `1600px` |
| `large_monitor` | `1920px` |

## Flex Layout Utilities

```scss
@use 'assets/scss/flex-layout';

// xs: screen width <= 599px
// sm: 600px - 959px
// md: 960px - 1279px
// lg: 1280px - 1919px
// xl: >= 1920px
```

## Layout Patterns

### Flex layout

```scss
.flex-container {
    @include mixins.flex__space-between;
    gap: vars.$spacer;
}
```

### Grid layout

```scss
.grid-layout {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: vars.$spacer;
}
```

### Column to row pattern

```scss
.responsive-layout {
    display: flex;
    flex-direction: column;

    @include mixins.respond-to(laptop) {
        flex-direction: row;
    }
}
```
