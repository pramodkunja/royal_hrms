import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/extensions.dart';
import '../../domain/entities/department.dart';
import '../providers/departments_providers.dart';
import 'add_edit_department_dialog.dart';
import 'departments_accordion_item.dart';
import 'departments_atom_widgets.dart';

// ---------------------------------------------------------------------------
// Module-level delete confirmation helper
// ---------------------------------------------------------------------------

Future<void> _confirmDeleteDepartment(
  BuildContext context,
  WidgetRef ref,
  Department dept,
) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Delete Department'),
      content: Text(
        'Are you sure you want to delete "${dept.name}"? '
        'This will also remove all its designations.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(ctx).pop(true),
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.error,
            foregroundColor: Colors.white,
          ),
          child: const Text('Delete'),
        ),
      ],
    ),
  );

  if (confirmed == true && context.mounted) {
    try {
      await ref.read(departmentsProvider.notifier).deleteDepartment(dept.id);
    } on AppException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(Failure.fromException(e).message),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }
}

// ---------------------------------------------------------------------------
// Mobile layout — accordion inline expansion
// ---------------------------------------------------------------------------

class DeptMobileLayout extends ConsumerWidget {
  const DeptMobileLayout({
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
    final mutedColor = isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final bgColor = isDark ? AppColors.darkBackground : AppColors.lightBackground;

    return ColoredBox(
      color: bgColor,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
        children: [
          // Add Department button
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton.icon(
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
          ),
          const SizedBox(height: 16),

          // Stats
          Row(
            children: [
              Expanded(
                child: DeptStatCard(
                  icon: Icons.account_tree_outlined,
                  iconColor: AppColors.primary,
                  count: state.departments.length,
                  label: 'Total\nDepartments',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: DeptStatCard(
                  icon: Icons.badge_outlined,
                  iconColor: AppColors.emailCategoryNotification,
                  count: state.totalDesignations,
                  label: 'Total\nDesignations',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          DeptStatCard(
            icon: Icons.check_circle_outline,
            iconColor: AppColors.success,
            count: state.activeDepartmentCount,
            label: 'Active Departments',
          ),
          const SizedBox(height: 20),

          // Search
          DeptSearchBar(
            controller: searchCtrl,
            hintText: 'Search departments...',
            mutedColor: mutedColor,
            isDark: isDark,
            borderColor: borderColor,
          ),
          const SizedBox(height: 14),

          // Department accordion list
          if (departments.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Center(
                child: Text(
                  'No departments found',
                  style: context.textTheme.bodyMedium?.copyWith(color: mutedColor),
                ),
              ),
            )
          else
            ...List.generate(departments.length, (index) {
              final dept = departments[index];
              final globalIndex = allDepts.indexWhere((d) => d.id == dept.id);
              final color = deptAvatarColor(globalIndex < 0 ? index : globalIndex);
              final isSelected = dept.id == state.selectedDepartmentId;
              final fullDept = isSelected
                  ? (state.selectedDepartment ?? dept)
                  : dept;

              return DeptAccordionItem(
                department: dept,
                fullDepartment: fullDept,
                avatarColor: color,
                isSelected: isSelected,
                isDark: isDark,
                borderColor: borderColor,
                mutedColor: mutedColor,
                onTap: () => ref
                    .read(departmentsProvider.notifier)
                    .selectDepartment(isSelected ? null : dept.id),
                onEdit: () =>
                    AddEditDepartmentDialog.show(context, existing: dept),
                onDelete: () =>
                    _confirmDeleteDepartment(context, ref, dept),
              );
            }),
        ],
      ),
    );
  }
}
