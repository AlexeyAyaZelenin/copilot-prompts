# Tests And Mocks

## Use This Reference When

- Strict typing breaks existing test doubles or mock literals
- A model appears to be missing properties during test setup
- Selector overrides or no-op inputs need typed fallbacks
- Workarounds such as intersections or reflection are tempting

## Core Rules

- Do: inspect the underlying model or type definition, including inherited or extended types, before adding properties or introducing an intersection
- Before: `const mockPet = { weight: 5 } as PetMember;`
- After: `const mockPet = { id: 2, weight: 5 } satisfies PetMember;`

- Do: if a reported missing property already exists on the model, use the model type directly and fix the actual mismatch such as a wrong import, wrong generic wrapper, or incorrect inferred type

- Do: prefer creating fully valid model-shaped mocks over inline intersection workarounds
- Before: `const mockFurnitureItem = { title: 'test', avgCost: 5, id: 999 } as HousingLeaseFurnitureItem;`
- After: `const mockFurnitureItem: HousingLeaseFurnitureItem = { title: mockFurnitureItemTitle, avgCost: mockFurnitureItemAvgCost, id: mockFurnitureItemId };`

- Do: when test intent is property absent, pass a minimal typed object that omits that property instead of changing semantics to an empty-string placeholder

- Do: prefer typed inputs that naturally exercise no-op branches such as `[]` and `0` over reflection or workaround calls
- Before: `store.overrideSelector(selectLeaseStates, undefined);`
- After: `store.overrideSelector(selectLeaseStates, []);`

- Do not: add test-only properties that are not part of the real model contract, including inherited model contracts

- Do not: add intersections that redeclare properties already present on the base model
- Before: `const mockTaskResult: TaskDialogResult & { taskId: number } = { ticketId: 1234, description: 'fake description', dueDate: new Date(), assigneeId: 567, taskId: 345 };`
- After: `const mockTaskId = 345; const mockTaskResult: TaskDialogResult = { ticketId: 1234, description: 'fake description', dueDate: new Date(), assigneeId: 567, taskId: mockTaskId };`

- Do not: change model usage patterns with noisy intersection types purely to silence strictness diagnostics

- Do not: use test workarounds such as `Object.assign(...)`, `Reflect.apply(...)`, or `spyOn<any>(...)` purely to bypass strict typing
