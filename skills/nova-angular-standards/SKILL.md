---
name: nova-angular-standards
description: Nova-only Angular coding standards for components, templates, and code quality. Use only when working in the Nova application and creating components, writing templates, working with forms, or following Angular best practices. Covers standalone components, new control flow syntax, typed forms, and import conventions.
---

# Nova Angular Standards

Use this skill for broad day-to-day Angular conventions in Nova. For deeper guidance on newer Angular v17 feature areas, use the focused skills:

- `nova-control-flow` for `@if`, `@for`, `@switch`, `@empty`, and structural-directive migration
- `nova-signals` for signals, `input`, `model`, `output`, signal queries, render hooks, and RxJS interop
- `nova-deferrable-views` for `@defer`, trigger selection, placeholders, and defer testing
- `nova-standalone-migration` for module-to-standalone migration workflow and cleanup
- `nova-ssr-hydration` for server rendering, hydration, transfer cache, and browser-only DOM work

## Modern Angular Patterns

- **No demo code**: Do not create demo-only components, pages, or placeholder logic
- **New control flow**: Use `@if`, `@else`, `@for` instead of `*ngIf`, `*ngFor`; use `nova-control-flow` for migration and review details
- **Standalone components**: All new components must be standalone; use `nova-standalone-migration` when converting legacy feature areas
- **Material MDC for new UI**: Use Angular Material MDC components for all new work
- **OnPush by default**: Prefer `ChangeDetectionStrategy.OnPush` for components
- **Signals for reactivity**: Use `signal()`, `computed()`, `effect()` for modern state; use `nova-signals` for the full Angular v17 authoring APIs
- **Signals over BehaviorSubject (component state)**: Prefer signals for local component state
- **Signal inputs/outputs**: Use `input()` and `output()` APIs instead of `@Input()`/`@Output()`; see `nova-signals` for `model()`, signal queries, and render hooks
- **Typed Forms**: Use `FormGroup<T>` and `FormControl<T>` for type safety
- **Non-relative imports**: `import { X } from 'src/app/feature/x'` (never `../x`)
- **Dependency injection**: Prefer `inject()` over constructor injection in new code
- **Service lifetime**: Use `providedIn: 'root'` for singleton services unless scoped injection is required
- **Optional chaining**: Prefer `?.` for nested null-safe access checks

## Component Pattern

```typescript
@Component({
    selector: 'nova-my-component', // Prefix with 'nova-'
    standalone: true,
    changeDetection: ChangeDetectionStrategy.OnPush,
    imports: [CommonModule, MatButtonModule],
    templateUrl: './my-component.component.html',
    styleUrls: ['./my-component.component.scss']
})
export class MyComponentComponent {
    private readonly userService = inject(UserService);

    readonly canEdit = input.required<boolean>();
    readonly saved = output<void>();

    // Use signals for reactive state
    readonly count = signal(0);
    readonly doubleCount = computed(() => this.count() * 2);

    // Avoid multiple conditions in templates - use computed signals or getters
    get shouldDisplay(): boolean {
        return this.canEdit() && (this.userService.currentUser?.permissions?.length ?? 0) > 0;
    }

    onSave(): void {
        if (this.shouldDisplay) {
            this.saved.emit();
        }
    }
}
```

## Template Standards

```html
<!-- Use new control flow -->
@if (isVisible) {
<div>Content</div>
} @else {
<div>Alternative</div>
} @for (item of items; track item.id) {
<span>{{ item.name }}</span>
}

<!-- Complex conditions use component property -->
@if (shouldDisplay) {
<div>Content</div>
}

<!-- Use @defer for heavy/below-the-fold content -->
@defer (on viewport) {
<nova-heavy-widget />
} @placeholder {
<nova-widget-skeleton />
}
```

- Always provide a stable `track` expression in `@for` loops (for example, `item.id`)
- Avoid `track $index` unless the list has no unique identifier
- Keep template expressions simple; move complex logic to computed signals or getters
- Use `nova-control-flow` for detailed migration guidance and `nova-deferrable-views` for `@defer` triggers, placeholders, and testing

## Typed Forms

```typescript
interface LoginForm {
    email: FormControl<string>;
    password: FormControl<string>;
    rememberMe: FormControl<boolean>;
}

form = new FormGroup<LoginForm>({
    email: new FormControl('', { nonNullable: true }),
    password: new FormControl('', { nonNullable: true }),
    rememberMe: new FormControl(false, { nonNullable: true })
});
```

## Code Quality Rules

| Rule                    | Explanation                                   |
| ----------------------- | --------------------------------------------- |
| Never use `any`         | Use specific types or `unknown`               |
| Never use `console.log` | Remove after debugging                        |
| Always use braces       | `if (x) { return y; }` not `if (x) return y;` |
| Null/undefined checks   | Use `isNullOrUndefined` from `src/app/shared/utilities/obj-utilities` |
| Optional chaining       | Prefer `user?.profile?.name` over chained `&&` checks |
| Use context7 for docs   | Look up signals, effects, computed            |
| Minimal comments        | Only for tricky code, not obvious logic       |
| Single responsibility   | Keep components small and focused             |

## Import Conventions

```typescript
// ✅ Correct - non-relative imports
import { MyService } from 'src/app/core/my.service';
import { SharedModule } from 'src/app/shared/shared.module';

// ❌ Wrong - relative imports
import { MyService } from '../../../core/my.service';
```

## RxJS Imports

```typescript
// ✅ Correct - import directly from rxjs
import { Observable, combineLatest, of } from 'rxjs';
import { map, filter, switchMap } from 'rxjs';

// ❌ Wrong - old import path
import { map } from 'rxjs/operators';
```

## RxJS & Subscription Lifecycle

- Prefer declarative streams over imperative `.subscribe()` calls
- Avoid nested subscriptions; use higher-order mapping operators (`switchMap`, `mergeMap`, `concatMap`)
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

## Error Handling Standards

- Implement centralized HTTP error handling using interceptors
- Use `catchError` in streams and provide meaningful fallback behavior
- Show user-friendly error messages in UI; keep detailed diagnostics in logging
