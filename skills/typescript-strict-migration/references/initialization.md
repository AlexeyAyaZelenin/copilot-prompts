# Initialization And Assigned Members

## Use This Reference When

- Fixing uninitialized fields under strict property checks
- Normalizing route or query ids
- Choosing between defaults, `null`, and definite assignment
- Handling members assigned by Angular lifecycle or decorators

## Core Rules

- Do: initialize fields with safe defaults only when that default is real runtime behavior
- Before: `title: string; itemAvgCost: number;`
- After: `title = ''; itemAvgCost = 0;`

- Do: prefer deterministic numeric fallbacks such as `0` or `null` for missing route or query ids when values are later used in dispatches, URLs, or child inputs
- Before: `this.contractId = parseInt(this._route.snapshot.queryParamMap.get('contractId'), 10);`
- After: `this.contractId = this.parseIdOrZero(contractIdParam);`

- Do: normalize invalid route or query ids deterministically before storing them in component state
- Before: `this.candidateId = parseInt(this._route.snapshot.paramMap.get('id'), 10);`
- After: `this.candidateId = this.parseIdOrZero(candidateIdParam);`

- Do: keep async-loaded members nullable, or use a real deterministic fallback, instead of converting them to definite assignment only to satisfy strictness
- Before: `candidateId: number = null; recruiterId: number = null;`
- After: `candidateId = 0; recruiterId: number | null = null;`

- Do: use the non-null assertion operator for class members that are definitely assigned by Angular lifecycle or decorator flow
- Before: `@ViewChild(MatSort) sort: MatSort;`
- After: `@ViewChild(MatSort) sort!: MatSort;`

- Do not: use `Number.NaN` as a fallback for route or query ids
- Before: `this.housingReqId = queryParams.id;`
- After: `const requestId = Number(queryParams.id); this.housingReqId = Number.isFinite(requestId) && requestId > 0 ? requestId : null;`

- Do not: add placeholder initializers such as `EMPTY`, `new UntypedFormGroup({})`, `{}`, or `[]` just to satisfy strict checks when the member is assigned later in lifecycle code
- Before: `contactInfoForm: UntypedFormGroup;`
- After: `contactInfoForm!: UntypedFormGroup;`

- Do not: mark lifecycle-assigned members optional unless they are truly optional at runtime
- Before: `filteredVendors$: Observable<Lookup[]>;`
- After: `filteredVendors$!: Observable<Lookup[]>;`

## Behavior-Sensitive Defaulting

- Do: when `0` or `null` is used as an id fallback, guard downstream side effects with explicit validity checks only when that behavior is already intended
- Before: `this._store.dispatch(getPickleContractsByCandidateId({ candidateId: this.candidateId }));`
- After: `if (this.candidateId > 0) { this._store.dispatch(getPickleContractsByCandidateId({ candidateId: this.candidateId })); }` only when behavior is explicitly approved

- Do: treat newly added fallback-id dispatch guards as behavior changes. Confirm the existing runtime contract or tests before enforcing a new `> 0` gate
- Before: add `if (candidateId > 0)` during strict cleanup without checking tests
- After: preserve existing dispatch behavior unless requirements or tests explicitly change it
