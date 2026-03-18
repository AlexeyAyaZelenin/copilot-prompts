---
name: nova-state-management
description: Nova-only state management patterns using NgRx Store and ComponentStore. Use only when working in the Nova application and implementing feature store state, reducers, selectors, effects, or local ComponentStore state. For Angular v17 signal APIs and RxJS interop, use `nova-signals`.
---

# Nova State Management

For Angular v17 signal primitives and authoring APIs such as `signal`, `computed`, `effect`, `input`, `model`, `output`, signal queries, render hooks, and `toSignal`/`toObservable`, use `nova-signals`.

## When to Use Each Pattern

| Pattern | Use Case | Scope |
|---------|----------|-------|
| **NgRx Store** | Global state shared across features | App-wide |
| **ComponentStore** | Local state for complex components | Component tree |

## Core Rules

- For component-local state and signal-driven authoring patterns, prefer `nova-signals` over ad hoc `BehaviorSubject` usage
- Keep streams declarative and avoid nested subscriptions
- Use higher-order mapping operators (`switchMap`, `mergeMap`, `concatMap`) instead of subscribe-in-subscribe
- For manual subscriptions, use `takeUntilDestroyed()` with `DestroyRef`

## NgRx Store

Global state shared across features. Example: `src/app/clinical/store/`

### File Structure

```
src/app/[feature]/store/
├── feature.actions.ts
├── feature.reducer.ts
├── feature.selectors.ts
└── feature.effects.ts
```

### Actions

```typescript
// feature.actions.ts
import { createActionGroup, props, emptyProps } from '@ngrx/store';

export const FeatureActions = createActionGroup({
    source: 'Feature',
    events: {
        'Load Items': emptyProps(),
        'Load Items Success': props<{ items: Item[] }>(),
        'Load Items Failure': props<{ error: string }>()
    }
});
```

### Reducer

```typescript
// feature.reducer.ts
import { createReducer, on } from '@ngrx/store';

export interface FeatureState {
    items: Item[];
    loading: boolean;
    error: string | null;
}

const initialState: FeatureState = {
    items: [],
    loading: false,
    error: null
};

export const featureReducer = createReducer(
    initialState,
    on(FeatureActions.loadItems, (state) => ({ ...state, loading: true })),
    on(FeatureActions.loadItemsSuccess, (state, { items }) => ({
        ...state,
        items,
        loading: false
    })),
    on(FeatureActions.loadItemsFailure, (state, { error }) => ({
        ...state,
        error,
        loading: false
    }))
);
```

### Selectors

```typescript
// feature.selectors.ts
import { createFeatureSelector, createSelector } from '@ngrx/store';

export const selectFeatureState = createFeatureSelector<FeatureState>('feature');

export const selectItems = createSelector(
    selectFeatureState,
    (state) => state.items
);

export const selectLoading = createSelector(
    selectFeatureState,
    (state) => state.loading
);
```

### Effects

```typescript
// feature.effects.ts
import { inject } from '@angular/core';
import { Actions, createEffect, ofType } from '@ngrx/effects';
import { catchError, map, switchMap, of } from 'rxjs';

export const loadItems = createEffect(
    (actions$ = inject(Actions), service = inject(FeatureService)) =>
        actions$.pipe(
            ofType(FeatureActions.loadItems),
            switchMap(() =>
                service.getItems().pipe(
                    map((items) => FeatureActions.loadItemsSuccess({ items })),
                    catchError((error) => of(FeatureActions.loadItemsFailure({ error: error.message })))
                )
            )
        ),
    { functional: true }
);
```

### Route Configuration

```typescript
// feature.routes.ts
export const FEATURE_ROUTES: Routes = [
    {
        path: '',
        providers: [
            provideState('feature', featureReducer),
            provideEffects([loadItems])
        ],
        children: [...]
    }
];
```

## ComponentStore

Local component state. Example: `src/app/compliance/ds-admin/ds-admin.store.ts`

```typescript
interface DsAdminState {
    items: Item[];
    selectedId: number | null;
}

@Injectable()
export class DsAdminStore extends ComponentStore<DsAdminState> {
    constructor() {
        super({ items: [], selectedId: null });
    }

    // Selectors
    readonly items$ = this.select((state) => state.items);
    readonly selectedItem$ = this.select(
        this.items$,
        this.select((state) => state.selectedId),
        (items, id) => items.find((item) => item.id === id)
    );

    // Updaters
    readonly setItems = this.updater((state, items: Item[]) => ({
        ...state,
        items
    }));

    // Effects
    readonly loadItems = this.effect((trigger$) =>
        trigger$.pipe(
            switchMap(() =>
                this.service.getItems().pipe(
                    tap((items) => this.setItems(items))
                )
            )
        )
    );
}
```

Provide in component:

```typescript
@Component({
    providers: [DsAdminStore]
})
export class DsAdminComponent {
    private readonly store = inject(DsAdminStore);
}
```

