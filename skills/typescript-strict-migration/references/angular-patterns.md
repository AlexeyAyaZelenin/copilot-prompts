# Angular Patterns For Strict Migration

## Use This Reference When

- Fixing template-bound event handlers or callbacks
- Updating `@Input`, `@ViewChild`, or async bindings for strict types
- Preserving component rendering while satisfying nullable bindings
- Returning more precise structural types from component helpers

## Component And Template Rules

- Do: prefer event types inferred from template bindings
- Before: `selectedItem(item): void { this.vendorForm.controls.vendorName.patchValue(item.option.value.name); }`
- After: `selectedItem(item: MatAutocompleteSelectedEvent): void { const selectedVendor = item.option.value as Lookup; this.vendorForm.controls.vendorName.patchValue(selectedVendor.name); }`

- Do: use numeric input transforms where needed

- Do not: use `@Input() requestId!: number` when a transform plus default is required
- Before: `@Input() leaseId: number;`
- After: `@Input() leaseId = 0;`

- Do: use definite assignment for required view and content queries
- Before: `@ViewChild(GridComponent, { static: true }) novaGrid: GridComponent;`
- After: `@ViewChild(GridComponent, { static: true }) novaGrid!: GridComponent;`

- Do: keep return types precise and remove fallback unions like `| {}` unless behavior truly returns arbitrary objects
- Before: `rowClass(context: RowClassArgs): { error: boolean } | { warning: boolean } { ... }`
- After: `rowClass(context: RowClassArgs): Partial<{ error: boolean; warning: boolean }> { ... return {}; }`

- Do: when passing a component function through template input bindings such as `[displayItemFn]="employeeDisplay"`, use an arrow-function property so callback invocation does not lose `this` context
- Before: template `[displayItemFn]="employeeDisplay"` with class methods `employeeDisplay(employee: CorporateDirectoryUser): string { ... }` and `recruiterDisplay(employee: Recruiter): string { ... }`
- After: template `[displayItemFn]="employeeDisplay"` with class properties `employeeDisplay = (employee: unknown): string => { ... }` and `recruiterDisplay = (employee: unknown): string => { ... }`

- Do: when template bindings require `string | null`, prefer inline `value ?? null` at the binding site instead of creating one-off adapter helpers

- Do: keep async data flow consistent within a template section. If UI state is driven by an imperative property such as `contracts`, use that same source for related checks and branches

- Do: when selector outputs become nullable, update consuming observable field types such as `Observable<T | null>` rather than coercing or asserting away nullability
- Before: `selectedPickle$: Observable<CandidatePickle>; source$: Observable<OptionModel[]>;`
- After: `selectedPickle$!: Observable<CandidatePickle | null>; source$!: Observable<OptionModel[] | null>;`

- Do not: mix `observable$ | async as alias` for one condition while rendering related content from a separate imperative property unless there is an explicit synchronization reason

- Do: when a details panel depends on a selected item and a loaded collection, provide a deterministic in-section fallback from the same state source such as `selectedContract ?? contracts[0]` so loaded-data screens do not briefly render blank

- Do: keep core containers such as `nova-grid` mounted and provide typed fallback resolvers for async bindings instead of hiding the container with structural directives

- Do not: wrap the entire grid or component in `@if` or `*ngIf` just to satisfy nullable async bindings when safe fallback values can preserve initial render behavior
