# NgRx Reducer Rules

## Use This Reference When

- Reducer state and feature interfaces disagree on nullability
- A reducer uses a local transitional alias during strict migration
- Selected-entity or slice contracts mix `null` and `undefined`
- Duplicate action registrations or overly broad root-state extensions appear during cleanup

## Core Rules

- Do: when a reducer uses a local widened or nulled state alias for strict migration, keep the exported reducer function signature aligned with that alias
- Before: `export function picklesReducer(state: TravelXNewState['pickles'] | undefined, action: Action)`
- After: `export function picklesReducer(state: PicklesState | undefined, action: Action)`

- Do: prefer fixing the feature-state interface to match reducer runtime values, including `null` initial values, and type the reducer directly to that interface
- Before: `selectedContract: CandidateContract;` while `initialState.selectedContract = null`
- After: `selectedContract: CandidateContract | null;`

- Do: keep feature slice contracts isolated. Do not extend feature state from root state types or add unrelated root properties
- Before: `export interface PicklesState extends RootState { router: ...; ... }`
- After: `export interface PicklesState { ... }`

- Do: use a single empty sentinel for selected entities. Prefer `null` consistently and avoid mixing `undefined` and `null`
- Before: `selectedContract: contract`
- After: `selectedContract: contract ?? null`

- Do: when migrating reducer nullability, move from root-slice typing to the feature interface as the source of truth
- Before: `export const initialState: TravelXNewState['orientations'] = { ... }` and `export function orientationsReducer(state: TravelXNewState['orientations'] | undefined, action: Action)`
- After: `export const initialState: OrientationsState = { ... }` and `export function orientationsReducer(state: OrientationsState | undefined, action: Action)`

- Do not: register the same action creator multiple times in one `on(...)` handler
- Before: `on(getPickleSourcesFailure, getPickleSourcesFailure, (state, action) => ({ ...state, error: action.error }))`
- After: `on(getPickleSourcesFailure, (state, action) => ({ ...state, error: action.error }))`

- Do not: keep the exported reducer function typed as the original feature-state contract when the reducer intentionally operates on a stricter transitional alias
