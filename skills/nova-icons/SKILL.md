---
name: nova-icons
description: Nova-only icon system guidance using Material Icons, Kendo SVG icons, and custom SVG assets. Use only when working in the Nova application and adding icons to components, choosing between icon systems, or implementing custom SVG icons.
---

# Nova Icons

Nova uses three icon systems: Material Icons (primary), Kendo SVG Icons, and Custom SVG Icons.

## Material Icons (Primary)

```html
<!-- Template usage -->
<mat-icon>home</mat-icon>
<mat-icon color="primary">edit</mat-icon>
<mat-icon color="warn">delete</mat-icon>
````

```typescript
// Import in standalone component
import { MatIconModule } from '@angular/material/icon';

@Component({
    standalone: true,
    imports: [MatIconModule]
})
```

## Kendo Icons

Kendo components use SVG icons from `@progress/kendo-svg-icons`:

```typescript
// src/app/core/nova-icons.service.ts
@Injectable()
export class NovaKendoIconsService extends IconSettingsService {
    private readonly svgDictionary: Record<string, SVGIcon> = {
        minus: chevronDownIcon,
        plus: chevronRightIcon
    };

    getSvgIcon(svgIconName: string): SVGIcon {
        return this.svgDictionary[svgIconName] || super.getSvgIcon(svgIconName);
    }
}
```

## Custom SVG Icons

### Locations

- `assets/images/icons/` - Component-specific icons
- `assets/images/svg/` - General purpose SVG assets

### Available Icons

**Status Icons:**

- `active-chip-icon.svg`
- `complete-chip-icon.svg`
- `pending-chip-icon.svg`
- `rejected-chip-icon.svg`

**File Type Icons:**

- `doc-file-icon.svg`
- `pdf-file-icon.svg`
- `xls-file-icon.svg`

**UI Icons:**

- `facility-icon.svg`
- `shift-icon.svg`

### Usage Patterns

```html
<!-- Material Icon -->
<mat-icon>delete</mat-icon>

<!-- Custom SVG as background -->
<div
    class="icon-container"
    [style.background-image]="'url(assets/images/icons/facility-icon.svg)'">
</div>

<!-- Inline SVG -->
<img
    src="assets/images/svg/aya-logo-primary-full-color.svg"
    alt="Logo" />
```

## Icon Sizing

```scss
@use 'assets/scss/mixins' as mix;

.small-icon {
    @include mix.mat-icon-size(18px);
}

.default-icon {
    @include mix.mat-icon-size(24px);
}

.large-icon {
    @include mix.mat-icon-size(32px);
}
```

## Icon Button Pattern

```html
<button
    mat-icon-button
    aria-label="Edit item">
    <mat-icon>edit</mat-icon>
</button>

<button
    mat-icon-button
    color="warn"
    aria-label="Delete item">
    <mat-icon>delete</mat-icon>
</button>
```

## When to Use Each System

| Icon System    | Use Case                               |
| -------------- | -------------------------------------- |
| Material Icons | Standard UI icons (edit, delete, menu) |
| Kendo Icons    | Inside Kendo components (grid, tree)   |
| Custom SVG     | Brand assets, domain-specific icons    |
