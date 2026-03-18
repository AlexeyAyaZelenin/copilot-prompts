---
name: nova-styling
description: Nova-only SCSS styling guidelines including mixins, responsive design, and Material overrides. Use only when working in the Nova application and writing component styles, applying responsive breakpoints, using flexbox utilities, or overriding Material components. Covers DO/DON'T rules for styling.
---

# Nova Styling

SCSS is the primary styling language. Styles are component-scoped by default.

## SCSS Imports

```scss
@use 'assets/scss/variables' as vars;
@use 'assets/scss/mixins';
````

## Component Styles Pattern

```scss
@use 'assets/scss/variables' as vars;
@use 'assets/scss/mixins';

:host {
    display: block;
    padding: vars.$spacer;
}

.header {
    color: vars.$color-primary;
    @include mixins.flex__space-between;
}
```

## Styling Rules

### ✅ DO

- Use SCSS variables from `_variables.scss`
- Use mixins for common patterns
- Scope styles to component
- Use Angular Material theming system
- Use `@use` instead of `@import`

### ❌ DON'T

- Use inline `style` attribute
- Use `::ng-deep` or `:host` for deep selectors
- Use `!important` (except rare, documented cases)
- Perform math in SCSS (use `calc()` in CSS instead)
- Change `_variables.scss` without design team approval

## Flexbox Mixins

```scss
@use 'assets/scss/mixins' as mix;

// Space between items
.container {
    @include mix.flex__space-between;
}

// Center alignment
.row {
    @include mix.flex__align--center;
}
```

## Responsive Design

### Breakpoint Mixin

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

### Available Breakpoints

| Name            | Value  |
| --------------- | ------ |
| `small`         | 700px  |
| `laptop`        | 1366px |
| `standard`      | 1600px |
| `large_monitor` | 1920px |

### Flex Layout Classes

```scss
@use 'assets/scss/flex-layout';

// xs: screen width <= 599px
// sm: 600px - 959px
// md: 960px - 1279px
// lg: 1280px - 1919px
// xl: >= 1920px
```

## Icon Sizing

```scss
@use 'assets/scss/mixins' as mix;

.custom-icon {
    @include mix.mat-icon-size(18px);
}

.large-icon {
    @include mix.mat-icon-size(24px);
}
```

## Color Opacity

```scss
@use 'assets/scss/mixins' as mix;
@use 'assets/scss/variables' as vars;

.overlay {
    background: mix.opaque(vars.$color-primary, 0.5);
}
```

## Layout Patterns

### Flexbox Layout

```html
<div class="flex-container">
    <div class="flex-item">Item 1</div>
    <div class="flex-item">Item 2</div>
</div>
```

```scss
.flex-container {
    @include mixins.flex__space-between;
    gap: vars.$spacer;
}
```

### Grid Layout

```scss
.grid-layout {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: vars.$spacer;
}
```

### Responsive Layout

```scss
.responsive-layout {
    display: flex;
    flex-direction: column;

    @include mixins.respond-to(laptop) {
        flex-direction: row;
    }
}
```

## Material Overrides

Overrides are centralized in `assets/scss/_mat-override.scss`:

```scss
@use 'assets/scss/variables' as vars;

@mixin mat-override($theme) {
    .mat-mdc-raised-button.mat-primary {
        &:hover {
            background-color: vars.$color-primary-600;
        }
    }
}
```

## File Organization

```
assets/scss/
├── _variables.scss      # Design tokens
├── _mixins.scss         # SCSS utilities
├── _mat-override.scss   # Material overrides
├── _flex-layout.scss    # Responsive utilities
└── shared/              # Shared component styles
    ├── grid/
    ├── inputs/
    ├── spacing/
    └── table/
```

## Global Styles

```scss
// src/styles.scss
@use 'assets/scss/variables' as vars;
@use 'assets/scss/shared/grid';
@use 'assets/scss/shared/nova-shared-styles';
@use 'assets/scss/mixins';
```
