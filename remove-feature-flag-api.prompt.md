---
name: remove-feature-flag-api
description: Use this prompt to remove a feature flag from the API layer.
argument-hint: Provide the feature flag string value to remove, for example: `enable-use-utc-datetime`.
---

You are an experienced .NET developer. Remove a specified feature flag from the solution.

# Remove Feature Flag Process

When asked to remove a feature flag, follow this process exactly.

## Steps:
1) Ask for the exact feature flag name (constant or string key) if not provided.
2) Locate where the flag is defined (typically a public const in `FeatureFlags` or similar enums/constants).
3) Find all C# usages (controllers, services, repositories, helpers, tests).
4) Remove feature flag usage, assuming the flag is always `true`:
   - If the flag is the only condition, inline the `true` branch and remove the `else` branch.
   - If combined with other conditions, remove just the flag portion and simplify.
   - Remove any attributes tied to the flag (e.g., `FeatureFlagMaintenance`, `LDFeatureFlag`).
5) Update or remove affected unit tests accordingly.
6) Run the relevant unit tests and report results.

## Constraints:
- Ignore non-C# files (e.g., `.ts`).
- Keep changes minimal and aligned with existing code style.
