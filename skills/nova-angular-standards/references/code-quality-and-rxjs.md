# Code Quality And RxJS

## Code Quality Rules

| Rule | Explanation |
|------|-------------|
| Never use `any` | Use specific types or `unknown` |
| Never use `console.log` | Remove after debugging |
| Always use braces | `if (x) { return y; }` |
| Null checks | Use `isNullOrUndefined` from `src/app/shared/utilities/obj-utilities` |
| Optional chaining | Prefer `user?.profile?.name` |
| Use context7 for docs | Look up signals, effects, and computed |
| Minimal comments | Only for tricky code |
| Single responsibility | Keep components small and focused |

## Import Conventions

```typescript
import { MyService } from 'src/app/core/my.service';
import { SharedModule } from 'src/app/shared/shared.module';
```

Avoid relative imports like `../../../core/my.service`.

## RxJS Imports

```typescript
import { Observable, combineLatest, of } from 'rxjs';
import { catchError, filter, map, switchMap } from 'rxjs';
```

Do not import operators from `rxjs/operators`.

## RxJS Lifecycle

- Prefer declarative streams over imperative `.subscribe()` calls
- Avoid nested subscriptions; use higher-order mapping operators
- Use `async` pipe in templates when possible
- When manual subscriptions are necessary, use `takeUntilDestroyed()` with `DestroyRef`

```typescript
private readonly destroyRef = inject(DestroyRef);

readonly vm$ = this.dataService.getData().pipe(
    catchError(() => of([]))
);

ngOnInit(): void {
    this.dataService
        .events()
        .pipe(takeUntilDestroyed(this.destroyRef))
        .subscribe();
}
```

## Error Handling

- Implement centralized HTTP error handling using interceptors
- Use `catchError` in streams and provide meaningful fallback behavior
- Show user-friendly error messages in the UI and keep detailed diagnostics in logging
