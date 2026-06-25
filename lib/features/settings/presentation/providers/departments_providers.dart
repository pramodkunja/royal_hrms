import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/department.dart';
import '../../domain/repositories/settings_repository.dart';
import 'settings_providers.dart';

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------

class DepartmentsState {
  const DepartmentsState({
    required this.departments,
    this.selectedDepartmentId,
  });

  final List<Department> departments;
  final String? selectedDepartmentId;

  int get totalDesignations =>
      departments.fold(0, (sum, d) => sum + d.designationCount);

  int get activeDepartmentCount =>
      departments.where((d) => d.isActive).length;

  Department? get selectedDepartment => departments
      .where((d) => d.id == selectedDepartmentId)
      .firstOrNull;

  DepartmentsState copyWith({
    List<Department>? departments,
    String? selectedDepartmentId,
    bool clearSelection = false,
  }) {
    return DepartmentsState(
      departments: departments ?? this.departments,
      selectedDepartmentId: clearSelection
          ? null
          : (selectedDepartmentId ?? this.selectedDepartmentId),
    );
  }
}

// ---------------------------------------------------------------------------
// Notifier
// ---------------------------------------------------------------------------

class DepartmentsNotifier extends AsyncNotifier<DepartmentsState> {
  SettingsRepository get _repo => ref.read(settingsRepositoryProvider);

  @override
  Future<DepartmentsState> build() async {
    final departments = await _repo.getDepartments();
    return DepartmentsState(departments: departments);
  }

  Future<void> selectDepartment(String? id) async {
    final current = state.value;
    if (current == null) return;

    if (id == null) {
      state = AsyncData(current.copyWith(clearSelection: true));
      return;
    }

    // Switch selection immediately so the panel appears responsive
    state = AsyncData(current.copyWith(selectedDepartmentId: id));

    // Load designations only if not yet fetched for this department
    final dept = current.departments.firstWhere(
      (d) => d.id == id,
      orElse: () => Department(
        id: '',
        name: '',
        description: '',
        isActive: false,
      ),
    );
    if (dept.id.isEmpty || dept.designations.isNotEmpty) return;

    try {
      final designations = await _repo.getDesignations(id);
      final updated = state.value;
      if (updated == null) return;
      final updatedList = updated.departments.map((d) {
        if (d.id == id) return d.copyWith(designations: designations);
        return d;
      }).toList();
      state = AsyncData(updated.copyWith(departments: updatedList));
    } catch (_) {
      // Non-fatal: designation panel will show empty list with an add button
    }
  }

  Future<void> addDepartment(Department dept) async {
    final current = state.value;
    if (current == null) return;

    final created = await _repo.createDepartment(dept);
    state = AsyncData(
      current.copyWith(
        departments: [...current.departments, created],
      ),
    );
  }

  Future<void> updateDepartment(Department dept) async {
    final current = state.value;
    if (current == null) return;

    final updated = await _repo.updateDepartment(dept);
    final updatedList = current.departments.map((d) {
      return d.id == updated.id ? updated : d;
    }).toList();
    state = AsyncData(current.copyWith(departments: updatedList));
  }

  Future<void> deleteDepartment(String id) async {
    final current = state.value;
    if (current == null) return;

    await _repo.deleteDepartment(id);
    final updatedList = current.departments.where((d) => d.id != id).toList();
    final wasSelected = current.selectedDepartmentId == id;
    state = AsyncData(
      wasSelected
          ? current.copyWith(departments: updatedList, clearSelection: true)
          : current.copyWith(departments: updatedList),
    );
  }

  Future<void> addDesignation(Designation designation) async {
    final current = state.value;
    if (current == null) return;

    final created = await _repo.createDesignation(designation);
    final updatedList = current.departments.map((dept) {
      if (dept.id == created.departmentId) {
        return dept.copyWith(
          designations: [...dept.designations, created],
        );
      }
      return dept;
    }).toList();
    state = AsyncData(current.copyWith(departments: updatedList));
  }

  Future<void> updateDesignation(Designation designation) async {
    final current = state.value;
    if (current == null) return;

    final updated = await _repo.updateDesignation(designation);
    final updatedList = current.departments.map((dept) {
      if (dept.id == updated.departmentId) {
        final updatedDesignations = dept.designations.map((d) {
          return d.id == updated.id ? updated : d;
        }).toList();
        return dept.copyWith(designations: updatedDesignations);
      }
      return dept;
    }).toList();
    state = AsyncData(current.copyWith(departments: updatedList));
  }

  Future<void> deleteDesignation(String id) async {
    final current = state.value;
    if (current == null) return;

    await _repo.deleteDesignation(id);
    final updatedList = current.departments.map((dept) {
      final hasIt = dept.designations.any((d) => d.id == id);
      if (hasIt) {
        return dept.copyWith(
          designations: dept.designations.where((d) => d.id != id).toList(),
        );
      }
      return dept;
    }).toList();
    state = AsyncData(current.copyWith(departments: updatedList));
  }
}

// ---------------------------------------------------------------------------
// Provider
// ---------------------------------------------------------------------------

final departmentsProvider =
    AsyncNotifierProvider<DepartmentsNotifier, DepartmentsState>(
  DepartmentsNotifier.new,
);
