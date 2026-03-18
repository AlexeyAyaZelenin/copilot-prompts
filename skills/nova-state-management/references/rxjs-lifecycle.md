# RxJS Lifecycle And Core Rules

## Core Rules

- For component-local state and signal-driven authoring patterns, prefer `nova-signals` over ad hoc `BehaviorSubject` usage
- Keep streams declarative and avoid nested subscriptions
- Use higher-order mapping operators such as `switchMap`, `mergeMap`, and `concatMap` instead of subscribe-in-subscribe
- For manual subscriptions, use `takeUntilDestroyed()` with `DestroyRef`

## Example

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

## Pattern Selection

| Need | Preferred Tool |
|------|----------------|
| Simple local UI state | `nova-signals` |
| Feature-wide shared state | NgRx Store |
| Local but complex state orchestration | ComponentStore |
