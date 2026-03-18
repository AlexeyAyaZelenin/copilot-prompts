# Typing Rules

## Use This Reference When

- Replacing `any` or under-typed event parameters
- Fixing nullable observable or selector consumer types
- Narrowing callback parameter types used by templates or controls
- Replacing broad assertions with specific typing

## Core Rules

- Do: use specific types such as `MatOptionSelectionChange`, `string | null`, and `ReadonlyArray<User>`
- Before: `selectedContract$: Observable<CandidateContract>;`
- After: `selectedContract$!: Observable<CandidateContract | null>;`

- Do not: use `any`
- Before: `onSelectedTabChange(event: any) { ... }`
- After: `onSelectedTabChange(event: MatTabChangeEvent): void { ... }`

- Do not: use broad assertions to silence errors
- Before: `const fetchArgs = { ... } as FetchArgs;`
- After: `const fetchArgs = { ... } satisfies FetchArgs;`

- Do not: use `as never` to force compatibility

- Do: when an assertion is unavoidable, cast to the concrete target type with the narrowest possible scope. Use `unknown` as an intermediate only when required
- Before: `employeeDisplay(employee: CorporateDirectoryUser): string { ... }`
- After: `employeeDisplay = (employee: unknown): string => { if (!this.isEmployeeDisplayValue(employee)) { return ''; } ... }`
