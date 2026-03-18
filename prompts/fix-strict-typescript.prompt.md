---
description: 'Fix strict TypeScript issues via custom strict fixer agent'
agent: strict-typescript-fixer
model: GPT-5.4 (copilot)
argument-hint: 'Path to strict TypeScript target (file or directory)'
---

Run the `strict-typescript-fixer` custom agent for `${input:path}`.

Requirements:

- Preserve runtime behavior.
- Follow strict-fix code rules from `.github/skills/typescript-strict-migration/SKILL.md`.
- Use checklist-driven orchestration in `typescript_errors.md` with compile/diagnostic verification before marking work complete.
- Treat warning-only watch-task output as non-blocking unless diagnostics fail or task output shows an explicit compile error.
