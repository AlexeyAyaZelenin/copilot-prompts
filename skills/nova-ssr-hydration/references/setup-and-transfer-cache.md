# Setup And Transfer Cache

Nova is on Angular v17. SSR and hydration are tightly connected: server rendering creates the initial HTML, and hydration restores the app on the client without tearing down that DOM.

## Core Rules

- Keep server and client DOM output structurally identical
- Keep whitespace configuration consistent between browser and server builds
- Make sure CDN optimizations do not strip Angular comment nodes from SSR HTML

## SSR Setup

Typical Angular CLI flow:

- New app: `ng new --ssr`
- Existing app: `ng add @angular/ssr`

Angular's SSR guide highlights these files:

- `server.ts`
- `src/main.server.ts`
- `src/app/app.config.server.ts`

## Hydration Setup

In custom setups, add `provideClientHydration()` to the client bootstrap providers and mirror the provider setup on the server side.

```typescript
import { bootstrapApplication } from '@angular/platform-browser';
import { provideClientHydration } from '@angular/platform-browser';
import { provideRouter } from '@angular/router';
import { AppComponent } from './app/app.component';
import { APP_ROUTES } from './app/app.routes';

bootstrapApplication(AppComponent, {
    providers: [
        provideRouter(APP_ROUTES),
        provideClientHydration()
    ]
});
```

## Transfer Cache

Angular v17 caches `HttpClient` GET and HEAD requests on the server and reuses them during the initial client render.

```typescript
import { bootstrapApplication } from '@angular/platform-browser';
import {
    provideClientHydration,
    withHttpTransferCacheOptions
} from '@angular/platform-browser';

bootstrapApplication(AppComponent, {
    providers: [
        provideClientHydration(
            withHttpTransferCacheOptions({
                includePostRequests: true
            })
        )
    ]
});
```

Only opt into caching POST requests when the semantics are clearly safe.
