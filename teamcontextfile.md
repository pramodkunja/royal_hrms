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
