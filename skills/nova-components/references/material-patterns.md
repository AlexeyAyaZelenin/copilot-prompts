# Material Component Patterns

## Buttons

```html
<button mat-flat-button color="primary">Save</button>
<button mat-stroked-button color="secondary">Cancel</button>
<button mat-flat-button color="cancel">Cancel</button>
<button mat-icon-button>
    <mat-icon>edit</mat-icon>
</button>
```

## Forms

```html
<mat-form-field appearance="outline">
    <mat-label>Label</mat-label>
    <input matInput type="text" />
</mat-form-field>

<mat-form-field appearance="outline">
    <mat-label>Select</mat-label>
    <mat-select>
        <mat-option value="1">Option 1</mat-option>
    </mat-select>
</mat-form-field>

<mat-checkbox color="primary">Label</mat-checkbox>

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

## Chips

```html
<mat-chip-set>
    <mat-chip>Chip 1</mat-chip>
    <mat-chip>Chip 2</mat-chip>
</mat-chip-set>
```
