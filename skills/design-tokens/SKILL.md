---
name: design-tokens
description: Nova-only design tokens reference for colors, typography, spacing, and breakpoints. Use only when working in the Nova application and implementing UI that requires color values, font specifications, spacing units, or responsive breakpoints. Tokens are defined in assets/scss/_variables.scss - DO NOT modify without design team approval.
---

# Design Tokens

Design tokens are centrally defined in `assets/scss/_variables.scss`.

## Usage

```scss
@use 'assets/scss/variables' as vars;

.my-component {
    color: vars.$color-primary;
    padding: vars.$spacer;
}
````

## Color Palette

### Primary Colors

| Token                | Value     | Usage             |
| -------------------- | --------- | ----------------- |
| `$color-primary`     | `#607d8b` | Primary actions   |
| `$color-primary-50`  | `#eceff1` | Light backgrounds |
| `$color-primary-100` | `#cfd8dc` | Hover states      |
| `$color-primary-200` | `#b0bec5` | Borders           |
| `$color-primary-300` | `#90a4ae` | Disabled states   |
| `$color-primary-600` | `#546e7a` | Darker primary    |

### Semantic Colors

| Token                       | Value     | Usage                |
| --------------------------- | --------- | -------------------- |
| `$color-confirmation`       | `#209f49` | Success states       |
| `$color-confirmation-20`    | `#d2eada` | Success background   |
| `$color-confirmation-hover` | `#bce0c8` | Success hover        |
| `$color-warning`            | `#fec010` | Warning states       |
| `$color-warning-grid`       | `#ffecb7` | Warning in grids     |
| `$color-warning-45`         | `#fee28c` | Warning light        |
| `$color-error`              | `#c72026` | Error states         |
| `$color-error-20`           | `#f4cccc` | Error background     |
| `$color-error-hover`        | `#f1bdbd` | Error hover          |
| `$color-bad-error-danger`   | `#d80015` | Critical errors      |
| `$color-important`          | `#e87722` | Important highlights |
| `$color-important-45`       | `#fbbd5d` | Important light      |

### Neutral Colors

| Token                | Value     | Usage                |
| -------------------- | --------- | -------------------- |
| `$color-neutral`     | `#ffffff` | White backgrounds    |
| `$color-neutral-006` | `#767676` | Accessible gray text |
| `$color-neutral-008` | `#444444` | Dark gray text       |
| `$color-neutral-100` | `#fafafa` | Subtle backgrounds   |
| `$color-neutral-200` | `#f5f5f5` | Light backgrounds    |
| `$color-neutral-300` | `#f0f0f0` | Hover backgrounds    |
| `$color-neutral-400` | `#dedede` | Borders              |
| `$color-neutral-500` | `#c2c2c2` | Disabled borders     |
| `$color-neutral-600` | `#979797` | Placeholder text     |
| `$color-neutral-700` | `#818181` | Secondary text       |
| `$color-neutral-800` | `#606060` | Body text            |
| `$color-neutral-900` | `#3c3c3c` | Dark text            |
| `$dark`              | `#000000` | Black                |

### Chip Colors

| Token              | Value                | Usage          |
| ------------------ | -------------------- | -------------- |
| `$chip-red`        | `#f4cccc`            | Error chips    |
| `$chip-gray`       | `$color-neutral-400` | Neutral chips  |
| `$chip-green`      | `#d2eada`            | Success chips  |
| `$chip-deep-green` | `#209f49`            | Active chips   |
| `$chip-yellow`     | `#fee38c`            | Warning chips  |
| `$chip-blue`       | `#eaf6fc`            | Info chips     |
| `$chip-deep-blue`  | `#d1e1f1`            | Selected chips |
| `$chip-white`      | `#ffffff`            | Default chips  |

### Brand Colors

| Token                  | Value     | Usage             |
| ---------------------- | --------- | ----------------- |
| `$color-brand-primary` | `#034a59` | Brand primary     |
| `$color-brand-neutral` | `#f9fafa` | Brand backgrounds |

## Typography

### Font Family

```scss
$font-family:
    roboto,
    helvetica neue,
    sans-serif;
```

### Font Sizes

| Token                                     | Value    | Usage            |
| ----------------------------------------- | -------- | ---------------- |
| `$nova-card-h-1`                          | `18px`   | Card headings    |
| `$nova-card-h-2`                          | `16px`   | Card subheadings |
| `$nova-grid-font-size`                    | `12px`   | Grid cells       |
| `$nova-grids-kendo-data-cell-line-height` | `15.6px` | Grid line height |
| `$font-nova-alert-text-font-size`         | `14px`   | Alert text       |
| `$font-nova-readonly-value-size`          | `14px`   | Read-only values |

## Spacing

Base spacer unit: `$spacer: 16px`

| Size | Calculation                 | Value |
| ---- | --------------------------- | ----- |
| xs   | `calc(vars.$spacer * 0.25)` | 4px   |
| sm   | `calc(vars.$spacer * 0.5)`  | 8px   |
| md   | `vars.$spacer`              | 16px  |
| lg   | `calc(vars.$spacer * 1.5)`  | 24px  |
| xl   | `calc(vars.$spacer * 2)`    | 32px  |

## Breakpoints

| Name            | Value    | Usage             |
| --------------- | -------- | ----------------- |
| `small`         | `700px`  | Mobile/tablet     |
| `laptop`        | `1366px` | Laptop screens    |
| `standard`      | `1600px` | Standard monitors |
| `large_monitor` | `1920px` | Large monitors    |

Use with responsive mixin:

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

| Figma Color       | Nova Variable              |
| ----------------- | -------------------------- |
| Primary Blue Grey | `vars.$color-primary`      |
| Accent Orange     | `vars.$accent`             |
| Success Green     | `vars.$color-confirmation` |
| Warning Yellow    | `vars.$color-warning`      |
| Error Red         | `vars.$color-error`        |
| Neutral White     | `vars.$color-neutral`      |
| Neutral Black     | `vars.$color-neutral-900`  |

```

```
