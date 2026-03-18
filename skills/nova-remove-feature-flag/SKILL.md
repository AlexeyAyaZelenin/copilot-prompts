---
name: nova-remove-feature-flag
description: Nova-only feature flag removal guidance. Use only when working in the Nova application to remove references to the feature flag specified by the user and the code that runs when the feature flag is disabled.
---

**Do not add new comments anywhere in your changes.**

1. Identify every file referencing the user provided feature flag and create a #tool:todo checklist of all files to be modified.
2. Proceed through your checklist and remove the feature flag. Any code related to the flag being disabled should be removed, making the feature flag enabled path the only remaining code path.

- If the feature flag state was assigned to a variable, that variable should be removed. `isFeatureEnabled` would be removed from the code in the following example:

```typescript
isFeatureEnabled: boolean = false;

this.isFeatureEnabled = this._featureFlagService.isFeatureEnabled(FeatureFlag.X);
```

- If the check for the feature flag state being true is a part of an `if` condition, simply remove the feature flag state check while preserving the original logic. For example:

```typescript
else if (isFeatureFlagEnabled && user.isAdmin)
```

would become:

```typescript
else if (user.isAdmin)
```

3. Retain existing comments unless they mention the feature flag; in those cases, edit the comment to remove references to the flag while preserving the comment's intent.
4. **Restrict code changes to only what is strictly necessary for correct flag removal.** Do not make assumptions about potentially redundant code, as there may be other feature flags involved.
5. Unit tests that test behavior when the feature flag is enabled should remain, but:

- Feature flag references should be removed from the test code.
- Test names or descriptions that mention the flag should eliminate flag-related language. For example:

`it('should do x when flag is enabled')` would become `it('should do x')`.

- **Do not change the intent of the test or otherwise modify it.**

6. Unit tests that only test behavior when the flag is disabled should be removed entirely.
7. After the specified feature flag has been removed from a file, audit the file for other feature flags. **If no other feature flags remain perform the following actions**:

- Remove imports and other references to feature flags and LaunchDarkly, including:
    - `LDFeatureModule`
    - `LDFeatureManager`
    - `IfLdFeatureDirective`
        - **Only remove this if no other instances of `*ifLdFeature` exist in the corresponding HTML template.**
    - `FeatureFlag` enums.
        - **Only remove this if no other instances of `*ifLdFeature` exist in the corresponding HTML template.**

8. After all changes, verify the build completes successfully.
9. Confirm unit tests pass after your changes and address any failures that occur.

- **Run all tests for affected files**, not just the tests you changed, as some tests may have been indirectly affected.