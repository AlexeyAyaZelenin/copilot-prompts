# Token And Component Mapping

## Color Mapping

| Figma Color | Nova Variable |
|------------|---------------|
| Primary Blue Grey | `vars.$color-primary` |
| Accent Orange | `vars.$accent` |
| Success Green | `vars.$color-confirmation` |
| Warning Yellow | `vars.$color-warning` |
| Error Red | `vars.$color-error` |
| Neutral White | `vars.$color-neutral` |
| Neutral Black | `vars.$color-neutral-900` |

## Typography Mapping

```scss
.heading-1 {
    font-size: vars.$nova-card-h-1;
}

.heading-2 {
    font-size: vars.$nova-card-h-2;
}

.body-text {
    font-family: vars.$font-family;
    font-size: 14px;
}

.grid-cell {
    font-size: vars.$nova-grid-font-size;
    line-height: vars.$nova-grids-kendo-data-cell-line-height;
}
```

## Spacing Mapping

| Figma Size | SCSS | Value |
|-----------|------|-------|
| XS | `calc(vars.$spacer * 0.25)` | `4px` |
| SM | `calc(vars.$spacer * 0.5)` | `8px` |
| MD | `vars.$spacer` | `16px` |
| LG | `calc(vars.$spacer * 1.5)` | `24px` |
| XL | `calc(vars.$spacer * 2)` | `32px` |

## Component Selection Guide

| Figma Element | Nova Implementation |
|--------------|---------------------|
| Primary button | `<button mat-flat-button color="primary">` |
| Secondary button | `<button mat-stroked-button color="secondary">` |
| Text input | `<mat-form-field appearance="outline">` |
| Dropdown | `<mat-select>` inside `<mat-form-field>` |
| Data table | `<kendo-grid>` |
| Card container | `<mat-card appearance="raised">` |
| Status chip | `<mat-chip>` with chip color vars |
| Icon | `<mat-icon>` Material Icons |

## Responsive Layout Reminder

```scss
.responsive-layout {
    display: flex;
    flex-direction: column;

    @include mixins.respond-to(laptop) {
        flex-direction: row;
    }
}
```

## Design Source

- InVision DSM: https://projects.invisionapp.com/dsm/aya-healthcare-design-system/nova-style-guide/
