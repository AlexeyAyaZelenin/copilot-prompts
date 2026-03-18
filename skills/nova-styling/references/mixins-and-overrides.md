# Mixins And Overrides

## Flexbox Mixins

```scss
@use 'assets/scss/mixins' as mix;

.container {
    @include mix.flex__space-between;
}

.row {
    @include mix.flex__align--center;
}
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

```text
assets/scss/
├── _variables.scss
├── _mixins.scss
├── _mat-override.scss
├── _flex-layout.scss
└── shared/
    ├── grid/
    ├── inputs/
    ├── spacing/
    └── table/
```

## Global Styles

```scss
@use 'assets/scss/variables' as vars;
@use 'assets/scss/shared/grid';
@use 'assets/scss/shared/nova-shared-styles';
@use 'assets/scss/mixins';
```
