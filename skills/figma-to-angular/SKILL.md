---
name: figma-to-angular
description: Nova-only guidelines for converting Figma designs to Angular components. Use only when working in the Nova application and implementing UI from Figma mockups, mapping design elements to Nova tokens, or creating new components from design specifications. Includes implementation checklist and validation steps.
---

# Figma to Angular Implementation

Convert Figma designs to Nova Angular components using these guidelines.

## Implementation Checklist

- [ ] Create standalone component with `nova-` prefix
- [ ] Import required Material/Kendo modules
- [ ] Use design tokens from `_variables.scss`
- [ ] Apply responsive breakpoints using mixins
- [ ] Use new Angular control flow (`@if`, `@for`)
- [ ] Implement strict TypeScript (no `any`)
- [ ] Use non-relative imports (`src/app/...`)
- [ ] Create unit tests with Spectator
- [ ] Verify compilation in `nova-watch-start-no-open` task
- [ ] Test responsive behavior at all breakpoints
- [ ] Validate accessibility (ARIA labels, keyboard navigation)

## Color Mapping

| Figma Color       | Nova Variable              |
| ----------------- | -------------------------- |
| Primary Blue Grey | `vars.$color-primary`      |
| Accent Orange     | `vars.$accent`             |
| Success Green     | `vars.$color-confirmation` |
| Warning Yellow    | `vars.$color-warning`      |
| Error Red         | `vars.$color-error`        |
| Neutral White     | `vars.$color-neutral`      |
| Neutral Black     | `vars.$color-neutral-900`  |

## Typography Mapping

```scss
// Headings
.heading-1 {
    font-size: vars.$nova-card-h-1;
} // 18px
.heading-2 {
    font-size: vars.$nova-card-h-2;
} // 16px

// Body text
.body-text {
    font-family: vars.$font-family;
    font-size: 14px;
}

// Grid text
.grid-cell {
    font-size: vars.$nova-grid-font-size; // 12px
    line-height: vars.$nova-grids-kendo-data-cell-line-height; // 15.6px
}
```

## Spacing Mapping

| Figma Size | SCSS                        | Value |
| ---------- | --------------------------- | ----- |
| XS         | `calc(vars.$spacer * 0.25)` | 4px   |
| SM         | `calc(vars.$spacer * 0.5)`  | 8px   |
| MD         | `vars.$spacer`              | 16px  |
| LG         | `calc(vars.$spacer * 1.5)`  | 24px  |
| XL         | `calc(vars.$spacer * 2)`    | 32px  |

## Component Selection Guide

| Figma Element    | Nova Implementation                             |
| ---------------- | ----------------------------------------------- |
| Primary button   | `<button mat-flat-button color="primary">`      |
| Secondary button | `<button mat-stroked-button color="secondary">` |
| Text input       | `<mat-form-field appearance="outline">`         |
| Dropdown         | `<mat-select>` inside `<mat-form-field>`        |
| Data table       | `<kendo-grid>`                                  |
| Card container   | `<mat-card appearance="raised">`                |
| Status chip      | `<mat-chip>` with chip color vars               |
| Icon             | `<mat-icon>` Material Icons                     |

## Responsive Layout

```scss
.responsive-layout {
    display: flex;
    flex-direction: column;

    @include mixins.respond-to(laptop) {
        // >= 1366px
        flex-direction: row;
    }
}
```

## Validation Steps

### Visual Validation

- Compare rendered component to Figma design
- Check colors match design tokens
- Verify spacing is consistent
- Test at all breakpoints (700px, 1366px, 1600px, 1920px)

### Code Validation

- Run `nova-watch-start-no-open` task and check for errors
- Verify no TypeScript compilation errors
- Ensure all imports are non-relative
- Check no `any` types are used

### Testing Validation

- Run unit tests: `npm test -- --include="**/path/to/file.spec.ts"`
- Verify all tests pass

### Accessibility Validation

- Add ARIA labels where needed
- Test keyboard navigation
- Verify color contrast ratios
- Test with screen reader

## Asset Reference

### Design Source

- **InVision DSM**: https://projects.invisionapp.com/dsm/aya-healthcare-design-system/nova-style-guide/

### Related Skills

- **design-tokens**: Color, typography, spacing, breakpoint values
- **nova-components**: Material/Kendo component patterns
- **nova-styling**: SCSS mixins and responsive design
- **nova-icons**: Icon system usage
