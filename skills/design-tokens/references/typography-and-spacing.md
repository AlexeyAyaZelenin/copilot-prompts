# Typography And Spacing

## Font Family

```scss
$font-family:
    roboto,
    helvetica neue,
    sans-serif;
```

## Font Sizes

| Token | Value | Usage |
|------|-------|-------|
| `$nova-card-h-1` | `18px` | Card headings |
| `$nova-card-h-2` | `16px` | Card subheadings |
| `$nova-grid-font-size` | `12px` | Grid cells |
| `$nova-grids-kendo-data-cell-line-height` | `15.6px` | Grid line height |
| `$font-nova-alert-text-font-size` | `14px` | Alert text |
| `$font-nova-readonly-value-size` | `14px` | Read-only values |

## Spacing

Base spacer unit: `$spacer: 16px`

| Size | Calculation | Value |
|------|-------------|-------|
| xs | `calc(vars.$spacer * 0.25)` | `4px` |
| sm | `calc(vars.$spacer * 0.5)` | `8px` |
| md | `vars.$spacer` | `16px` |
| lg | `calc(vars.$spacer * 1.5)` | `24px` |
| xl | `calc(vars.$spacer * 2)` | `32px` |
