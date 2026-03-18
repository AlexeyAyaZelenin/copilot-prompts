# Grids, Imports, And State

## Kendo Grid

Use Kendo Grid for data tables:

```html
<kendo-grid
    [data]="gridData"
    [pageSize]="10">
    <kendo-grid-column field="name" title="Name"></kendo-grid-column>
    <kendo-grid-column field="email" title="Email"></kendo-grid-column>
</kendo-grid>
```

## Common Imports

```typescript
import { MatButtonModule } from '@angular/material/button';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatRadioModule } from '@angular/material/radio';
import { MatCardModule } from '@angular/material/card';
import { MatIconModule } from '@angular/material/icon';
import { MatChipsModule } from '@angular/material/chips';

import { GridModule } from '@progress/kendo-angular-grid';
import { ButtonsModule } from '@progress/kendo-angular-buttons';

import { NovaButtonComponent } from '@aya/controls';
import { MyService } from 'src/app/core/my.service';
```

## State Guidance

### Signals for simple local state

```typescript
import { Component, computed, signal } from '@angular/core';

@Component({...})
export class MyComponent {
    readonly count = signal(0);
    readonly doubleCount = computed(() => this.count() * 2);

    increment(): void {
        this.count.update((value) => value + 1);
    }
}
```

### NgRx for complex feature state

```typescript
export const loadData = createAction('[Feature] Load Data');
export const loadDataSuccess = createAction(
    '[Feature] Load Data Success',
    props<{ data: DataType[] }>()
);

private readonly store = inject(Store);

ngOnInit(): void {
    this.store.dispatch(loadData());
}
```

Use `nova-state-management` when the component crosses from local UI state into feature or shared store concerns.
