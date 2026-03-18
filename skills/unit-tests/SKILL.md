---
name: unit-tests
description: Nova-only unit testing guidance. Use only when working in the Nova application and writing or updating unit tests.
---

# Unit Test Standards (Nova)

Use this checklist when writing or updating unit tests.

- The project uses **Jasmine** for testing, not Jest.
- Use **Spectator** for component tests; avoid TestBed when simple class instantiation is sufficient.
- Always verify unit tests pass after making changes to them.
- Run unit tests using the command `npm test`.
- Write unit tests for services and components with complex logic.
- For specific files in Nova, `--include` must use a glob and must NOT start with `src/app/`.
- Preferred pattern: include enough folder depth to avoid same-named spec conflicts.
- Valid examples:
    - `npm test -- --include="**/travelxnew/contracts/contracts.component.spec.ts"`
    - `npm test -- --include="**/submittal/submittal-jobs/submittal-jobs-table/submittal-jobs-table.component.spec.ts"`
- Invalid example:
    - `npm test -- --include="src/app/submittal/submittal-jobs/submittal-jobs-table/submittal-jobs-table.component.spec.ts"`
- Focus on high quality unit tests.
- Test inputs/outputs and user interactions rather than implementation details.
    - Good: verify outputs emitted, state changes, service interactions, and interaction-driven behavior.
    - Avoid: brittle assertions tied to exact markup structure or private implementation details.
- Use `fakeAsync` and `tick()` for async behavior when appropriate.

## Feature Flag Mocking

- When mocking feature flags within specific tests (for example, not initializing it in the mock component setup), provide the **actual feature flag key** for ease of discovery when the flag is removed later.

Do this:

```typescript
spyOn(mockFeatureManager, 'isEnabled')
        .withArgs(FeatureFlag.CertificationManagementAndMapping)
        .and.returnValue(of(testCase.flagEnabled));
```

Instead of this:

```typescript
spyOn(mockFeatureManager, 'isEnabled').and.returnValue(of(testCase.flagEnabled));
```

## Test Structure and Patterns

- Reset spies in the `beforeEach` block to avoid unexpected test results based on test order or test count.
- Use bracket notation to access private members if necessary.
    - Example: `component['calculateTotals']()`
- Group tests for the same functionality within a `describe` block.
- Always follow the Arrange-Act-Assert pattern.
    - Add comments for sections: `// ARRANGE`, `// ACT`, `// ASSERT`
- Always mock imported services, components, or modules.
    - Use `MockComponent`, `MockService`, and `MockModule` from `ng-mocks`.
- Avoid magic numbers.
    - Store test values in clearly named variables (for example, `const TEST_ID = 1;` or `const EXPECTED_RECORD_COUNT = testData.length;`).
    - Booleans are exempt from this rule.
- When testing the same functionality with different values, store test cases in an array of objects and iterate over them.

```typescript
[
        { input: 'test data', flag: true, expected: true },
        { input: 'test data', flag: false, expected: false }
].forEach((tc) => {
        it(`should return ${tc.expected} when flag is ${tc.flag}`, () => {
                // ARRANGE
                const input = tc.input;

                // ACT
                const result = myFunction(input, tc.flag);

                // ASSERT
                expect(result).toBe(tc.expected);
        });
});
```
