# Checklist And Validation

## Implementation Checklist

- Create a standalone component with a `nova-` selector prefix
- Import required Material or Kendo modules
- Use design tokens from `_variables.scss`
- Apply responsive breakpoints using mixins
- Use new Angular control flow such as `@if` and `@for`
- Implement strict TypeScript with no `any`
- Use non-relative imports from `src/app/...`
- Create unit tests with Spectator
- Verify compilation in `nova-watch-start-no-open`
- Test responsive behavior at all breakpoints
- Validate accessibility including ARIA labels and keyboard navigation

## Visual Validation

- Compare the rendered component to the Figma design
- Check that colors match Nova tokens
- Verify spacing consistency
- Test at `700px`, `1366px`, `1600px`, and `1920px`

## Code Validation

- Run `nova-watch-start-no-open` and check for errors
- Verify there are no TypeScript compilation errors
- Ensure imports are non-relative
- Check that no `any` types are introduced

## Testing And Accessibility Validation

- Run unit tests with `npm test -- --include="**/path/to/file.spec.ts"`
- Verify all tests pass
- Add ARIA labels where needed
- Test keyboard navigation
- Verify color contrast ratios
- Test with a screen reader
