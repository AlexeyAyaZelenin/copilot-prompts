---
name: nova-development-workflow
description: Nova-only development workflow guidance including compilation validation, running the application, and common pitfalls. Use only when working in the Nova application and starting development, running the app, debugging build issues, or encountering common errors. CRITICAL - always run and monitor the watch task before making changes.
---

# Nova Development Workflow

If the task is a module-to-standalone migration, pair this skill with `nova-standalone-migration` for the schematic order, incremental path strategy, and cleanup checklist.

## Compilation Validation (REQUIRED)

**ALWAYS run `nova-watch-start-no-open` task** and monitor its output in VS Code:

1. Start if not running: Task menu -> "nova-watch-start-no-open"
2. Watch for TypeScript errors in real-time as you code
3. **NEVER run tests** with compilation errors present
4. **NEVER use `tsc`** - only trust the watch task output
5. Fix all errors before declaring work complete

## Running the Application

```powershell
npm run start          # Opens browser at localhost:4201
npm run start:no-open  # Runs without opening browser (preferred for watch)
npm run start:prod     # Production configuration
```

Requires Core API running locally at `localhost:8088` or configure `services.config.js` to use DEV environment.

## Testing Commands

```powershell
npm test                                                    # All tests
npm test -- --include="**/feature/component.spec.ts"       # Specific file (glob pattern, no src/app prefix)
npm run test:impacted                                       # Tests affected by git changes
npm run test:debug                                          # Debug mode with Chrome
```

Rules for specific test files:
- Use `--include` with a glob pattern.
- Do not start include values with `src/app/`.
- Include enough folder depth to avoid same-named spec collisions.
- Valid: `npm test -- --include="**/submittal/submittal-jobs/submittal-jobs-table/submittal-jobs-table.component.spec.ts"`
- Invalid: `npm test -- --include="src/app/submittal/submittal-jobs/submittal-jobs-table/submittal-jobs-table.component.spec.ts"`

See unit-tests skill for testing patterns and guidelines.

## Strict TypeScript Check

Check if a file is in strict mode:

```powershell
npm run check:strict -- --file src/app/path/to/file.ts
```

For strict files, **no `any` types** allowed - use specific types or `unknown`.

## Common Pitfalls

### Problem: Compilation errors not visible

**Solution:** Always run `nova-watch-start-no-open` task in VS Code and monitor output

### Problem: Tests fail with "Cannot find module"

**Solution:** Use full path with `npm test -- --include="**/full/path/to/file.spec.ts"`

### Problem: `services.config.js` not loading

**Solution:** Never import it - access via `window.servicesConfig` or inject `APP_CONFIG` token

### Problem: Feature flag not working

**Solution:** Ensure `LDFeatureManager.init()` called in app initialization before checking flags

### Problem: Material form fields look wrong

**Solution:** Default config is `appearance: 'outline'` - check `nova-material-defaults.const.ts` for overrides

### Problem: Routing to wrong URL

**Solution:** Check `app.routes.ts` - routes are lazy-loaded, verify feature module exports correct routes

## Documentation Links

- **Developer Onboarding**: https://ayadev.atlassian.net/wiki/spaces/ARCH/pages/252903461
- **Getting Started Guide**: https://ayadev.atlassian.net/wiki/spaces/ARCH/pages/556367921
