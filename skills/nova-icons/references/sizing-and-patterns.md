# Sizing And Usage Patterns

## Usage Patterns

```html
<mat-icon>delete</mat-icon>

<div
    class="icon-container"
    [style.background-image]="'url(assets/images/icons/facility-icon.svg)'">
</div>

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
<button mat-icon-button aria-label="Edit item">
    <mat-icon>edit</mat-icon>
</button>

<button mat-icon-button color="warn" aria-label="Delete item">
    <mat-icon>delete</mat-icon>
</button>
```
