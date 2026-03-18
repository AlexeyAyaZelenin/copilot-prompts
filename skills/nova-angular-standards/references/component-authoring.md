# Component Authoring

## Modern Angular Patterns

- No demo-only components, pages, or placeholder logic
- All new components must be standalone
- Use Angular Material MDC components for new UI
- Prefer `ChangeDetectionStrategy.OnPush`
- Use signals for modern local reactivity
- Prefer signals over `BehaviorSubject` for component-local state
- Use `input()` and `output()` APIs in new code
- Prefer `inject()` over constructor injection in new code
- Use `providedIn: 'root'` for singleton services unless scoped injection is required
- Prefer optional chaining for nested null-safe access

## Component Pattern

```typescript
@Component({
    selector: 'nova-my-component',
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
    readonly count = signal(0);
    readonly doubleCount = computed(() => this.count() * 2);

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
