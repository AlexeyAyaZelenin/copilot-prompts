# SCSS Basics

SCSS is the primary styling language in Nova. Styles are component-scoped by default.

## Imports

```scss
@use 'assets/scss/variables' as vars;
@use 'assets/scss/mixins';
```

## Component Style Pattern

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

## Do

- Use SCSS variables from `_variables.scss`
- Use mixins for common patterns
- Scope styles to the component
- Use Angular Material theming system
- Use `@use` instead of `@import`

## Do Not

- Use inline `style` attributes
- Use `::ng-deep` or deep selector hacks
- Use `!important` except rare, documented cases
- Perform math in SCSS when `calc()` in CSS is the real requirement
- Change `_variables.scss` without design-team approval
