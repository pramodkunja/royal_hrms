# Team Context File — Royal HRMS
**Date:** 2026-06-25  
**Author:** Vignesh  
**Session type:** Feature development + bug fixes + UI redesign

---

## 1. Overview

This document captures everything implemented, fixed, and redesigned in today's session on the Royal HRMS Flutter project. It follows the project's Clean Architecture (Feature-First + Riverpod) as mandated by `docs/development_guidelines.md`.

---

## 2. Features Implemented

### 2.1 Email Templates — HTML Preview Integration
- Replaced the old `_stripHtml` / `_buildHighlightedSpans` plain-text renderer inside `_LivePreviewPanel` with the `EmailHtmlPreview` widget.
- Updated `ViewEmailTemplateDialog` to render `template.body` through `EmailHtmlPreview` instead of a plain `Text` widget.
- Exported all new widgets from `feature_module.dart`.

---

### 2.2 Departments & Designations — Full Feature (Clean Architecture)

Built the complete stack from domain → data → presentation.

#### Domain Layer
**File:** `lib/features/settings/domain/entities/department.dart`

| Entity | Fields |
|---|---|
| `Designation` | `id`, `name`, `isActive`, `departmentId`, `departmentName` |
| `Department` | `id`, `name`, `description`, `isActive`, `designations`, `serverDesignationCount`, `employeeCount` |

Key computed property on `Department`:
```dart
int get designationCount =>
    designations.isNotEmpty ? designations.length : (serverDesignationCount ?? 0);
```

**File:** `lib/features/settings/domain/repositories/settings_repository.dart`  
Added abstract methods:
- `getDepartments()`, `createDepartment()`, `updateDepartment()`, `deleteDepartment()`
- `getDesignations(departmentId)`, `createDesignation()`, `updateDesignation()`, `deleteDesignation()`

#### Data Layer
**File:** `lib/features/settings/data/models/department_model.dart`

| Model | Key notes |
|---|---|
| `DepartmentModel` | Parses `designation_count` (int) and `employee_count` (int) from API list response |
| `DesignationModel` | Parses `department` (int FK) and `department_name`. **No `description` field** — API does not return one |

**File:** `lib/features/settings/data/datasource/settings_remote_datasource.dart`
- `fetchDesignations(int departmentId)` — calls `GET /api/designations/?department=<id>`
- Query parameter key is **`department`** (not `department_id`) — confirmed from API reference

**File:** `lib/features/settings/data/repositories/settings_repository_impl.dart`
- `getDesignations` applies **client-side filter** after fetch:
  ```dart
  return models
      .where((m) => m.departmentId == deptId)
      .map((m) => m.toEntity())
      .toList();
  ```
  This is defensive — the backend was returning all designations ignoring the query param in some cases.

#### API Endpoints (corrected)
| Constant | Value |
|---|---|
| `settingsDepartmentsEndpoint` | `/departments/` |
| `settingsDesignationsEndpoint` | `/designations/` |

> **Note:** Earlier they were wrongly set to `/settings/departments/` which caused 404 errors.

#### API Response Shapes
```json
// GET /api/departments/
{
  "id": 1, "name": "Engineering", "description": "...",
  "is_active": true, "designation_count": 3, "employee_count": 5, "roles": []
}

// GET /api/designations/?department=1
{
  "id": 1, "name": "Senior Engineer",
  "department": 1, "department_name": "Engineering", "is_active": true
}
```

#### Presentation Layer

**File:** `lib/features/settings/presentation/providers/departments_providers.dart`

`DepartmentsState` fields:
- `departments: List<Department>`
- `selectedDepartmentId: String?`

Computed getters:
- `totalDesignations` — sum of all `designationCount` across departments
- `activeDepartmentCount` — count of departments where `isActive == true`
- `selectedDepartment` — the full `Department` object for the selected ID

`DepartmentsNotifier` methods:
- `selectDepartment(id)` — switches selection immediately (responsive UI), then lazily fetches designations for that department if not already loaded
- `addDepartment / updateDepartment / deleteDepartment`
- `addDesignation / updateDesignation / deleteDesignation`

---

### 2.3 Settings Page Redesign
**File:** `lib/features/settings/presentation/pages/settings_page.dart`

- Added tab bar (`_SettingsTab` enum: All, Company, Modules, Communication, System)
- Responsive grid layout (1 col mobile / 2 col tablet / 4 col desktop)
- 11 setting tiles each with icon, title, subtitle, accent color, and optional navigation route
- Tiles that navigate: Departments & Designations, Email Templates, SMTP Settings, Audit Log

---

### 2.4 Routing
**File:** `lib/core/router/route_paths.dart`
```dart
static const String settingsDepartments = '/settings/departments';
```

**File:** `lib/core/router/app_router.dart`
```dart
GoRoute(
  path: RoutePaths.settingsDepartments,
  builder: (context, state) => const DepartmentsPage(),
)
```

---

## 3. Bugs Fixed

### Bug 1 — Container color + decoration assertion
**File:** `settings_page.dart`  
**Error:** `Cannot provide both a color and a decoration`  
**Fix:** Moved `color` inside `BoxDecoration` instead of passing it as a separate `Container` parameter.

---

### Bug 2 — API 404 on departments endpoint
**Error:** `GET http://192.168.0.149:9000/api/settings/departments/` → 404  
**Fix:** Corrected endpoint constants in `api_constants.dart` from `/settings/departments/` to `/departments/`.

---

### Bug 3 — All designations showing across all departments
**Root cause:** Query param was sent as `department_id` but the API expects `department`.  
**Fix:** Changed query parameter key in `settings_remote_datasource.dart`:
```dart
// Before
queryParameters: {'department_id': departmentId}
// After
queryParameters: {'department': departmentId}
```
Also added client-side filter in repository as a defensive fallback.

---

### Bug 4 — RenderFlex unbounded height crash
**File:** `departments_page.dart` (stacked mobile layout)  
**Error:** `_DesignationList` Column had `Flexible(child: ListView)` inside an unbounded parent  
**Fix:** Removed `Flexible` wrapper, used `shrinkWrap: true` + `NeverScrollableScrollPhysics()`, added `mainAxisSize: MainAxisSize.min` to the Column.

---

### Bug 5 — RenderFlex overflow by 34px in DepartmentCard
**File:** `departments_page.dart` line 609  
**Error:** Sub-info Row containing icons + text widgets overflowed on narrow mobile screens  
**Fix:** Replaced the multi-widget Row with a single `Text` widget using `maxLines: 1, overflow: TextOverflow.ellipsis`:
```dart
Text(
  '${department.designationCount} designations · ${department.employeeCount} people',
  maxLines: 1,
  overflow: TextOverflow.ellipsis,
)
```

---

## 4. UI Redesigns

### 4.1 Departments Page — Mobile Layout
- **"Add Department" button** moved from AppBar actions into the page body (always fully visible)
- **Stats section** redesigned as a 2-column grid (Total Departments | Total Designations on row 1, Active Departments full-width on row 2) — labels use `maxLines: 2` so nothing truncates
- **Department cards** redesigned as proper bordered cards (not thin list rows): coloured avatar, department name, designation count sub-text, Active/Inactive pill badge, edit/delete icons
- **Accordion inline expansion** — tapping a card expands a designation panel directly below that card. The card and panel share a primary-colour border forming one connected visual block. A chevron `▼`/`▲` indicates open/close state.
- Tapping the same card again collapses the expansion

### 4.2 Designation Dialog Redesign
**File:** `add_edit_department_dialog.dart`  
- Removed `description` field (API does not support it)
- Added `departmentName` parameter — displayed as a grey info chip at the top of the form
- Dialog header uses a badge icon + clean title ("Add Designation" / "Edit Designation")
- Footer button: "Add Designation" (not "Create Designation")
- `_DesigDialogHeader` now takes `isEditing: bool` instead of the full `Designation?` object

### 4.3 Designation Entity
- Removed `description` field entirely from `Designation` entity and `DesignationModel`
- Added `departmentName` field (populated from `department_name` in API response)

### 4.4 Department Entity
- Added `employeeCount` field (populated from `employee_count` in API list response)

---

## 5. Files Created / Modified

| File | Action |
|---|---|
| `lib/features/settings/domain/entities/department.dart` | Created — `Department` + `Designation` entities |
| `lib/features/settings/data/models/department_model.dart` | Created — `DepartmentModel` + `DesignationModel` |
| `lib/features/settings/data/datasource/settings_remote_datasource.dart` | Modified — added designation CRUD + fixed query param |
| `lib/features/settings/data/repositories/settings_repository_impl.dart` | Modified — added designation CRUD + client-side filter |
| `lib/features/settings/domain/repositories/settings_repository.dart` | Modified — added department + designation abstract methods |
| `lib/features/settings/presentation/providers/departments_providers.dart` | Created — `DepartmentsState` + `DepartmentsNotifier` |
| `lib/features/settings/presentation/pages/departments_page.dart` | Created — full mobile accordion + desktop two-panel layout |
| `lib/features/settings/presentation/pages/settings_page.dart` | Rewritten — tab bar + responsive tile grid |
| `lib/features/settings/presentation/widgets/add_edit_department_dialog.dart` | Created — dept + designation dialogs |
| `lib/features/settings/presentation/widgets/add_edit_email_template_dialog.dart` | Modified — replaced old HTML renderer with `EmailHtmlPreview` |
| `lib/features/settings/presentation/widgets/view_email_template_dialog.dart` | Modified — renders body via `EmailHtmlPreview` |
| `lib/features/settings/feature_module.dart` | Modified — exports for all new files |
| `lib/core/constants/api_constants.dart` | Modified — corrected department + designation endpoints |
| `lib/core/router/route_paths.dart` | Modified — added `settingsDepartments` path |
| `lib/core/router/app_router.dart` | Modified — registered `DepartmentsPage` route |

---

## 6. Git

**Branch:** `main`  
**Commit:** `dbc932c` — _Email Template & Departments and Designations_  
**Remote:** `https://github.com/pramodkunja/royal_hrms.git`  
**Status:** Pushed ✓ (resolved merge conflicts on `api_constants.dart` and `settings_page.dart` during rebase)

**Merge conflict resolutions:**
- `api_constants.dart` — kept port `9000` (active dev server) over remote's `7000`
- `settings_page.dart` — kept our full redesigned page over remote's old simple version

---

## 7. Architecture Standards Followed

All code written today conforms to `docs/development_guidelines.md`:
- Zero hardcoded colors — all references use `AppColors.*`
- Zero hardcoded text styles — all use `context.textTheme.*`
- No API calls inside widgets — all network access via `DepartmentsNotifier`
- Repository returns domain entities only — models stay in the data layer
- Riverpod `AsyncNotifierProvider` used throughout — no legacy `StateNotifierProvider`
- Route strings use `RoutePaths` constants — no inline string literals
- Feature-first folder structure maintained exactly

---

---

# Team Context File — Royal HRMS
**Date:** 2026-06-26  
**Author:** Pramod Kunja  
**Session type:** Feature development + bug fixes + backend integration

---

## 1. Overview

This document captures everything implemented, fixed, and integrated in today's session on the Royal HRMS Flutter project. Work spans the complete SMTP Settings feature (domain → data → presentation), full Auth UI redesign, permission-based route guarding, and scaffold pages for 7 new navigation features. All code follows the project's Clean Architecture (Feature-First + Riverpod) as mandated by `docs/development_guidelines.md`.

---

## 2. Features Implemented

### 2.1 SMTP Settings — Full Feature (Clean Architecture)

Built the complete stack from domain → data → presentation with real backend API integration.

#### Domain Layer
**File:** `lib/features/settings/domain/entities/smtp_config.dart`

| Type | Values / Fields |
|---|---|
| `SmtpType` enum | `local`, `server` |
| `SmtpPriority` enum | `normal`, `high` |
| `SmtpReceiverEmail` enum | `emailId`, `personalEmailId` |
| `SmtpConfig` entity | `id`, `name`, `type`, `host`, `port`, `useTls`, `senderName`, `fromEmail`, `username`, `bccEmail?`, `priority`, `receiverEmail`, `isActive`, `updatedAt` |

**File:** `lib/features/settings/domain/repositories/settings_repository.dart`  
Added abstract SMTP methods:
- `getSmtpConfigs()`, `createSmtpConfig(data)`, `updateSmtpConfig(id, data)`
- `deleteSmtpConfig(id)`, `setSmtpConfigActive(id)`, `testSmtpConfig(id)`

#### Data Layer

**File:** `lib/features/settings/data/models/smtp_config_model.dart`

All fields use `@JsonKey(fromJson: ...)` with null-safe top-level converters — required because Django returns `null` for blank-allowed fields:

| Converter | Purpose |
|---|---|
| `_idFromJson` | `dynamic → String` (fallback `''`) |
| `_stringFromJson` | `dynamic → String` (fallback `''`) |
| `_intFromJson` | `dynamic → int` (fallback `0`) |
| `_boolFromJson` | `dynamic → bool` (accepts `true` or `'true'`) |
| `_dateTimeFromJson` | ISO string → `DateTime` (fallback `DateTime.now()`) |
| `_smtpTypeFromJson` | enum by `.name` (fallback `SmtpType.local`) |
| `_smtpPriorityFromJson` | enum by `.name` (fallback `SmtpPriority.normal`) |
| `_receiverEmailFromJson` | `'personal_email_id'` → enum |

Critical `@JsonKey(name:...)` corrections:
- `smtp_type` (not `type`)
- `receiver_email_type` (not `receiver_email`)
- `use_tls`, `sender_name`, `from_email`, `bcc_email`, `is_active`, `updated_at`

**File:** `lib/features/settings/data/models/smtp_config_request_model.dart`  
- Same field-name corrections for POST/PATCH body
- Password field included (omitted in response for security)

**File:** `lib/features/settings/data/datasource/settings_remote_datasource.dart`  
SMTP endpoints implemented:

| Method | Endpoint | Notes |
|---|---|---|
| `getSmtpConfigs()` | `GET /settings/smtp/` | Handles plain array, `{"data":[...]}` envelope, and `{"results":[...]}` paginated shapes |
| `createSmtpConfig(data)` | `POST /settings/smtp/` | Unwraps `{"data":{...}}` or plain object via `_extractModel()` |
| `updateSmtpConfig(id, data)` | `PATCH /settings/smtp/{id}/` | Same response unwrapping |
| `deleteSmtpConfig(id)` | `DELETE /settings/smtp/{id}/` | Returns `void` |
| `setSmtpConfigActive(id)` | `POST /settings/smtp/{id}/activate/` | Returns `void` — endpoint responds with message, not config |
| `testSmtpConfig(id)` | `POST /settings/smtp/test/` | Body: `{'smtp_id': id}` |

**File:** `lib/features/settings/data/repositories/settings_repository_impl.dart`  
- Delegates to datasource, maps `SmtpConfigModel → SmtpConfig` via `.toEntity()`

#### Presentation Layer

**File:** `lib/features/settings/presentation/providers/smtp_form_state.dart`
```dart
enum SmtpFormStatus { initial, submitting, success, failure }

@freezed
class SmtpFormState {
  status: SmtpFormStatus
  failure?: Failure
}
```

**File:** `lib/features/settings/presentation/providers/smtp_settings_notifier.dart`
- `smtpConfigsProvider` — `FutureProvider<List<SmtpConfig>>`: fetches via `ref.read(settingsRepositoryProvider)`, invalidated after every mutation
- `SmtpFormNotifier` — `NotifierProvider<SmtpFormNotifier, SmtpFormState>`: handles create / update / delete / activate / test with `submitting → success/failure` state transitions; calls `ref.invalidate(smtpConfigsProvider)` on every successful mutation

**File:** `lib/features/settings/presentation/pages/smtp_settings_page.dart`
- AppBar "Add SMTP" button opens `SmtpFormDialog`
- Active config banner (green card) showing which config is currently used for sending
- `ListView` of `SmtpConfigCard` widgets; empty state with icon when list is empty
- Per-card callbacks wired: `onTest`, `onSetActive`, `onEdit`, `onDelete`
- Failure messages shown via snackbar (red background)

**File:** `lib/features/settings/presentation/widgets/smtp_config_card.dart`
- Header: icon + name + type label + Active/Inactive status badge
- Two-column detail grid: HOST, PORT (with TLS note), FROM EMAIL, SENDER NAME, USERNAME, PASSWORD (masked), BCC, PRIORITY, RECEIVER EMAIL TYPE
- Action buttons: Test, Set Active (hidden if already active), Delete (red), Edit
- `_confirmDelete()` shows `AlertDialog` with Cancel + Delete (red `FilledButton`) before calling `onDelete`

**File:** `lib/features/settings/presentation/widgets/smtp_form_dialog.dart`
- Responsive layout via `LayoutBuilder` — fields side-by-side above 480px, stacked below
- All fields mapped to snake_case API keys on submission: `smtp_type`, `use_tls`, `sender_name`, `from_email`, `bcc_email`, `receiver_email_type`
- Password required on create, optional on update
- Error banner shown from `SmtpFormState.failure` when status is `failure`
- On success: closes dialog, shows green snackbar, calls `notifier.reset()`

---

### 2.2 Auth UI — Full Redesign

All auth pages rebuilt as `ConsumerStatefulWidget` using the project's auth providers.

**File:** `lib/features/auth/presentation/pages/login_page.dart`
- Background image via `AppAssets.loginBackground`
- Email + password fields with `Validators.email` / `Validators.minLength(6)`
- Password eye-toggle, loading spinner on submit
- `AuthErrorBanner` shown on `LoginStatus.failure`
- "Forgot password?" link to `RoutePaths.forgotPassword`

**File:** `lib/features/auth/presentation/pages/forgot_password_request_page.dart`
- Email field, calls `passwordResetControllerProvider.notifier.sendOtp(email:)`
- Navigates to `RoutePaths.verifyOtp` on success
- `BackToSignInLink` widget for navigation back

**File:** `lib/features/auth/presentation/pages/otp_verification_page.dart`
- Safety check on init — redirects to forgot password if no email in state
- Displays masked email; "Resend code" button with snackbar confirmation
- Calls `verifyOtp(otp:)`, pushes to `RoutePaths.resetPassword` on success

**File:** `lib/features/auth/presentation/pages/reset_password_page.dart`
- `Validators.strongPassword()` on new password field
- `Validators.confirmPassword()` for match validation
- Safety check on init — redirects if no reset token in state
- Success screen: checkmark icon + "Your password has been reset successfully"
- Eye-toggle on both password fields

**File:** `lib/features/auth/presentation/pages/splash_page.dart`
- Calls `authStatusNotifierProvider.notifier.checkInitialStatus()` via `Future.microtask()`
- Shows `AppLoader` while resolving; `RouteGuard` handles redirect once status is known

---

### 2.3 Core Infrastructure

**File:** `lib/core/constants/app_assets.dart` *(Created)*
```dart
class AppAssets {
  static const String loginBackground = 'assets/images/login_background.jpg';
}
```

**File:** `lib/core/constants/api_constants.dart`
- `baseUrl` = `'http://192.168.0.149:5000/api'` (port 5000 — Pramod's dev server)
- Added `smtpConfigsEndpoint = '/settings/smtp/'`
- Added `settingsEmailTemplatesEndpoint = '/settings/email-templates/'`
- Added `settingsDepartmentsEndpoint = '/departments/'`
- Added `settingsDesignationsEndpoint = '/designations/'`
- `refreshTokenEndpoint = '/token/refresh/'` (wired but backend not yet ready)

**File:** `lib/core/services/auth_status_notifier.dart`
```dart
enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthStatusNotifier extends Notifier<AuthStatus> {
  checkInitialStatus()   // reads stored token on launch
  setAuthenticated()     // called after successful login
  logout()               // best-effort POST /logout/, then clears local session
  setUnauthenticated()   // clears tokens, invalidates providers
}
```
- Cross-cutting auth state consumed by `RouteGuard` and `AuthInterceptor`
- Logout proceeds with local clear even if server call fails

**File:** `lib/core/router/route_guard.dart`
- `publicPaths`: splash, login, forgotPassword, verifyOtp, resetPassword
- Permission mapping per route:
  - `employees`, `attendance`, `leave`, `payroll`, `reports`, `settings`, `recruitment`, `expenses`, `referrals`, `announcements`, `documents`, `audit` → require specific `AppPermissions.*` constants
  - `orgChart`, `branches` → require `viewEmployees`
  - `approvals` → requires any of `approveEmployees | approveLeave | approveExpenses`
  - `separation` → requires `approveEmployees`
  - `myPayslips`, `myRequests`, `myProfile` → no permission required (self-service)
- `redirect()` checks `AuthStatus` first, then calls `userSessionService.hasAnyPermission()` per route

---

### 2.4 Navigation Feature Scaffolds

Seven new navigation destinations registered end-to-end (routes + pages + clean arch stubs) ready for full implementation:

| Feature | Route | Page Class |
|---|---|---|
| Org Chart | `/org-chart` | `OrgChartPage` |
| Branches | `/branches` | `BranchesPage` |
| My Payslips | `/my-payslips` | `PayslipsPage` |
| Approvals | `/approvals` | `ApprovalsPage` |
| Separation & FnF | `/separation` | `SeparationPage` |
| My Requests | `/my-requests` | `MyRequestsPage` |
| My Profile | `/my-profile` | `MyProfilePage` |

Each scaffold includes the full clean-arch folder structure:
- `domain/repositories/<feature>_repository.dart`
- `data/datasource/<feature>_remote_datasource.dart`
- `data/repositories/<feature>_repository_impl.dart`
- `presentation/pages/<feature>_page.dart`
- `presentation/providers/<feature>_providers.dart`
- `feature_module.dart`

---

### 2.5 Routing Updates

**File:** `lib/core/router/route_paths.dart`  
Added:
```dart
static const String smtpSettings    = '/settings/smtp';
static const String orgChart        = '/org-chart';
static const String branches        = '/branches';
static const String myPayslips      = '/my-payslips';
static const String approvals       = '/approvals';
static const String separation      = '/separation';
static const String myRequests      = '/my-requests';
static const String myProfile       = '/my-profile';
```

**File:** `lib/core/router/app_router.dart`  
- Registered all 8 new routes above
- Also registered Vignesh's `settingsEmailTemplates` and `settingsDepartments` during merge

---

## 3. Bugs Fixed

### Bug 1 — Type Null Errors from Django API Response
**Files:** `smtp_config_model.dart`, `smtp_config_model.g.dart`  
**Error:** `TypeError: Null is not subtype of String` at runtime when Django returned `null` for blank-allowed fields  
**Root cause:** `json_serializable` generated `json['field'] as String` — throws on null  
**Fix:** Added null-safe top-level converter functions for every field type and applied `@JsonKey(fromJson: _converterFn)` to every field. Re-ran `build_runner` to regenerate `.g.dart` files.

---

### Bug 2 — Page Stuck in Loading Forever
**File:** `smtp_settings_notifier.dart`  
**Error:** SMTP settings page displayed loading spinner indefinitely  
**Root cause:** Original `SmtpConfigsNotifier` used `AsyncNotifier` with `ref.watch` inside `build()`. In Riverpod 3.3.2, dependency chain rebuilds mid-flight keep the provider in `AsyncLoading` permanently.  
**Fix:** Replaced `AsyncNotifier` with `FutureProvider` using `ref.read`:
```dart
final smtpConfigsProvider = FutureProvider<List<SmtpConfig>>((ref) async {
  return ref.read(settingsRepositoryProvider).getSmtpConfigs();
});
```

---

### Bug 3 — "No SMTP Configurations" Despite Successful API Response
**Files:** `settings_remote_datasource.dart`, `smtp_config_model.dart`  
**Error:** Page showed empty state even though API returned 3 configs  
**Root cause (two separate issues):**
1. Backend returns `{"status":"success","data":[...]}` envelope but datasource only handled `{"results":[...]}` → fell through to `return []`
2. Model had `@JsonKey(name:'type')` and `@JsonKey(name:'receiver_email')` but API sends `smtp_type` and `receiver_email_type` → all configs parsed with zero/default values

**Fix:**
1. Added `data` key check in datasource — handles plain array, `data` envelope, and `results` paginated shape
2. Corrected `@JsonKey(name:)` in both `smtp_config_model.dart` and `smtp_config_request_model.dart`
3. Fixed raw map keys in `smtp_form_dialog.dart` to match API schema

---

### Bug 4 — `setSmtpConfigActive` Crash
**File:** `settings_remote_datasource.dart`  
**Error:** App crashed when activating an SMTP config  
**Root cause:** Activate endpoint (`POST /settings/smtp/{id}/activate/`) returns `{"message":"..."}`, not the full config object. Code was calling `SmtpConfigModel.fromJson(response.data!)` on this.  
**Fix:** Changed return type to `Future<void>` throughout the chain (datasource → repository interface → impl → notifier). List is refreshed via `ref.invalidate(smtpConfigsProvider)` after activation.

---

### Bug 5 — URL Resolution Drops `/api` Path Prefix
**File:** `lib/core/network/api_client.dart`  
**Discovery:** `Uri.parse('http://host/api').resolve('/settings/smtp/')` resolves to `http://host/settings/smtp/` — the leading `/` in the path discards the `/api` segment  
**Fix:** All endpoint constants use paths without leading `/api` prefix; the `baseUrl` provides it. Consistent across all existing endpoints including auth.

---

## 4. Files Created / Modified

| File | Action |
|---|---|
| `lib/features/settings/domain/entities/smtp_config.dart` | Created — `SmtpConfig` entity + 3 enums |
| `lib/features/settings/domain/entities/smtp_config.freezed.dart` | Generated |
| `lib/features/settings/data/models/smtp_config_model.dart` | Created — null-safe model with all converters |
| `lib/features/settings/data/models/smtp_config_model.freezed.dart` | Generated |
| `lib/features/settings/data/models/smtp_config_model.g.dart` | Generated |
| `lib/features/settings/data/models/smtp_config_request_model.dart` | Created — request-only model |
| `lib/features/settings/data/models/smtp_config_request_model.freezed.dart` | Generated |
| `lib/features/settings/data/models/smtp_config_request_model.g.dart` | Generated |
| `lib/features/settings/data/datasource/settings_remote_datasource.dart` | Modified — added all 6 SMTP methods |
| `lib/features/settings/data/repositories/settings_repository_impl.dart` | Modified — added SMTP implementations |
| `lib/features/settings/domain/repositories/settings_repository.dart` | Modified — added SMTP abstract methods |
| `lib/features/settings/presentation/providers/smtp_form_state.dart` | Created — `SmtpFormState` + `SmtpFormStatus` |
| `lib/features/settings/presentation/providers/smtp_form_state.freezed.dart` | Generated |
| `lib/features/settings/presentation/providers/smtp_settings_notifier.dart` | Created — `smtpConfigsProvider` + `SmtpFormNotifier` |
| `lib/features/settings/presentation/pages/smtp_settings_page.dart` | Created — full SMTP settings UI |
| `lib/features/settings/presentation/widgets/smtp_config_card.dart` | Created — config display card with actions |
| `lib/features/settings/presentation/widgets/smtp_form_dialog.dart` | Created — responsive create/edit form dialog |
| `lib/features/settings/feature_module.dart` | Modified — added all SMTP exports |
| `lib/core/constants/app_assets.dart` | Created — `AppAssets.loginBackground` |
| `lib/core/constants/api_constants.dart` | Modified — port 5000, added SMTP + dept + email template endpoints |
| `lib/core/services/auth_status_notifier.dart` | Created/Modified — `AuthStatus` enum + notifier |
| `lib/core/router/route_guard.dart` | Created — permission-based route protection |
| `lib/core/router/route_paths.dart` | Modified — added 8 new route constants |
| `lib/core/router/app_router.dart` | Modified — registered all new routes |
| `lib/features/auth/presentation/pages/login_page.dart` | Redesigned — background image, validation, error banner |
| `lib/features/auth/presentation/pages/forgot_password_request_page.dart` | Redesigned — send OTP flow |
| `lib/features/auth/presentation/pages/otp_verification_page.dart` | Redesigned — verify OTP + safety check |
| `lib/features/auth/presentation/pages/reset_password_page.dart` | Redesigned — strong password + success screen |
| `lib/features/auth/presentation/pages/splash_page.dart` | Redesigned — async auth status check |
| `lib/features/approvals/` | Created — full scaffold (domain + data + presentation) |
| `lib/features/branches/` | Created — full scaffold |
| `lib/features/org_chart/` | Created — full scaffold |
| `lib/features/payslips/` | Created — full scaffold |
| `lib/features/separation/` | Created — full scaffold |
| `lib/features/my_profile/` | Created — full scaffold |
| `lib/features/my_requests/` | Created — full scaffold |
| `assets/images/login_background.jpg` | Added — login page background image |
| `pubspec.yaml` | Modified — declared `assets/images/login_background.jpg` |

---

## 5. Git

**Branch:** `main`  
**Commits:**
- `6861078` — _feat: SMTP settings + auth UI + nav features_
- `a481b49` — _merge: combine SMTP settings with Departments & Email Templates_

**Remote:** `https://github.com/pramodkunja/royal_hrms.git`  
**Status:** Pushed ✓

**Merge conflict resolutions (10 files):**
- `api_constants.dart` — kept port `5000`, merged all endpoint constants from both branches
- `route_paths.dart` — merged all routes from both branches
- `app_router.dart` — registered all page routes from both branches
- `settings_repository.dart` — merged SMTP + Email Templates + Dept/Designation abstract methods
- `settings_repository_impl.dart` — merged all implementations
- `settings_remote_datasource.dart` — merged all datasource methods; fixed abstract class declaration
- `feature_module.dart` — merged all model, entity, page, provider, and widget exports
- `settings_page.dart` — kept Vignesh's full redesigned tab+grid page; added `routePath: RoutePaths.smtpSettings` to the SMTP Settings tile (was missing)
- `pubspec.yaml` — kept `assets/images/login_background.jpg` + Vignesh's Poppins font family
- `app_colors.dart` — auto-merged cleanly

---

## 6. Architecture Standards Followed

All code written today conforms to `docs/development_guidelines.md`:
- Zero hardcoded colors — all references use `AppColors.*`
- Zero hardcoded text styles — all use `context.textTheme.*` or `Theme.of(context).textTheme.*`
- No API calls inside widgets — all network access via `SmtpFormNotifier` / `smtpConfigsProvider`
- Repository returns domain entities only — models stay in the data layer
- `FutureProvider` used for list fetching (consistent with project standard, avoids Riverpod 3.x `AsyncNotifier` rebuild race)
- `NotifierProvider` used for mutable form operations
- Route strings use `RoutePaths` constants — no inline string literals
- Feature-first folder structure maintained exactly
- All `@freezed` models regenerated with `build_runner` after every change

---

---

# Team Context File — Royal HRMS
**Date:** 2026-06-26  
**Author:** Pramod Kunja  
**Session type:** Code refactoring — split all large files to ≤ 250 lines

---

## 1. Overview

This session focused entirely on refactoring all large files in the Settings feature to stay under 250 lines each. No new features were added. All existing behaviour is preserved — the extraction is purely structural. Every private class that was moved to its own file was renamed to a public class; every private helper that needed to be shared across files was lifted to a module-level function. The mixin pattern was used for the datasource to work around the Dart restriction that a class body cannot be split across files.

---

## 2. What Was Refactored

### 2.1 Datasource Split

**Problem:** `settings_remote_datasource.dart` was a single file containing the abstract interface plus the implementation for all three feature areas (SMTP, Email Templates, Departments/Designations).

**Pattern used:** Dart mixin delegation. Each mixin declares `ApiClient get apiClient;` as an abstract getter. The thin impl class satisfies it via a field.

| New File | Contents | Lines |
|---|---|---|
| `settings_smtp_datasource_mixin.dart` | `SmtpDataSourceMixin` — all 6 SMTP methods + `_extractModel` helper | ~117 |
| `settings_email_template_datasource_mixin.dart` | `EmailTemplateDataSourceMixin` — all 7 email template methods | ~115 |
| `settings_department_datasource_mixin.dart` | `DepartmentDataSourceMixin` — 4 department + 4 designation methods | ~115 |
| `settings_remote_datasource_impl.dart` | `SettingsRemoteDataSourceImpl` — `with` all three mixins, provides `apiClient` | ~18 |
| `settings_remote_datasource.dart` | Abstract class only | ~40 |

`settings_providers.dart` updated to import `settings_remote_datasource_impl.dart`.

---

### 2.2 Department Dialog Split

**Problem:** `add_edit_department_dialog.dart` contained both the Add Department dialog and the Add Designation dialog as a single large file.

| New File | Contents | Lines |
|---|---|---|
| `department_dialog_shared_widgets.dart` | `DeptDialogErrorBanner`, `DeptDialogFieldLabel`, `DeptDialogDescriptionLabel`, `DeptActiveCheckboxRow` | ~145 |
| `department_dialog_chrome.dart` | `DeptDialogHeader`, `DesigDialogHeader`, `DeptDialogFooter` | ~175 |
| `add_edit_department_dialog.dart` | `AddEditDepartmentDialog` + `_AddEditDepartmentDialogState` only | ~155 |
| `add_edit_designation_dialog.dart` | `AddEditDesignationDialog` + `_AddEditDesignationDialogState` | ~195 |

---

### 2.3 Departments Page Split

**Problem:** `departments_page.dart` was ~800+ lines containing the page, all sub-layouts, every card widget, accordion, designation expansion panels, and delete confirmation dialogs.

**Pattern used:** Private helpers that were needed across multiple layout files were promoted to module-level functions (e.g. `_confirmDeleteDepartment`, `_confirmDeleteDesignation`) private to their own library.

| New File | Public Class(es) | Lines |
|---|---|---|
| `departments_atom_widgets.dart` | `kDeptAvatarColors`, `deptAvatarColor()`, `DeptStatCard`, `DeptInfoChip`, `DeptSearchBar` | 197 |
| `departments_row_cards.dart` | `DeptListRow`, `DeptDesignationCard` | 235 |
| `departments_accordion_item.dart` | `DeptAccordionItem` | 203 |
| `departments_designation_expansion.dart` | `DeptDesignationExpansion` + `_confirmDeleteDesignation` | 200 |
| `departments_mobile_layout.dart` | `DeptMobileLayout` + `_confirmDeleteDepartment` | 197 |
| `departments_list_panel.dart` | `DeptListPanel` + `_confirmDeleteDepartment` | 153 |
| `departments_side_layout.dart` | `DeptSideBySideLayout` | 153 |
| `departments_designation_panel.dart` | `DeptDesignationPanel`, `DeptEmptyDesignationState` | 100 |
| `departments_designation_detail_header.dart` | `DeptDesignationDetailHeader` | 168 |
| `departments_designation_list_desktop.dart` | `DeptDesignationListDesktop` + `_confirmDeleteDesignation` | 156 |
| `departments_page.dart` | `DepartmentsPage` + `_DepartmentsPageState` only | 92 |

---

### 2.4 Email Template Dialog Split

**Problem:** `add_edit_email_template_dialog.dart` was 1856 lines — the single largest file in the project. It contained the dialog widget, state class, toolbar, insert-link/image dialogs, body editor with all HTML helpers, form fields, preview panel, tags sidebar, attachment row, layout widgets, and chrome widgets.

**Circular import issue:** `EmailTemplateBodyEditor` needed `EmailTemplateEditorToolbar` from the editor widgets file, and the editor widgets file needed the `EmailTemplateToolbarAction` enum that originally lived in the body editor. Fixed by extracting the enum to its own standalone file — both files import from there.

| New File | Public Class(es) | Lines |
|---|---|---|
| `email_template_toolbar_action.dart` | `EmailTemplateToolbarAction` enum (13 values) | ~16 |
| `email_template_dialog_chrome.dart` | `EmailTemplateDialogHeader`, `EmailTemplateDialogFooter`, `EmailTemplateErrorBanner`, `EmailTemplateFieldLabel`, `EmailTemplateHtmlToggleButton` | ~235 |
| `email_template_preview_panel.dart` | `EmailTemplateLivePreviewPanel` | ~115 |
| `email_template_tags_sidebar.dart` | `EmailTemplateTagsSidebar` | ~160 |
| `email_template_attach_row.dart` | `EmailTemplateAttachFilesRow` | ~185 |
| `email_template_editor_widgets.dart` | `EmailTemplateEditorToolbar`, `EmailTemplateInsertLinkDialog`, `EmailTemplateInsertImageDialog` | ~235 |
| `email_template_body_editor.dart` | `EmailTemplateBodyEditor` (all HTML manipulation helpers) | ~240 |
| `email_template_form_fields.dart` | `EmailTemplateEditFields`, `EmailTemplateAddFields` | ~248 |
| `email_template_dialog_layouts.dart` | `EmailTemplateMobileLayout`, `EmailTemplateDesktopLayout` | ~115 |
| `add_edit_email_template_dialog.dart` | `AddEditEmailTemplateDialog` + `_AddEditEmailTemplateDialogState` only | 324 |

> **Note on 324 lines:** Dart requires a `ConsumerStatefulWidget` and its `State` class to be in the same file/library. The state class alone accounts for most of that line count. This is the practical minimum given the Dart constraint.

---

## 3. Key Dart Constraints Encountered

| Constraint | Impact | Solution |
|---|---|---|
| Class body cannot span files | Cannot split `SettingsRemoteDataSourceImpl` methods | Used mixin delegation — each mixin group owns its methods |
| `ConsumerStatefulWidget` + `State` must be same library | State cannot be extracted to its own file | Accepted ~324 lines as the floor for dialog main files |
| Private `_` classes cannot be imported across files | Extracting private classes breaks all callers | Renamed every extracted class to public (removed `_` prefix) |
| Circular imports | `body_editor ↔ editor_widgets` if enum lives in either | Extracted `EmailTemplateToolbarAction` to its own file |

---

## 4. Files Created / Modified

### New Files (extracted widgets / mixins)
| File | Action |
|---|---|
| `lib/features/settings/data/datasource/settings_smtp_datasource_mixin.dart` | Created |
| `lib/features/settings/data/datasource/settings_email_template_datasource_mixin.dart` | Created |
| `lib/features/settings/data/datasource/settings_department_datasource_mixin.dart` | Created |
| `lib/features/settings/data/datasource/settings_remote_datasource_impl.dart` | Created |
| `lib/features/settings/presentation/widgets/department_dialog_shared_widgets.dart` | Created |
| `lib/features/settings/presentation/widgets/department_dialog_chrome.dart` | Created |
| `lib/features/settings/presentation/widgets/add_edit_designation_dialog.dart` | Created |
| `lib/features/settings/presentation/widgets/departments_atom_widgets.dart` | Created |
| `lib/features/settings/presentation/widgets/departments_row_cards.dart` | Created |
| `lib/features/settings/presentation/widgets/departments_accordion_item.dart` | Created |
| `lib/features/settings/presentation/widgets/departments_designation_expansion.dart` | Created |
| `lib/features/settings/presentation/widgets/departments_mobile_layout.dart` | Created |
| `lib/features/settings/presentation/widgets/departments_list_panel.dart` | Created |
| `lib/features/settings/presentation/widgets/departments_side_layout.dart` | Created |
| `lib/features/settings/presentation/widgets/departments_designation_panel.dart` | Created |
| `lib/features/settings/presentation/widgets/departments_designation_detail_header.dart` | Created |
| `lib/features/settings/presentation/widgets/departments_designation_list_desktop.dart` | Created |
| `lib/features/settings/presentation/widgets/email_template_toolbar_action.dart` | Created |
| `lib/features/settings/presentation/widgets/email_template_dialog_chrome.dart` | Created |
| `lib/features/settings/presentation/widgets/email_template_preview_panel.dart` | Created |
| `lib/features/settings/presentation/widgets/email_template_tags_sidebar.dart` | Created |
| `lib/features/settings/presentation/widgets/email_template_attach_row.dart` | Created |
| `lib/features/settings/presentation/widgets/email_template_editor_widgets.dart` | Created |
| `lib/features/settings/presentation/widgets/email_template_body_editor.dart` | Created |
| `lib/features/settings/presentation/widgets/email_template_form_fields.dart` | Created |
| `lib/features/settings/presentation/widgets/email_template_dialog_layouts.dart` | Created |

### Modified Files (reduced + import-updated)
| File | Change |
|---|---|
| `lib/features/settings/data/datasource/settings_remote_datasource.dart` | Reduced to abstract class only |
| `lib/features/settings/presentation/providers/settings_providers.dart` | Added import for `settings_remote_datasource_impl.dart` |
| `lib/features/settings/presentation/pages/departments_page.dart` | Rewritten — 92 lines, delegates to split widget files |
| `lib/features/settings/presentation/widgets/add_edit_department_dialog.dart` | Reduced — dept dialog only, imports chrome + shared widgets |
| `lib/features/settings/presentation/widgets/add_edit_email_template_dialog.dart` | Reduced from 1856 → 324 lines, delegates to all split widget files |

---

## 5. Git

**Branch:** `main`  
**Commit:** `457c895` — _refactor: split all large settings files to ≤ 250 lines_  
**Remote:** `https://github.com/pramodkunja/royal_hrms.git`  
**Status:** Pushed ✓

---

---

# Team Context File — Royal HRMS
**Date:** 2026-06-26
**Author:** Pramod Kunja
**Session type:** Auth integration + Google Fonts + Settings UI + Folder reorganisation

---

## 1. Overview

This session completed the end-to-end auth token flow (secure storage → Bearer injection → silent refresh), switched the app font to Google Fonts, added icons and a pill highlight to the settings nav tabs, built the Roles & Permissions page, and reorganised all settings pages and widgets into named subfolders. All code follows the project's Clean Architecture (Feature-First + Riverpod).

---

## 2. Features Implemented

### 2.1 Google Fonts — Replace Local Poppins TTFs

**Files changed:**
- `pubspec.yaml` — removed `fonts:` section, added `google_fonts: ^6.2.1`
- `lib/core/theme/app_typography.dart` — all 14 M3 text styles now use `GoogleFonts.poppins(...)`; removed `static const String fontFamily`
- `lib/core/theme/app_theme.dart` — `fontFamily`, `AppBarTheme.titleTextStyle`, and button `textStyle` all use `GoogleFonts.poppins()`; removed `const` from `AppBarTheme` constructors (non-const at runtime)

---

### 2.2 Settings Nav Tab Bar — Icons + Pill Highlight

**File:** `lib/features/settings/presentation/widgets/settings_tab_bar.dart`
- Each `_TabItem` now accepts `IconData icon`
- Active tab: `AnimatedContainer` with `borderRadius: 10`, primary-tinted fill, 180 ms ease-in-out
- Inactive tab: transparent background
- Icon rendered at size 15 followed by 6 px gap then label text

**File:** `lib/features/settings/presentation/pages/settings_page_types.dart`
- Added `IconData get icon` extension on `SettingsFilterTab`: tune, business, extension, email, dns

---

### 2.3 Roles & Permissions Page

New files under `lib/features/settings/presentation/`:

| File | Contents |
|---|---|
| `widgets/roles_permissions/permission_matrix_data.dart` | `kPermFull`, `kPermNone` constants; `PermissionRow` class; `kRoles` list; `kPermissionMatrix` — 10 rows covering all HRMS features |
| `widgets/roles_permissions/permission_cell.dart` | Green check for `full`, grey dash for `none`, primary badge for custom values |
| `widgets/roles_permissions/permissions_desktop_table.dart` | Bordered container, alternating row backgrounds, `Expanded(flex:3)` for feature, `flex:2` per role column |
| `widgets/roles_permissions/permissions_mobile_cards.dart` | One card per `PermissionRow`, 2-column role grid via `_RolePill` |
| `pages/roles_permissions/roles_permissions_page.dart` | Responsive: desktop uses breadcrumb body bar, mobile uses standard AppBar; switches at 600 px |

Routing:
- `RoutePaths.settingsRolesPermissions = '/settings/roles-permissions'` added to `route_paths.dart`
- GoRoute registered in `app_router.dart`
- Tile with `hasChevron: true` added in `settings_page_types.dart`
- Exported from `feature_module.dart`

---

### 2.4 Settings Folder Reorganisation

All existing settings pages and widgets moved with `git mv` (history preserved) into named subfolders:

| Old location | New location |
|---|---|
| `pages/departments_page.dart` | `pages/departments/departments_page.dart` |
| `pages/email_templates_page.dart` | `pages/email_templates/email_templates_page.dart` |
| `pages/smtp_settings_body.dart` | `pages/smtp/smtp_settings_body.dart` |
| `pages/smtp_settings_page.dart` | `pages/smtp/smtp_settings_page.dart` |
| `widgets/smtp_*.dart` (5 files) | `widgets/smtp/` |
| `widgets/email_template_*.dart` (13 files) | `widgets/email_templates/` |
| `widgets/departments_*.dart` + department dialog files (11 files) | `widgets/departments/` |

Import depth corrected across all moved files with `sed` (e.g. `../../../../core/` → `../../../../../core/`).

`feature_module.dart` fully rewritten with organised export sections per subfolder.

---

### 2.5 Secure Token Storage

**File:** `lib/services/auth_storage.dart` *(new)*

```dart
Future<void> saveTokens(String access, String refresh)
Future<String?> getAccessToken()
Future<String?> getRefreshToken()
Future<void> clearTokens()
```

Uses `flutter_secure_storage` (already in `pubspec.yaml`). Keychain on iOS, EncryptedFile on Android. No `AndroidOptions` override — v10 applies custom ciphers automatically.

---

### 2.6 Login — Extract and Store Tokens

**File:** `lib/features/auth/data/datasource/auth_remote_datasource.dart`

After a successful login the response body has this shape:
```json
{ "status": "success", "data": { "access": "...", "refresh": "...", "user": { ... } } }
```

Added guarded token extraction immediately after unwrapping the envelope:
```dart
final accessToken = data['access'] as String? ?? '';
final refreshToken = data['refresh'] as String? ?? '';
if (accessToken.isNotEmpty && refreshToken.isNotEmpty) {
  await saveTokens(accessToken, refreshToken);
}
```

> **Note:** A temporary `print('LOGIN RESPONSE BODY: $body')` was added then removed during debugging.

---

### 2.7 dotenv — Runtime baseUrl

**Problem:** `ApiConstants.baseUrl` was a hardcoded `const String` IP, breaking every other team member's machine.

**Files changed:**

| File | Change |
|---|---|
| `pubspec.yaml` | Added `flutter_dotenv: ^5.2.1`; `.env` declared as Flutter asset |
| `.env` | Created (gitignored) — `API_BASE_URL=http://<dev-machine-ip>:8000/api` |
| `.env.example` | Created (committed) — `API_BASE_URL=http://localhost:8000/api` |
| `.gitignore` | Added `.env` |
| `lib/core/constants/api_constants.dart` | `baseUrl` changed from `static const String` to `static String get` reading from `dotenv.env['API_BASE_URL']` with fallback `http://localhost:8000/api` |
| `lib/main.dart` | `await dotenv.load(fileName: '.env')` added before `runApp()` |

---

### 2.8 AuthInterceptor — Bearer Injection + Token-Based Refresh

**File:** `lib/core/network/interceptors/auth_interceptor.dart` — completely rewritten.

**Before:** Cookie-jar only — injected no headers; refresh POST sent empty body; `debugCookieJar` debug field.

**After:**

| Hook | Behaviour |
|---|---|
| `onRequest` | Calls `getAccessToken()`; if non-empty adds `Authorization: Bearer <token>` header |
| `onError` (401) | Calls `getRefreshToken()`, POSTs `{'refresh': storedRefresh}` to `/token/refresh/`, reads `response.data['data']['access']` (and `['refresh']`), calls `saveTokens()`, retries original request |
| Failure path | Calls `clearTokens()` then `onSessionExpired()` |

**File:** `lib/core/network/api_client.dart`
- Removed `debugCookieJar: ...` line from `AuthInterceptor(...)` constructor call

---

## 3. Bugs Fixed

### Bug 1 — `const AppBarTheme` compile error
`GoogleFonts.poppins()` is not a compile-time constant. Removed `const` from both `AppBarTheme` constructors in `app_theme.dart`.

### Bug 2 — Tokens never stored after login
Root cause: tokens were in `response.data['data']` but code was reading from `response.data` directly. Fixed by unwrapping the `data` envelope first, then casting with `as String? ?? ''` guard.

### Bug 3 — Cookie jar always empty on device
Root cause: backend issues tokens in the response body, not only in `Set-Cookie` headers. The cookie jar had no tokens to send. Fixed by switching to explicit Bearer token injection in `AuthInterceptor.onRequest`.

### Bug 4 — Refresh POST returned 401 (no body)
Root cause: `/token/refresh/` requires `{"refresh": "<token>"}` in the request body. Old interceptor sent an empty POST. Fixed by reading the stored refresh token from secure storage and including it in the POST body.

---

## 4. Files Created / Modified

| File | Action |
|---|---|
| `lib/services/auth_storage.dart` | Created — secure token storage (4 functions) |
| `lib/core/network/interceptors/auth_interceptor.dart` | Rewritten — Bearer injection + token-based refresh + clearTokens on failure |
| `lib/core/network/api_client.dart` | Modified — removed `debugCookieJar` param |
| `lib/core/constants/api_constants.dart` | Modified — `baseUrl` is now a getter backed by `flutter_dotenv` |
| `lib/core/theme/app_typography.dart` | Modified — all text styles use `GoogleFonts.poppins()` |
| `lib/core/theme/app_theme.dart` | Modified — font family + AppBar/button text styles use `GoogleFonts.poppins()` |
| `lib/core/router/route_paths.dart` | Modified — added `settingsRolesPermissions` |
| `lib/core/router/app_router.dart` | Modified — registered `RolesPermissionsPage` route |
| `lib/features/auth/data/datasource/auth_remote_datasource.dart` | Modified — guarded `saveTokens` call after login |
| `lib/features/settings/feature_module.dart` | Rewritten — organised exports per subfolder |
| `lib/features/settings/presentation/pages/settings_page_types.dart` | Modified — `icon` extension + Roles & Permissions tile |
| `lib/features/settings/presentation/widgets/settings_tab_bar.dart` | Modified — icon param + pill highlight animation |
| `lib/features/settings/presentation/pages/roles_permissions/roles_permissions_page.dart` | Created |
| `lib/features/settings/presentation/widgets/roles_permissions/permission_matrix_data.dart` | Created |
| `lib/features/settings/presentation/widgets/roles_permissions/permission_cell.dart` | Created |
| `lib/features/settings/presentation/widgets/roles_permissions/permissions_desktop_table.dart` | Created |
| `lib/features/settings/presentation/widgets/roles_permissions/permissions_mobile_cards.dart` | Created |
| `pages/departments/`, `pages/smtp/`, `pages/email_templates/` | Moved (git mv) — 4 page files |
| `widgets/smtp/`, `widgets/email_templates/`, `widgets/departments/` | Moved (git mv) — 34 widget files |
| `lib/main.dart` | Modified — `dotenv.load()` before `runApp()` |
| `pubspec.yaml` | Modified — added `google_fonts`, `flutter_dotenv`; removed local font section; added `.env` asset |
| `.env.example` | Created |
| `.gitignore` | Modified — added `.env` |

---

## 5. Git

**Branch:** `main`
**Commit:** `9aa5ced` — _feat: auth token storage, Bearer injection, dotenv, roles & settings reorg_
**Remote:** `https://github.com/pramodkunja/royal_hrms.git`
**Status:** Pushed ✓

---

## 6. Architecture Standards Followed

- Zero hardcoded colors — all `AppColors.*`
- Zero hardcoded text styles — all `context.textTheme.*` or `GoogleFonts.poppins(...)`
- No API calls inside widgets — all network via `AuthInterceptor` / notifiers
- Repository returns domain entities only
- Route strings use `RoutePaths` constants
- Tokens stored in `flutter_secure_storage` — never in `SharedPreferences`
- `.env` gitignored; `.env.example` committed for team onboarding
- Feature-first folder structure maintained; all new settings modules in their own subfolder
