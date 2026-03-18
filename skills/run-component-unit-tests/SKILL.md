---
name: run-component-unit-tests
description: Nova-only guidance for running existing component unit tests after template refactors and reporting targeted validation results.
---

# Run Component Unit Tests (Nova)

Use this skill after template refactor steps to validate changed components with existing unit tests.

## Goal

Run existing component-related unit tests and report concise pass/fail evidence.

## Constraints

- Do not edit source files.
- Run targeted existing unit tests only.
- Use Nova command conventions for `--include` test targeting.
- Execute one command per changed spec path.
- If no related tests exist, report that explicitly.

## Workflow

1. Determine affected spec files from changed component/template scope.
2. For each changed spec file, run:
`node --max-old-space-size=26000 ./node_modules/@angular/cli/bin/ng test --karma-config=./karma.conf.js --watch=false --browsers=ChromeHeadlessCI --include <spec_relative_path>`
3. Capture pass/fail per spec and key error snippets when failures occur.
4. Return compact validation results suitable for parent-agent summaries.

## Reporting Checklist

- Tested spec files.
- Commands executed.
- Pass/fail per spec.
- Failure highlights (if any).
- Final validation status.
