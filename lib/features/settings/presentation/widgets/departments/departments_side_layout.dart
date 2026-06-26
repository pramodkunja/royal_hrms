import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/extensions.dart';
import '../../../domain/entities/department.dart';
import '../../providers/departments_providers.dart';
import 'add_edit_department_dialog.dart';
import 'departments_atom_widgets.dart';
import 'departments_designation_panel.dart';
import 'departments_list_panel.dart';

// ---------------------------------------------------------------------------
// Desktop side-by-side layout
// ---------------------------------------------------------------------------

class DeptSideBySideLayout extends ConsumerWidget {
  const DeptSideBySideLayout({
    super.key,
    required this.departments,
    required this.allDepts,
    required this.state,
    required this.searchCtrl,
  });

  final List<Department> departments;
  final List<Department> allDepts;
  final DepartmentsState state;
  final TextEditingController searchCtrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = context.theme.brightness == Brightness.dark;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final bgColor = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final mutedColor = isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;

    return ColoredBox(
      color: bgColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header + Add button
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Departments & Designations',
                        style: context.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Global organisation structure — shared across all branches',
                        style: context.textTheme.bodySmall
                            ?.copyWith(color: mutedColor),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                FilledButton.icon(
                  onPressed: () => AddEditDepartmentDialog.show(context),
                  icon: const Icon(Icons.add, size: 16),
                  label: const Text('Add Department'),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(0, 40),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Stats row
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
            child: Row(
              children: [
                Expanded(
                  child: DeptStatCard(
                    icon: Icons.account_tree_outlined,
                    iconColor: AppColors.primary,
                    count: state.departments.length,
                    label: 'Total Departments',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DeptStatCard(
                    icon: Icons.badge_outlined,
                    iconColor: AppColors.emailCategoryNotification,
                    count: state.totalDesignations,
                    label: 'Total Designations',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DeptStatCard(
                    icon: Icons.check_circle_outline,
                    iconColor: AppColors.success,
                    count: state.activeDepartmentCount,
                    label: 'Active Departments',
                  ),
                ),
              ],
            ),
          ),
          // Two-panel area
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 380,
                    child: DeptListPanel(
                      departments: departments,
                      allDepts: allDepts,
                      selectedId: state.selectedDepartmentId,
                      searchCtrl: searchCtrl,
                      isDark: isDark,
                      borderColor: borderColor,
                    ),
                  ),
                  Container(
                    width: 1,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    color: borderColor,
                  ),
                  Expanded(
                    child: DeptDesignationPanel(state: state),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
