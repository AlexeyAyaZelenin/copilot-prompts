# ComponentStore

Use ComponentStore for local state that is more complex than simple component signals. Example location: `src/app/compliance/ds-admin/ds-admin.store.ts`.

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

    readonly items$ = this.select((state) => state.items);
    readonly selectedItem$ = this.select(
        this.items$,
        this.select((state) => state.selectedId),
        (items, id) => items.find((item) => item.id === id)
    );

    readonly setItems = this.updater((state, items: Item[]) => ({
        ...state,
        items
    }));

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

Provide the store at the component boundary:

```typescript
@Component({
    providers: [DsAdminStore]
})
export class DsAdminComponent {
    private readonly store = inject(DsAdminStore);
}
```
