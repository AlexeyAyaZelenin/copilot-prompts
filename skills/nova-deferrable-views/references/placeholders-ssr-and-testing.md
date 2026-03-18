# Placeholders, SSR, And Testing

## Placeholder, Loading, And Error Blocks

- `@placeholder` is what the user sees before loading begins
- `@loading` is what the user sees while deferred code is fetching
- `@error` is what the user sees if loading fails

### Guidance

- Keep placeholders visually stable so the loaded content does not cause major layout shift
- Use `minimum` to avoid flicker when content loads quickly
- Use `after` on `@loading` so spinners appear only when loading is actually noticeable
- Always provide a `@placeholder` for user-facing defer blocks unless blank space is intentional

## SSR And Hybrid Rendering

In Angular v17 SSR or SSG:

- The server renders the placeholder state only, or nothing if no placeholder exists
- Trigger logic does not run on the server
- Client-side hydration or rendering later activates the defer behavior

## Common Pitfalls

- Deferring content visible at first paint and causing CLS
- Expecting a non-standalone dependency to lazy-split inside `@defer`
- Referencing a deferred component elsewhere in the same file and forcing eager loading
- Nesting `@defer (on immediate)` blocks that all fire together
- Forgetting that placeholder and loading dependencies are eagerly loaded

## Testing Deferrable Views

```typescript
import { Component } from '@angular/core';
import { DeferBlockBehavior, DeferBlockState, TestBed } from '@angular/core/testing';

it('renders the defer block states', async () => {
    TestBed.configureTestingModule({
        deferBlockBehavior: DeferBlockBehavior.Manual
    });

    @Component({
        standalone: true,
        template: `
            @defer {
                <nova-heavy-grid />
            } @placeholder {
                Placeholder
            } @loading {
                Loading
            }
        `
    })
    class HostComponent {}

    const fixture = TestBed.createComponent(HostComponent);
    const deferBlock = (await fixture.getDeferBlocks())[0];

    await deferBlock.render(DeferBlockState.Loading);
    await deferBlock.render(DeferBlockState.Complete);
});
```

Use manual mode when tests need to assert placeholder, loading, and complete states independently.
