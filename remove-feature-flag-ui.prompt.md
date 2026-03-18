---
name: remove-feature-flag-ui
description: Use this prompt to remove a feature flag from the UI layer (angular).
argument-hint: Provide the feature flag string value to remove, for example: `enable-use-utc-datetime`.
---

# Feature Flag Removal Process

You are an experienced Angular developer. Remove a specified feature flag from the solution in the folder "Nova/src".

When asked to remove a feature flag, follow this process exactly.

## Execution requirements:

- Treat the feature flag as always enabled and clean up dead code accordingly.
- Search and update TypeScript and HTML usages.
- Run targeted tests for changed specs with:
  - `node --max-old-space-size=26000 ./node_modules/@angular/cli/bin/ng test --karma-config=./karma.conf.js --watch=false --browsers=ChromeHeadlessCI --include <test_file_name_relative_path>`
- Report changed files and test status in the final summary.

applyTo: "Nova/src/**/*.ts,Nova/src/**/*.html"

## Inputs

- Accept the feature flag string value, for example: `enable-use-utc-datetime`.

## Locate Definition

1. Find the enum file where the flag is introduced.
   - File name is usually `*feature-flags.enum.ts`.
2. Find the enum member constant for the given string value.
   - Example:
     - `EnableUseUtcDatetime = 'enable-use-utc-datetime',`
3. Record both:
   - The enum type name.
   - The enum member name (constant) used in code.

## Find All Usages

Find all references of the enum member and direct string uses in:

- Component TypeScript files.
- Component HTML templates.
- Services.
- Effects.
- Selectors.
- Unit tests for each updated component/service/effect/selector.

Pay special attention to:

- Local component fields that cache the flag value and are then used in template logic.
- Template conditions using `ifLdFeature`.
- Direct string checks in templates or services.

## Remove Flag Logic (Assume Flag Is Always True)

Apply these transformations:

1. Remove feature-flag branches and keep the behavior for flag enabled.
2. Reduce conditionals:
   - If condition includes flag plus other booleans, remove only the flag term and keep the remaining boolean logic intact.
   - If condition depends only on the feature flag, simplify by removing the conditional wrapper.
3. If there is an `else` block representing flag-off behavior, remove that block entirely.
4. If a selector exists only to return this feature flag value, remove that selector from the selectors file and clean related references.

## Cleanup After Refactor

- Remove unused imports of:
  - Feature flags enum.
  - Feature flag service (or any service used only for this flag).
- Remove now-unused local fields, helper methods, and dead code introduced solely for this flag.
- Update or remove unit tests that were validating the flag-off path.
- In tests, remove selector overrides and mocks that existed only for the removed flag. Do not leave empty placeholder overrides (for example, `selectFeatureFlags` with `{}`) unless they are still required by remaining test logic.

## Validation

For each updated unit test file, run targeted tests with:

`node --max-old-space-size=26000 ./node_modules/@angular/cli/bin/ng test --karma-config=./karma.conf.js --watch=false --browsers=ChromeHeadlessCI --include <test_file_name_relative_path>`

Notes:

- Run one command per changed test file (replace `<test_file_name_relative_path>` each time).
- Ensure all changed tests pass before completing the task.
- If no related tests exist, state that explicitly in the final summary.
