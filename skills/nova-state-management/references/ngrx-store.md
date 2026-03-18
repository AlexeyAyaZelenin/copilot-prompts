# NgRx Store

Use NgRx Store for global state shared across features. Example location: `src/app/clinical/store/`.

## File Structure

```text
src/app/[feature]/store/
├── feature.actions.ts
├── feature.reducer.ts
├── feature.selectors.ts
└── feature.effects.ts
```

## Actions

```typescript
import { createActionGroup, emptyProps, props } from '@ngrx/store';

export const FeatureActions = createActionGroup({
    source: 'Feature',
    events: {
        'Load Items': emptyProps(),
        'Load Items Success': props<{ items: Item[] }>(),
        'Load Items Failure': props<{ error: string }>()
    }
});
```

## Reducer

```typescript
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

## Selectors

```typescript
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

## Effects

```typescript
import { inject } from '@angular/core';
import { Actions, createEffect, ofType } from '@ngrx/effects';
import { catchError, map, of, switchMap } from 'rxjs';

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

## Route-Level Registration

```typescript
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
