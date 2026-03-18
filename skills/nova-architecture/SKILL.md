---
name: nova-architecture
description: Nova-only project architecture, tech stack, folder structure, and external dependencies guidance. Use only when the active task is in the Nova application and you need to understand codebase structure, locate features, understand module organization, or work with external services like Core API, Auth0, or services.config.js.
---

# Nova Architecture

Nova is an Angular v17 enterprise healthcare application for Aya Healthcare's internal operations with 50+ feature modules.

## Tech Stack

| Technology | Version | Notes                                    |
| ---------- | ------- | ---------------------------------------- |
| Angular    | 17.3.12 | Standalone components, new control flow  |
| NgRx       | 17.2.0  | Global state management                  |
| Material   | 16.2.14 | MDC-based components                     |
| Kendo UI   | 17.2.0  | Data grids, charts                       |
| RxJS       | 7.8.1   | Import from `rxjs`, not `rxjs/operators` |
| Node       | ≥20.18  | Required for builds                      |
| npm        | ≥10.8   | Package manager                          |

## Project Structure

```
src/app/
├── core/              # Singleton services (IdentityService, AuthService, MenuService)
├── shared/            # Reusable components, pipes, directives, models
├── [feature]/         # 50+ feature modules (compliance, recruiting, billing, etc.)
│   ├── components/
│   ├── services/
│   ├── models/
│   ├── [feature].routes.ts
│   └── store/        # NgRx state (actions, effects, reducers, selectors)
└── app.routes.ts     # Root routing with lazy-loaded modules
```

## Lazy Loading Pattern

Each feature uses lazy loading in `app.routes.ts`:

```typescript
{
  path: 'compliance',
  loadChildren: () => import('src/app/compliance/compliance.routes')
}
```

Features requiring global state provide it at route level:

```typescript
{
  path: 'clinical',
  providers: [
    provideState(featureKey, reducers),
    provideEffects([ClinicalEffects])
  ],
  loadChildren: () => import('src/app/clinical/clinical.routes')
}
```

## External Dependencies

### Core API

Backend REST API - must run locally at `localhost:8088` or use DEV environment.

### services.config.js

Runtime configuration loaded via `window.servicesConfig`. **Never import directly** - access via:

```typescript
// Inject the APP_CONFIG token
const config = inject(APP_CONFIG);

// Or access window object
const apiUrl = (window as any).servicesConfig.apiUrl;
```

### Auth0

OAuth provider at `login-dev.ayahealthcare.com`. See nova-auth skill for details.

### LaunchDarkly

Feature flag service. See nova-feature-flags skill for usage patterns.

## Key Directories

| Directory             | Purpose                                   |
| --------------------- | ----------------------------------------- |
| `src/app/core/`       | Singleton services provided at root       |
| `src/app/shared/`     | Reusable UI components, pipes, directives |
| `src/app/compliance/` | Compliance management features            |
| `src/app/recruiting/` | Recruiter workflows                       |
| `src/app/billing/`    | Billing and invoicing                     |
| `src/app/clinical/`   | Clinical operations                       |
| `src/app/admin/`      | Administrative tools                      |
| `assets/scss/`        | Global SCSS variables, mixins             |

## Memory Requirements

Builds use approximately 26GB memory. Ensure sufficient system resources.
