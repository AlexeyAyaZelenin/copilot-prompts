# Nova SSR And Hydration References

This skill is split into focused reference files so you can load only the SSR or hydration guidance that matches the task. These references target Angular v17 SSR and client hydration behavior.

## Route By Task

- Use [setup-and-transfer-cache.md](setup-and-transfer-cache.md) for SSR setup, hydration wiring, and transfer cache
- Use [browser-only-and-constraints.md](browser-only-and-constraints.md) for render hooks, browser-only logic, and hydration mismatch causes
- Use [skip-hydration-and-review.md](skip-hydration-and-review.md) for `ngSkipHydration`, third-party DOM libraries, pitfalls, and review questions

## Cross-Skill Boundaries

- Use `nova-signals` for deeper render-hook guidance
- Use `nova-deferrable-views` when the work is about `@defer` behavior under SSR or SSG
