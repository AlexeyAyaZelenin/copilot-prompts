# Icon Systems

Nova uses three icon systems: Material Icons, Kendo SVG Icons, and custom SVG assets.

## Material Icons

```html
<mat-icon>home</mat-icon>
<mat-icon color="primary">edit</mat-icon>
<mat-icon color="warn">delete</mat-icon>
```

```typescript
import { MatIconModule } from '@angular/material/icon';

@Component({
    standalone: true,
    imports: [MatIconModule]
})
```

## Kendo Icons

Kendo components use SVG icons from `@progress/kendo-svg-icons`.

```typescript
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

- `assets/images/icons/` for component-specific icons
- `assets/images/svg/` for general-purpose SVG assets

### Example assets

- `active-chip-icon.svg`
- `complete-chip-icon.svg`
- `pending-chip-icon.svg`
- `rejected-chip-icon.svg`
- `doc-file-icon.svg`
- `pdf-file-icon.svg`
- `xls-file-icon.svg`
- `facility-icon.svg`
- `shift-icon.svg`

## When To Use Each System

| Icon System | Use Case |
|------------|----------|
| Material Icons | Standard UI icons such as edit, delete, or menu |
| Kendo Icons | Inside Kendo components such as grid or tree controls |
| Custom SVG | Brand assets and domain-specific icons |
