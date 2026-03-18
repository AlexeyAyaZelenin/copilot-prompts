# Color Tokens

Design tokens are centrally defined in `assets/scss/_variables.scss`.

## Usage

```scss
@use 'assets/scss/variables' as vars;

.my-component {
    color: vars.$color-primary;
    padding: vars.$spacer;
}
```

## Primary Colors

| Token | Value | Usage |
|------|-------|-------|
| `$color-primary` | `#607d8b` | Primary actions |
| `$color-primary-50` | `#eceff1` | Light backgrounds |
| `$color-primary-100` | `#cfd8dc` | Hover states |
| `$color-primary-200` | `#b0bec5` | Borders |
| `$color-primary-300` | `#90a4ae` | Disabled states |
| `$color-primary-600` | `#546e7a` | Darker primary |

## Semantic Colors

| Token | Value | Usage |
|------|-------|-------|
| `$color-confirmation` | `#209f49` | Success states |
| `$color-confirmation-20` | `#d2eada` | Success background |
| `$color-confirmation-hover` | `#bce0c8` | Success hover |
| `$color-warning` | `#fec010` | Warning states |
| `$color-warning-grid` | `#ffecb7` | Warning in grids |
| `$color-warning-45` | `#fee28c` | Warning light |
| `$color-error` | `#c72026` | Error states |
| `$color-error-20` | `#f4cccc` | Error background |
| `$color-error-hover` | `#f1bdbd` | Error hover |
| `$color-bad-error-danger` | `#d80015` | Critical errors |
| `$color-important` | `#e87722` | Important highlights |
| `$color-important-45` | `#fbbd5d` | Important light |

## Neutral And Brand Colors

| Token | Value | Usage |
|------|-------|-------|
| `$color-neutral` | `#ffffff` | White backgrounds |
| `$color-neutral-006` | `#767676` | Accessible gray text |
| `$color-neutral-008` | `#444444` | Dark gray text |
| `$color-neutral-100` | `#fafafa` | Subtle backgrounds |
| `$color-neutral-200` | `#f5f5f5` | Light backgrounds |
| `$color-neutral-300` | `#f0f0f0` | Hover backgrounds |
| `$color-neutral-400` | `#dedede` | Borders |
| `$color-neutral-500` | `#c2c2c2` | Disabled borders |
| `$color-neutral-600` | `#979797` | Placeholder text |
| `$color-neutral-700` | `#818181` | Secondary text |
| `$color-neutral-800` | `#606060` | Body text |
| `$color-neutral-900` | `#3c3c3c` | Dark text |
| `$dark` | `#000000` | Black |
| `$color-brand-primary` | `#034a59` | Brand primary |
| `$color-brand-neutral` | `#f9fafa` | Brand backgrounds |

## Chip Colors

| Token | Value | Usage |
|------|-------|-------|
| `$chip-red` | `#f4cccc` | Error chips |
| `$chip-gray` | `$color-neutral-400` | Neutral chips |
| `$chip-green` | `#d2eada` | Success chips |
| `$chip-deep-green` | `#209f49` | Active chips |
| `$chip-yellow` | `#fee38c` | Warning chips |
| `$chip-blue` | `#eaf6fc` | Info chips |
| `$chip-deep-blue` | `#d1e1f1` | Selected chips |
| `$chip-white` | `#ffffff` | Default chips |
