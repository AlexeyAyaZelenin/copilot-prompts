---
name: nova-feature-flags
description: Nova-only feature flag patterns using LaunchDarkly (LDFeatureManager). Use only when working in the Nova application and implementing feature flags, checking flag states in components, using flag directives in templates, or creating feature flag route guards.
---

# Nova Feature Flags

Feature flags use LaunchDarkly via `LDFeatureManager`.

## Initialization

Call once during app initialization:

```typescript
await this.featureManager.init();
```

## Component Usage

### Observable Pattern

```typescript
@Component({...})
export class MyComponent {
    private readonly featureManager = inject(LDFeatureManager);

    isEnabled$ = this.featureManager.isEnabled(FeatureFlag.MyFeature);
}
```

### Signal Pattern

```typescript
@Component({...})
export class MyComponent {
    private readonly featureManager = inject(LDFeatureManager);

    isEnabled = this.featureManager.isEnabledSignal(FeatureFlag.MyFeature);
}
```

## Template Control Flow (Preferred)

```html
@if (isEnabled()) {
<div>Feature enabled content</div>
} @else {
<div>Feature disabled content</div>
}
```

## Template Directive (Existing Pattern - Legacy)

⚠️ Do not use `*ifLdFeature` in new code. Prefer the signal pattern (`isEnabledSignal`) with `@if` control flow.

```html
<div *ifLdFeature="FeatureFlag.MyFeature">
    Feature enabled content
</div>

<div *ifLdFeature="FeatureFlag.MyFeature; else disabledTemplate">
    Feature enabled content
</div>
<ng-template #disabledTemplate>
    Feature disabled content
</ng-template>
```

## Route Guards

```typescript
const canMatch: CanMatchFn = () => {
    const ldFeatureManager = inject(LDFeatureManager);
    return ldFeatureManager.isDisabled(FeatureFlag.RemoveOldRoutes);
};

// In routes
{
    path: 'legacy',
    canMatch: [canMatch],
    loadChildren: () => import('src/app/legacy/legacy.routes')
}
```

## Testing with Feature Flags

Mock with explicit flag keys for easier cleanup:

```typescript
spyOn(mockFeatureManager, 'isEnabled')
    .withArgs(FeatureFlag.MyFeature)
    .and.returnValue(of(true));
```

Parameterize tests for both states:

```typescript
[
    { flagEnabled: true, expected: 'enabled behavior' },
    { flagEnabled: false, expected: 'disabled behavior' }
].forEach((tc) => {
    it(`should show ${tc.expected} when flag is ${tc.flagEnabled}`, () => {
        spyOn(mockFeatureManager, 'isEnabled')
            .withArgs(FeatureFlag.MyFeature)
            .and.returnValue(of(tc.flagEnabled));
        // Test assertions
    });
});
```

## Removing Feature Flags

See the `nova-remove-feature-flag` skill for the workflow to remove feature flags when they're no longer needed.
