# Royal HRMS — Development Guidelines

**Status:** Mandatory · **Applies to:** All human contributors and AI coding agents · **Owner:** Engineering

## 0. Purpose & Scope

This document is the **single source of truth** for how code is written, organized, reviewed, and merged in the Royal HRMS Flutter application. It is binding for:

- Every human engineer contributing to this repository.
- Every AI agent (Claude, Copilot, or otherwise) generating or modifying code in this repository.

If a pull request, a generated diff, or a design decision conflicts with this document, **this document wins** unless an explicit, written exception is approved by the architecture owner and recorded in the PR description.

This document describes the architecture already implemented in `lib/` (Clean Architecture + Feature-First + Riverpod). It does not introduce a new architecture — it codifies the one in place so that every future change extends it consistently instead of drifting from it.

---

## 1. Project Architecture

Royal HRMS is built as a **Feature-First, Clean Architecture, Riverpod-driven** Flutter application, designed to scale to many features and many concurrent contributors without the codebase degrading into a tangle of cross-feature dependencies.

Three architectural pillars, all mandatory:

1. **Feature-First** — code is organized primarily by business capability (`auth`, `employees`, `payroll`, …), not by technical type (`all_models/`, `all_pages/`).
2. **Clean Architecture** — each feature is internally split into `domain`, `data`, and `presentation`, with a strict, one-directional dependency rule (see §4).
3. **Riverpod** — the only state management and dependency-injection mechanism in this codebase.

```
┌─────────────────────────────────────────────────────────┐
│                        main.dart                          │
│              ProviderScope → RoyalHrmsApp                 │
└───────────────────────────┬─────────────────────────────┘
                            │
          ┌─────────────────┼─────────────────┐
          ▼                 ▼                 ▼
       core/             features/           shared/
  (infrastructure,    (business verticals,  (cross-feature
   no business logic)  one folder each)      generic contracts)
```

- **`core/`** — app-wide infrastructure: networking, storage, routing, theme, error types, logging, generic widgets/utils. Contains **zero** business logic and **zero** knowledge of any specific feature.
- **`features/`** — one folder per business capability. Each feature is internally layered (domain/data/presentation) and must not directly import another feature's internals.
- **`shared/`** — generic, reusable contracts used by *multiple* features (e.g. `ApiResponse<T>`, `PaginatedResponse<T>`). Not a dumping ground — anything feature-specific does not belong here.

---

## 2. Feature-First Folder Structure

This is the canonical structure. Every feature **must** match it exactly — do not invent variations.

```
lib/
├── core/
│   ├── network/            # ApiClient, Dio config, interceptors
│   │   └── interceptors/
│   ├── storage/             # SecureStorageService, TokenStorageService, UserSessionService
│   │   └── models/
│   ├── router/              # RoutePaths, RouteGuard, app_router.dart
│   ├── constants/           # AppConstants, ApiConstants, StorageKeys, enums
│   ├── theme/                # AppColors, AppTypography, AppTheme
│   ├── services/             # LoggerService, AuthStatusNotifier
│   ├── widgets/               # AppLoader, AppErrorView (generic, reusable)
│   ├── utils/                 # Validators, DateFormatter, extensions
│   └── errors/                # AppException hierarchy, Failure (freezed)
│
├── features/
│   └── <feature_name>/
│       ├── data/
│       │   ├── datasource/       # <Feature>RemoteDataSource (+ Impl)
│       │   ├── models/            # freezed/json API models
│       │   └── repositories/      # <Feature>RepositoryImpl
│       ├── domain/
│       │   ├── entities/           # plain domain objects, no JSON awareness
│       │   ├── repositories/       # <Feature>Repository (abstract contract)
│       │   └── usecases/            # single-purpose business operations
│       ├── presentation/
│       │   ├── pages/                # route-level screens
│       │   ├── widgets/               # feature-local, reusable UI pieces
│       │   └── providers/             # Riverpod wiring + view-state notifiers
│       └── feature_module.dart        # barrel export — the feature's public API
│
├── shared/
│   ├── models/                # ApiResponse<T>, PaginatedResponse<T>
│   └── widgets/
│
└── main.dart
```

| Folder | Responsibility | Must NOT contain |
|---|---|---|
| `domain/entities` | Pure business objects | JSON annotations, Flutter imports |
| `domain/repositories` | Abstract contracts | Implementation code |
| `domain/usecases` | Single business operation each | UI code, Dio/HTTP code |
| `data/datasource` | Raw API access via `ApiClient` | Business rules, UI |
| `data/models` | Wire-format (JSON) models | Business rules |
| `data/repositories` | Implements the domain contract | UI code |
| `presentation/pages` | Route-level screens (one per `GoRoute`) | API calls, repository instantiation |
| `presentation/widgets` | Reusable UI fragments for this feature | API calls |
| `presentation/providers` | Riverpod providers/notifiers | Widget/UI code |

A new feature is created by replicating this exact skeleton — see §17.

---

## 3. Clean Architecture Guidelines

### 3.1 Dependency Direction (non-negotiable)

```
presentation  ──depends on──▶  domain  ◀──depends on──  data
```

- `domain` depends on **nothing** in this app (no Flutter, no Dio, no Riverpod). It is plain Dart.
- `data` depends on `domain` (implements its interfaces) and on `core/network`.
- `presentation` depends on `domain` (via abstract repository types) and is wired to `data` only through a Riverpod provider — never by importing the `*RepositoryImpl` class directly into a widget.

### 3.2 Layer rules

- **Domain layer**: Defines `abstract class <Feature>Repository` and (when business logic exists) usecases that orchestrate repository calls. No Flutter SDK imports. No JSON. No Dio.
- **Data layer**: `<Feature>RemoteDataSourceImpl` talks to `ApiClient` and decodes JSON into models. `<Feature>RepositoryImpl implements <Feature>Repository`, depends only on the datasource (never on `ApiClient` directly), and maps data-layer models to domain entities before returning them.
- **Presentation layer**: Widgets never call repositories directly. Widgets call **providers**; providers/notifiers call repositories.

### 3.3 Worked example (current pattern in this codebase)

```dart
// domain/repositories/employees_repository.dart
abstract class EmployeesRepository {
  Future<Employee> getEmployeeById(String id);
}

// data/datasource/employees_remote_datasource.dart
abstract class EmployeesRemoteDataSource {
  Future<EmployeeModel> fetchEmployeeById(String id);
}

class EmployeesRemoteDataSourceImpl implements EmployeesRemoteDataSource {
  EmployeesRemoteDataSourceImpl(this._apiClient);
  final ApiClient _apiClient;

  @override
  Future<EmployeeModel> fetchEmployeeById(String id) async {
    final response = await _apiClient.get<Map<String, dynamic>>('/employees/$id');
    return EmployeeModel.fromJson(response.data!);
  }
}

// data/repositories/employees_repository_impl.dart
class EmployeesRepositoryImpl implements EmployeesRepository {
  EmployeesRepositoryImpl(this._remoteDataSource);
  final EmployeesRemoteDataSource _remoteDataSource;

  @override
  Future<Employee> getEmployeeById(String id) async {
    final model = await _remoteDataSource.fetchEmployeeById(id);
    return model.toEntity(); // data model → domain entity
  }
}
```

---

## 4. Riverpod State Management Rules

Riverpod (`flutter_riverpod`) is the **only** state management solution in this project (see §23 — no exceptions).

### 4.1 Allowed provider types

| Provider | Use for |
|---|---|
| `Provider<T>` | Services, repositories, datasources, anything stateless/constant per app lifetime |
| `NotifierProvider<N, T>` | Synchronous mutable state (see `AuthStatusNotifier` in `core/services/auth_status_notifier.dart`) |
| `AsyncNotifierProvider<N, T>` | Mutable state that is loaded/derived asynchronously |
| `FutureProvider<T>` / `StreamProvider<T>` | One-shot or streamed async reads with no mutation methods |

**Forbidden:** legacy `StateNotifierProvider`/`ChangeNotifierProvider` (from `package:flutter_riverpod/legacy.dart`). This project standardizes on `Notifier`/`AsyncNotifier`. Do not import `legacy.dart`.

### 4.2 Where providers live

- Core/cross-cutting providers are declared **beside** the class they expose (e.g. `apiClientProvider` at the bottom of `core/network/api_client.dart`, `tokenStorageServiceProvider` in `core/storage/token_storage_service.dart`).
- Feature providers live in `features/<feature>/presentation/providers/<feature>_providers.dart`. If a feature grows complex view-state, split per-screen notifiers into additional files in the same `providers/` folder (e.g. `employee_detail_providers.dart`) — do not let one file grow unbounded.

### 4.3 Usage rules

- Use `ref.watch(...)` inside `build()` methods and inside other providers — it creates a reactive subscription.
- Use `ref.read(...)` inside callbacks, `initState`, and notifier methods — never `ref.watch` outside a reactive build context.
- Use `ref.select((s) => s.field)` when a widget only needs one field of a larger state object, to avoid rebuilding on unrelated changes (see §21).
- All business logic that mutates state belongs in a `Notifier`/`AsyncNotifier` method — never inline in a widget's `onPressed`/callback beyond a single `ref.read(...).doThing()` call.

### 4.4 Naming

Every provider is named `lowerCamelCase` and ends in `Provider`: `apiClientProvider`, `authStatusNotifierProvider`, `employeesRepositoryProvider`. Notifier classes are `PascalCase` and end in `Notifier` (e.g. `AuthStatusNotifier`).

---

## 5. Repository Pattern Rules

1. **One repository per feature.** Interface at `domain/repositories/<feature>_repository.dart`, implementation at `data/repositories/<feature>_repository_impl.dart`. Never create a second repository for the same feature ("no duplicate repositories" — see §23).
2. The interface is an `abstract class <Feature>Repository`. The implementation is `class <Feature>RepositoryImpl implements <Feature>Repository`.
3. The implementation is constructor-injected with its datasource **only** — never with `ApiClient` directly, never with another feature's repository.
4. Methods are named after the **domain operation**, not the HTTP verb: `getEmployees()`, `submitLeaveRequest()`, `approveLeaveRequest(id)` — not `get()`, `post()`, `fetchData()`.
5. Repositories return domain entities (or throw `AppException`, see §11) — they never return raw `Response`, raw JSON `Map`, or a data-layer model to callers outside the data layer.
6. Repository code must **not** import `package:flutter/material.dart` or any widget. Repositories are UI-agnostic by construction.
7. Cross-feature data needs are composed at the **provider/usecase** level (a provider may depend on two repositories), never by importing one feature's repository implementation into another feature's repository.

---

## 6. Dio Networking Standards

1. **Single HTTP client.** All network access goes through `ApiClient` (`core/network/api_client.dart`) via `apiClientProvider`. No feature, page, or widget may construct its own `Dio()` instance.
2. **Endpoints are constants.** Every path lives in `core/constants/api_constants.dart` (e.g. `ApiConstants.loginEndpoint`). No string-literal paths in datasource code.
3. **Fixed interceptor pipeline**, configured once in `dioProvider`: `RequestInterceptor → AuthInterceptor → ResponseInterceptor → ErrorInterceptor`. Do not add per-feature interceptors, duplicate logging, or reorder this pipeline.
4. **JWT handling is centralized.** `AuthInterceptor` attaches the bearer token and owns the 401 → refresh → retry flow. Do not write feature-level token refresh or manual `Authorization` header injection anywhere else.
5. Datasources call only `ApiClient.get/post/put/patch/delete` and parse the typed response — they never touch `Dio` or `Response` internals directly.
6. Timeouts and `baseUrl` are centralized in `ApiConstants`. Any per-request override must be justified in a code comment and reviewed.

```dart
// ✅ Correct
class LeaveRemoteDataSourceImpl implements LeaveRemoteDataSource {
  LeaveRemoteDataSourceImpl(this._apiClient);
  final ApiClient _apiClient;

  Future<LeaveRequestModel> submit(LeaveRequestModel request) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      ApiConstants.leaveRequestsEndpoint,
      data: request.toJson(),
    );
    return LeaveRequestModel.fromJson(response.data!);
  }
}

// ❌ Forbidden — bespoke Dio instance, hardcoded path
final _dio = Dio();
await _dio.post('https://api.royalhrms.com/v1/leave', data: body);
```

---

## 7. GoRouter Navigation Standards

1. **No hardcoded route strings.** Every path is a constant in `core/router/route_paths.dart` (`RoutePaths.dashboard`, etc.).
2. **Adding a route** requires all four steps, in order:
   1. Add the path constant to `RoutePaths`.
   2. Build the page in `features/<feature>/presentation/pages/`.
   3. Export the page from the feature's `feature_module.dart`.
   4. Register the `GoRoute` in `core/router/app_router.dart`.
3. **Public vs. protected**: `RouteGuard.publicPaths` is the exhaustive list of unauthenticated-accessible routes. Every other route is protected automatically — do not add ad-hoc `if (!loggedIn)` checks inside page widgets.
4. **Role-based access**: populate `RouteGuard.routeRoleAccess[RoutePaths.x] = [UserRole.admin, UserRole.hr]`. Never hand-roll a role check inside a page's `build()` method.
5. **Navigation calls** use `context.go(RoutePaths.x)` / `context.push(RoutePaths.x)`. Do not use `Navigator.push(MaterialPageRoute(...))` for top-level, deep-linkable screens — that bypasses the route guard entirely.

---

## 8. UI Development Standards

Widgets render state and forward user intent. They do not own logic.

**Strictly forbidden inside any widget (page or component):**
- Direct API/Dio calls.
- Direct repository or datasource instantiation/usage.
- Direct `SecureStorage`/`TokenStorageService`/`UserSessionService` access.
- Business rules (e.g. leave-balance calculations, payroll math, validation beyond simple presentation formatting).

```dart
// ❌ Forbidden — widget reaching into the network/data layer directly
class EmployeesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    dio.get('/employees'); // NEVER do this in a widget
    ...
  }
}

// ✅ Correct — widget only watches a provider
class EmployeesPage extends ConsumerWidget {
  const EmployeesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employeesAsync = ref.watch(employeesListProvider);
    return employeesAsync.when(
      data: (employees) => EmployeesListView(employees: employees),
      loading: () => const AppLoader(),
      error: (error, _) => AppErrorView(
        message: Failure.fromException(error as AppException).message,
        onRetry: () => ref.invalidate(employeesListProvider),
      ),
    );
  }
}
```

Additional rules:

- Use `ConsumerWidget` / `ConsumerStatefulWidget` exclusively for any widget that reads a provider — never bridge Riverpod into a plain `StatefulWidget` via manual listeners.
- `presentation/pages` = one screen per `GoRoute`. `presentation/widgets` = reusable pieces composed by those pages. A page file should mostly be composition, not a 400-line `build()` method.
- Prefer `const` constructors everywhere possible.
- No direct database/secure-storage access from the presentation layer — always via an injected service exposed through a provider.

---

## 9. Theme and Design System Rules

1. **No hardcoded colors.** Never write `Color(0xFF...)` or `Colors.blue` in feature code. Always reference `AppColors` (`core/theme/app_colors.dart`) or `Theme.of(context).colorScheme`.
2. **No hardcoded text styles.** Use `Theme.of(context).textTheme.*` (backed by `AppTypography`) — do not inline `TextStyle(fontSize: 16, fontWeight: ...)`.
3. **Themes**: `AppTheme.light` and `AppTheme.dark` (`core/theme/app_theme.dart`) are the only `ThemeData` definitions. Do not construct a third theme or override `ThemeData` ad hoc inside a page.
4. **No hardcoded user-facing strings duplicated across files.** A label used in more than one place must be defined once (a feature-level constants file, or eventually `intl` message bundles) and referenced — never copy-pasted.
5. Any new design token (spacing, radius, elevation) is added to `core/theme/`, never invented inline as a magic number in a widget.

```dart
// ❌ Forbidden
Container(color: Color(0xFF1B5E20), child: Text('Dashboard', style: TextStyle(fontSize: 22)));

// ✅ Correct
Container(
  color: AppColors.primary,
  child: Text('Dashboard', style: Theme.of(context).textTheme.titleLarge),
);
```

---

## 10. Error Handling Standards

The error pipeline is fixed and must not be bypassed:

```
Dio failure
   │  mapDioExceptionToAppException()  [core/errors/exceptions.dart]
   ▼
AppException  (ApiException / NetworkException / UnauthorizedException / ValidationException / …)
   │  thrown by datasource/repository
   ▼
Provider / AsyncNotifier  (caught by AsyncValue, or explicitly caught)
   │  Failure.fromException(exception)  [core/errors/failures.dart]
   ▼
Failure  (ServerFailure / NetworkFailure / UnauthorizedFailure / ValidationFailure / CacheFailure / UnknownFailure)
   ▼
UI renders via AppErrorView / inline message, switching on Failure type when the message must differ by category
```

Rules:

1. Only `AppException` subclasses (from `core/errors/exceptions.dart`) may be thrown from `data`/`domain` code. Never throw a raw `String`, `Exception('...')`, or let a `DioException` escape past the data layer.
2. `mapDioExceptionToAppException` is the **only** place a `DioException` is interpreted. Do not add a second `catch (DioException e)` translation elsewhere.
3. Any error surfaced to the UI is converted to a `Failure` via `Failure.fromException()` before being displayed. The UI never inspects a raw exception's `.toString()` for user-facing copy.
4. Full-screen/blocking errors use `AppErrorView` (`core/widgets/app_error_view.dart`). Do not build a bespoke error layout per feature.
5. All logging goes through `LoggerService` (`core/services/logger_service.dart`). `print()`/`debugPrint()` are not permitted outside throwaway local debugging, and must never be committed.
6. Never log a `Failure`/`AppException` that contains tokens, passwords, or PII (see §22).

---

## 11. Freezed and Model Standards

1. Every immutable data-carrying class — API models, `Failure`, generic envelopes — uses `@freezed` (or `@Freezed(genericArgumentFactories: true)` for generic classes like `ApiResponse<T>`). No hand-written `copyWith`, `==`, or `hashCode`.
2. File convention for JSON-backed models:
   ```dart
   part '<name>.freezed.dart';
   part '<name>.g.dart';

   @freezed
   abstract class XModel with _$XModel {
     const factory XModel({required String id, ...}) = _XModel;
     factory XModel.fromJson(Map<String, dynamic> json) => _$XModelFromJson(json);
   }
   ```
3. Run `dart run build_runner build --delete-conflicting-outputs` after adding or changing **any** `@freezed`/`@JsonSerializable` class, and commit the resulting `*.freezed.dart` / `*.g.dart` files in the **same PR**. Generated files must never be hand-edited.
4. **Models vs. entities**: `data/models` classes are wire-format (JSON-aware) and live only in the data layer. `domain/entities` classes are plain Dart (no JSON annotations) and are what repositories return. A `toEntity()`/mapping step converts one to the other inside the repository implementation — entities never leak JSON concerns into `domain`/`presentation`.
5. Generic envelopes already exist — reuse them, do not reinvent: `ApiResponse<T>` and `PaginatedResponse<T>` in `shared/models/`. Any new paginated or enveloped endpoint must decode through these, not a bespoke per-feature wrapper.

---

## 12. Naming Conventions

| Element | Convention | Example |
|---|---|---|
| File names | `snake_case.dart` | `employees_repository_impl.dart` |
| Classes / Enums | `PascalCase` | `EmployeesRepositoryImpl`, `UserRole` |
| Abstract repository | `<Feature>Repository` | `LeaveRepository` |
| Repository impl | `<Feature>RepositoryImpl` | `LeaveRepositoryImpl` |
| Remote datasource | `<Feature>RemoteDataSource` / `Impl` | `LeaveRemoteDataSourceImpl` |
| Providers | `lowerCamelCaseProvider` | `leaveRepositoryProvider` |
| Notifier classes | `PascalCaseNotifier` | `AuthStatusNotifier` |
| Private fields | `_camelCase` | `_apiClient` |
| Constants classes | `PascalCase` with private constructor, `static const` members | `ApiConstants._()` |
| Route paths | lower-kebab, leading slash | `/employees`, `/leave-requests` |
| Test files | mirror source path, suffix `_test.dart` | `test/features/leave/leave_repository_test.dart` |
| Freezed JSON keys (non-camelCase APIs) | `@JsonKey(name: 'snake_case_key')` | `@JsonKey(name: 'access_token')` |

---

## 13. Code Review Checklist

Every PR must pass this checklist before merge — reviewers should reject PRs that fail any item:

- [ ] Change lives in the correct layer (`domain`/`data`/`presentation`) and the correct feature folder.
- [ ] No widget contains an API call, repository call, or storage call directly.
- [ ] No hardcoded colors, text styles, or duplicated user-facing strings.
- [ ] No new route string literals — `RoutePaths` updated instead.
- [ ] New/changed models use `@freezed`; generated files are included in the diff.
- [ ] Errors are thrown as `AppException` and surfaced as `Failure` — no raw exceptions reach the UI.
- [ ] No duplicate service, repository, or provider was created where an existing one should have been reused.
- [ ] No new state-management package was introduced.
- [ ] `flutter analyze` is clean; no new lints suppressed without justification.
- [ ] PR touches only the feature(s) described in its description — no unrelated files changed.
- [ ] Tests added/updated for new business logic (usecases, notifiers, mappers).
- [ ] Naming follows §12.

---

## 14. Git Branching Strategy

- `main` — always production-ready/releasable.
- `develop` — integration branch (if/when release trains are introduced); otherwise feature branches merge directly to `main` behind review.
- Feature branches: `feature/<feature-name>-<short-description>` e.g. `feature/leave-balance-calculation`.
- Fixes: `fix/<short-description>` e.g. `fix/auth-token-refresh-loop`.
- Chores/infra: `chore/<short-description>` e.g. `chore/upgrade-go-router`.
- Releases: `release/<version>` e.g. `release/1.2.0`.

**Commit messages** follow Conventional Commits: `type(scope): description`, e.g. `feat(leave): add leave balance usecase`, `fix(auth): correct refresh-token retry guard`. Types: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`.

---

## 15. Merge Conflict Prevention Guidelines

1. **Feature ownership**: a PR touches one feature's folder (`features/<name>/`) unless it is explicitly a `core/`-level or `shared/`-level change.
2. **`core/` changes are high-blast-radius**: keep them in their own, smaller PRs, and flag them for wider review since every feature depends on `core/`.
3. **Small, frequent PRs** beat large, long-lived branches. Rebase on `main` often rather than merging `main` in at the end.
4. **Do not reformat or reorder unrelated code** in a PR that's meant to do one thing — unrelated whitespace/import-order churn is a common avoidable conflict source.
5. **Generated files** (`*.freezed.dart`, `*.g.dart`): never hand-edit; regenerate locally with `build_runner` rather than resolving conflicts inside generated code.
6. **`feature_module.dart` barrels**: when two contributors add exports to the same feature's barrel concurrently, prefer rebasing immediately and re-running codegen rather than manually merging generated-adjacent diffs.

---

## 16. File Creation Rules

1. A new **feature** must replicate the full skeleton in §2 exactly: `data/{datasource,models,repositories}`, `domain/{entities,repositories,usecases}`, `presentation/{pages,widgets,providers}`, `feature_module.dart`. Do not omit a folder because it's empty yet — keep the structure consistent across all features.
2. No new **top-level `lib/` folder** beyond `core/`, `features/`, `shared/` without an explicit architecture review and an update to this document.
3. No business logic is ever added directly inside `core/` or `shared/` — those folders stay generic and feature-agnostic. If something feels feature-specific, it belongs in `features/<name>/`, not `core/`.
4. No second "utils" or "helpers" dumping ground inside a feature folder — feature-agnostic helpers go in `core/utils/`; feature-specific ones live next to where they're used inside that feature.
5. Every new file follows the naming conventions in §12 and the import/dependency direction in §3.

---

## 17. Team Collaboration Standards

1. PR descriptions state **which feature/layer changed** and link the originating ticket/issue.
2. One feature or one bug per PR — do not bundle unrelated changes.
3. Tag the relevant feature's usual reviewer(s); cross-cutting (`core/`) PRs get a wider review group.
4. Any deviation from this document must be called out explicitly in the PR description with a rationale, and requires explicit reviewer sign-off — silent deviation is treated as a defect, not a style choice.
5. **AI agents**: before generating or modifying code in this repository, read this document in full and conform to it exactly, including folder placement, naming, and the forbidden-practices list in §23. When a requested change would violate this document, the agent should flag the conflict rather than silently working around it.

---

## 18. SOLID Principles

| Principle | What it means here | Example |
|---|---|---|
| **S** — Single Responsibility | A class has one reason to change. A datasource only knows HTTP; a repository only fulfills its domain contract; a notifier only manages one screen's state. | `EmployeesRemoteDataSourceImpl` never contains UI or validation logic. |
| **O** — Open/Closed | Extend behavior by adding new types/methods, not by editing shared infrastructure for one special case. | Add a new `Interceptor` rather than special-casing one endpoint inside `ApiClient`. |
| **L** — Liskov Substitution | Any `<Feature>RepositoryImpl` must be fully substitutable for its `<Feature>Repository` interface, including in tests with a fake implementation. | Tests inject a `FakeLeaveRepository implements LeaveRepository` with no special-casing required by callers. |
| **I** — Interface Segregation | Repository interfaces stay small and feature-scoped. | No god `HrmsRepository` covering employees, leave, and payroll — one interface per feature. |
| **D** — Dependency Inversion | `presentation` depends on the abstract `<Feature>Repository`, never on the concrete `Impl`, except inside the provider definition that wires them together. | `employeesProvider` depends on `EmployeesRepository`; only `employeesRepositoryProvider`'s body references `EmployeesRepositoryImpl`. |

---

## 19. DRY Principles

- **No duplicate services.** One `ApiClient`, one `LoggerService`, one `TokenStorageService`, one `UserSessionService`. Check `core/` and `shared/` before writing a new helper that might already exist.
- **No duplicate repositories.** One repository interface + implementation per feature (§5). Cross-feature composition happens at the provider/usecase level.
- **Shared envelopes are reused, not reinvented.** `ApiResponse<T>` / `PaginatedResponse<T>` cover every wrapped/paginated endpoint.
- **Shared UI states are reused.** `AppLoader` / `AppErrorView` cover loading/error presentation — do not build a new spinner or error card per feature.
- **Validation/formatting is centralized.** `Validators` and `DateFormatter` in `core/utils/` are the only place input validation and date formatting logic should live.

---

## 20. Performance Guidelines

1. Prefer `const` constructors and `const` widgets wherever the data allows it.
2. Use `ListView.builder` / `SliverList.builder` for any collection — never eagerly build large widget lists.
3. Use `ref.select((state) => state.someField)` to subscribe to the minimal slice of provider state a widget actually needs, instead of watching the whole object.
4. Split widgets so only the subtree that needs a given provider's data watches it — avoid `ref.watch` at the top of a large page when only one child needs it.
5. List/collection endpoints must be paginated through `PaginatedResponse<T>` — never request an unbounded list from the backend.
6. Debounce user-driven search/filter input (`AppConstants.defaultDebounceDuration` is the standard debounce window).
7. Dispose controllers, streams, and subscriptions in `ConsumerStatefulWidget.dispose()`.
8. Avoid rebuilding a whole page on every keystroke — isolate text fields with their own local state where the value isn't needed elsewhere until submit.

---

## 21. Security Guidelines

1. **Tokens live only in `TokenStorageService`** (backed by `flutter_secure_storage`). Never store a token in `SharedPreferences`, a global variable, or in-memory-only state that could outlive a logout.
2. **Never log secrets.** `LoggerService` request/response logging must never include tokens, passwords, or PII — scrub sensitive fields before logging.
3. **No hardcoded secrets or API keys** in source. Environment-specific configuration is managed outside the repository (build-time config / secure CI secrets), never committed.
4. **Client-side role checks (`RouteGuard.routeRoleAccess`) are UX convenience only.** The backend must independently enforce authorization on every request — never treat client-side gating as a security boundary.
5. **Session teardown is centralized.** Logout/401-expiry always goes through `AuthStatusNotifier.setUnauthenticated()`, which clears both `TokenStorageService` and `UserSessionService`. Do not hand-roll partial session clearing elsewhere.
6. **Validate all user input** via `core/utils/validators.dart` before it is sent to the API — never trust client input as pre-sanitized on the backend either, but always validate client-side first for UX and defense-in-depth.
7. Treat any new third-party SDK that touches HR/PII data as a security review item before integration, not after.

---

## 22. Strict Rules (Forbidden Practices)

These are zero-tolerance rules. A PR violating any of these is not mergeable as-is, regardless of how good the rest of the change is.

| # | Rule | Why |
|---|---|---|
| 1 | No API calls inside widgets | Breaks testability and the Clean Architecture boundary (§3, §8) |
| 2 | No business logic inside UI | Logic must be unit-testable independent of widgets |
| 3 | No direct database/secure-storage access from the presentation layer | All persistence is mediated by `core/storage` services via providers |
| 4 | No hardcoded colors or strings | Breaks theming/dark-mode and future localization (§9) |
| 5 | No duplicate services | One source of truth per cross-cutting concern (§19) |
| 6 | No duplicate repositories | One repository per feature (§5, §19) |
| 7 | No introducing new state management solutions | Riverpod is the only sanctioned mechanism — no `provider` package, Bloc, GetX, MobX, or ad-hoc `setState`-as-architecture |
| 8 | No modifications to unrelated modules in the same PR | Prevents review noise and merge conflicts (§15, §17) |
| 9 | All new features must follow the existing architecture | No "just this once" shortcuts — consistency compounds, exceptions compound faster |

---

## 23. Mandatory Feature Development Workflow

Every new feature or feature change moves through these stages, in order. Skipping a stage (e.g. writing UI before the domain contract exists) is itself a violation of this document.

```
Feature Request
      │
      ▼
Domain Layer        — define/extend entities, the <Feature>Repository contract, and usecases
      │
      ▼
Data Layer          — implement the datasource and <Feature>RepositoryImpl against that contract
      │
      ▼
Provider Layer       — wire datasource → repository → notifier/view-state in presentation/providers
      │
      ▼
UI Layer              — build pages/widgets that watch providers; no logic lives here
      │
      ▼
Testing                — unit tests for usecases/notifiers/mappers; widget tests for pages
      │
      ▼
Code Review            — checklist in §13 applied in full
      │
      ▼
Merge
```

Stage exit criteria:

1. **Domain Layer** — the repository interface and any usecases compile with no data/UI dependencies; entities have no JSON annotations.
2. **Data Layer** — `<Feature>RepositoryImpl` fully implements the interface; all failure paths throw `AppException`; `build_runner` has been run and generated files are included.
3. **Provider Layer** — providers expose only the abstract repository type to `presentation`; no widget imports a `RepositoryImpl` class.
4. **UI Layer** — pages/widgets contain no business logic, no direct network/storage access, and use `AppColors`/`AppTypography`/`AppLoader`/`AppErrorView` rather than ad hoc styling or error UI.
5. **Testing** — usecases and notifiers have unit tests covering the success path and at least one `Failure` path.
6. **Code Review** — every item in §13 is checked.
7. **Merge** — squashed or rebased into `main` per §14, with generated files committed alongside source.

---

## 24. Enforcement

This document is enforced the same way for human and AI-generated contributions: through code review against §13 and the forbidden-practices list in §22. Any change to the architecture described here (new top-level folder, new state-management library, new networking client, etc.) requires updating this document **in the same PR** that introduces the change — the document and the codebase must never drift apart.
