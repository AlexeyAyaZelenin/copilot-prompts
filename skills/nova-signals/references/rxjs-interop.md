# RxJS Interop

Use this reference when a boundary between Angular signals and RxJS is unavoidable. In Angular v17, `@angular/core/rxjs-interop` was still developer preview.

## `toSignal()`

- Creates a signal from an Observable
- Subscribes immediately, like the `async` pipe
- Provide `initialValue` for asynchronous sources when you need a concrete starting value
- If you omit `initialValue`, the signal returns `undefined` until the first emission
- Use `requireSync: true` only when the Observable is guaranteed to emit synchronously on subscription
- By default cleanup follows the creation context; use `manualCleanup` only when the source manages its own lifetime cleanly
- Handle errors upstream when possible; otherwise the signal throws when read
- If the source completes, the signal keeps returning the last emitted value
- Avoid calling `toSignal` repeatedly for the same shared source

```typescript
import { ChangeDetectionStrategy, Component, computed, inject } from '@angular/core';
import { toSignal } from '@angular/core/rxjs-interop';
import { startWith } from 'rxjs';
import { SearchFacade } from 'src/app/search/data/search.facade';

@Component({
    selector: 'nova-search-count',
    standalone: true,
    changeDetection: ChangeDetectionStrategy.OnPush,
    template: `{{ resultCount() }}`
})
export class SearchCountComponent {
    private readonly facade = inject(SearchFacade);

    readonly results = toSignal(
        this.facade.results$.pipe(startWith<string[]>([])),
        { initialValue: [] as string[] }
    );

    readonly resultCount = computed(() => this.results().length);
}
```

## `toObservable()`

- Creates an Observable backed by a signal
- Uses an effect internally, so it needs an injection context unless an `Injector` is supplied
- The first emission may be synchronous if a value is already available
- Later emissions are asynchronous
- Multiple back-to-back `set()` calls are stabilized; subscribers see the latest settled value, not every intermediate write
- Use this when the next stage is naturally RxJS, such as `switchMap`, `combineLatest`, or effect orchestration

```typescript
import { Injectable, inject, signal } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { toObservable } from '@angular/core/rxjs-interop';
import { switchMap } from 'rxjs';

@Injectable({ providedIn: 'root' })
export class SearchService {
    private readonly http = inject(HttpClient);

    readonly query = signal('');
    readonly results$ = toObservable(this.query).pipe(
        switchMap((query) => this.http.get(`/api/search?q=${query}`))
    );
}
```