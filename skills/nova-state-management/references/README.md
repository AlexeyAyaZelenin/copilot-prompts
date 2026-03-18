# Nova State Management References

This skill is split into focused reference files so you can load only the store guidance that matches the task. These references cover NgRx Store, ComponentStore, and subscription lifecycle rules in Nova.

## Route By Task

- Use [ngrx-store.md](ngrx-store.md) for feature actions, reducers, selectors, effects, and route-level providers
- Use [component-store.md](component-store.md) for local complex component state
- Use [rxjs-lifecycle.md](rxjs-lifecycle.md) for declarative streams, operator selection, and subscription cleanup

## Cross-Skill Boundaries

- Use `nova-signals` for Angular v17 signal APIs and local signal state
- Use `typescript-strict-migration` for reducer nullability cleanup rules
