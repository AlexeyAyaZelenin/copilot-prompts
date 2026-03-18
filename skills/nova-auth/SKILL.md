---
name: nova-auth
description: Nova-only authentication and authorization patterns using Auth0, IdentityService, and route guards. Use only when working in the Nova application and implementing login flows, checking permissions, protecting routes, or working with user identity.
---

# Nova Authentication & Authorization

## Auth Flow

1. User lands on protected route
2. `AuthGuard` checks `IdentityService.hasOAuth` and `IdentityService.current`
3. If unauthenticated, redirect to `/signin`
4. Signin component exchanges Auth0 code for token via `auth.service.ts`
5. Token stored in `IdentityService.current` (Identity model)
6. `AuthRoleGuard` checks permissions via `IdentityService.hasPermission(module, item)`

## Core Services

| Service           | Path                               | Purpose                                |
| ----------------- | ---------------------------------- | -------------------------------------- |
| `IdentityService` | `src/app/core/identity.service.ts` | Current user, permissions, OAuth state |
| `AuthService`     | `src/app/core/auth.service.ts`     | Login/logout, token management         |
| `MenuService`     | `src/app/core/menu.service.ts`     | Navigation based on permissions        |

## Route Guards

### AuthGuard - Basic Authentication

```typescript
{
  path: 'compliance',
  canActivate: [AuthGuard],
  loadChildren: () => import('src/app/compliance/compliance.module')
}
```

### AuthRoleGuard - Permission-Based Access

```typescript
{
  path: 'admin/users',
  canActivate: [AuthRoleGuard],
  data: { moduleName: 'Admin', moduleItemName: 'Users' }
}
```

### Custom Feature Flag Guard

```typescript
const canMatch: CanMatchFn = () => {
  const ldFeatureManager = inject(LDFeatureManager);
  return ldFeatureManager.isDisabled(FeatureFlag.RemoveOldRoutes);
};

{
  path: 'legacy',
  canMatch: [canMatch],
  loadChildren: () => import('src/app/legacy/legacy.routes')
}
```

## Checking Permissions

```typescript
@Component({...})
export class MyComponent {
  private readonly identityService = inject(IdentityService);

    get canEdit(): boolean {
        return this.identityService.hasPermission('Compliance', 'Edit');
    }

    get currentUser(): Identity {
        return this.identityService.current;
    }

  get currentUserName(): string {
    return this.identityService.current?.name ?? '';
  }
}
```

## Auth0 Configuration

OAuth provider at `login-dev.ayahealthcare.com`. Configuration loaded from `services.config.js`:

```typescript
// Access via window object
const auth0Config = (window as any).servicesConfig.auth0;
```
