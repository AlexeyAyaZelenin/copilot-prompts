---
name: nova-components
description: Nova-only UI component patterns using Angular Material v16 (MDC) and Kendo UI v17. Use only when working in the Nova application and creating forms, buttons, cards, grids, chips, or other UI components. Covers Material configuration, standalone component structure, and template syntax with new Angular control flow.
---

# Nova Components

Nova uses Angular Material v16.2.14 (MDC-based), Kendo UI v17.2.0, and @aya/controls v12.4.1.

## Standalone Component Structure

```typescript
import { ChangeDetectionStrategy, Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatButtonModule } from '@angular/material/button';

@Component({
    selector: 'nova-my-component', // Always prefix with 'nova-'
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

## Template Control Flow

Use new Angular control flow syntax:

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

## Buttons

```html
<!-- Primary action -->
<button
    mat-flat-button
    color="primary"
    >Save</button
>

<!-- Secondary action -->
<button
    mat-stroked-button
    color="secondary"
    >Cancel</button
>

<!-- Cancel action -->
<button
    mat-flat-button
    color="cancel"
    >Cancel</button
>

<!-- Icon button -->
<button mat-icon-button>
    <mat-icon>edit</mat-icon>
</button>
```

## Forms

```html
<!-- Input field -->
<mat-form-field appearance="outline">
    <mat-label>Label</mat-label>
    <input
        matInput
        type="text" />
</mat-form-field>

<!-- Select dropdown -->
<mat-form-field appearance="outline">
    <mat-label>Select</mat-label>
    <mat-select>
        <mat-option value="1">Option 1</mat-option>
    </mat-select>
</mat-form-field>

<!-- Checkbox -->
<mat-checkbox color="primary">Label</mat-checkbox>

<!-- Radio buttons -->
<mat-radio-group>
    <mat-radio-button value="1">Option 1</mat-radio-button>
    <mat-radio-button value="2">Option 2</mat-radio-button>
</mat-radio-group>
```

## Cards

```html
<mat-card appearance="raised">
    <mat-card-header>
        <mat-card-title>Title</mat-card-title>
    </mat-card-header>
    <mat-card-content>Content here</mat-card-content>
    <mat-card-actions>
        <button mat-button>Action</button>
    </mat-card-actions>
</mat-card>
```

## Kendo Grid

Use Kendo Grid for data tables:

```html
<kendo-grid
    [data]="gridData"
    [pageSize]="10">
    <kendo-grid-column
        field="name"
        title="Name"></kendo-grid-column>
    <kendo-grid-column
        field="email"
        title="Email"></kendo-grid-column>
</kendo-grid>
```

## Chips

```html
<mat-chip-set>
    <mat-chip>Chip 1</mat-chip>
    <mat-chip>Chip 2</mat-chip>
</mat-chip-set>
```

## Common Imports

```typescript
// Material components
import { MatButtonModule } from '@angular/material/button';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatRadioModule } from '@angular/material/radio';
import { MatCardModule } from '@angular/material/card';
import { MatIconModule } from '@angular/material/icon';
import { MatChipsModule } from '@angular/material/chips';

// Kendo components
import { GridModule } from '@progress/kendo-angular-grid';
import { ButtonsModule } from '@progress/kendo-angular-buttons';

// Aya controls
import { NovaButtonComponent } from '@aya/controls';

// Internal services (non-relative)
import { MyService } from 'src/app/core/my.service';
```

## State Management

### Signals (Simple State)

```typescript
import { Component, signal, computed } from '@angular/core';

@Component({...})
export class MyComponent {
    count = signal(0);
    doubleCount = computed(() => this.count() * 2);

    increment() {
        this.count.update(value => value + 1);
    }
}
```

### NgRx (Complex State)

```typescript
// Actions
export const loadData = createAction('[Feature] Load Data');
export const loadDataSuccess = createAction(
    '[Feature] Load Data Success',
    props<{ data: DataType[] }>()
);

// Component
private readonly store = inject(Store);

ngOnInit() {
    this.store.dispatch(loadData());
}
```
