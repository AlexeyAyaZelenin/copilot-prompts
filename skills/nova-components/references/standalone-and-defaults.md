# Standalone Structure And Defaults

Nova uses Angular Material v16.2.14 (MDC-based), Kendo UI v17.2.0, and `@aya/controls` v12.4.1.

## Standalone Component Pattern

```typescript
import { ChangeDetectionStrategy, Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatButtonModule } from '@angular/material/button';

@Component({
    selector: 'nova-my-component',
    standalone: true,
    changeDetection: ChangeDetectionStrategy.OnPush,
    imports: [CommonModule, MatButtonModule],
    templateUrl: './my-component.component.html',
    styleUrls: ['./my-component.component.scss']
})
export class MyComponentComponent {}
```

## Material Default Configuration

Configured globally in `src/app/nova-material-defaults.const.ts`:

```typescript
MAT_FORM_FIELD_DEFAULT_OPTIONS: {
    appearance: 'outline',
    subscriptSizing: 'fixed',
    floatLabel: 'always'
}

MAT_CARD_CONFIG: { appearance: 'raised' }
```

## Template Control Flow Reminder

Use new Angular control flow syntax in templates:

```html
@if (isVisible) {
<div class="content">
    @for (item of items; track item.id) {
    <span>{{ item.name }}</span>
    }
</div>
} @else {
<div>No content available</div>
}
```

Use `nova-control-flow` for migration and review details beyond this reminder.
