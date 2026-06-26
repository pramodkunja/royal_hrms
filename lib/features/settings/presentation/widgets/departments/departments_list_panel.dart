import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/extensions.dart';
import '../../../domain/entities/department.dart';
import '../../providers/departments_providers.dart';
import 'add_edit_department_dialog.dart';
import 'departments_atom_widgets.dart';
import 'departments_row_cards.dart';

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
// Desktop left panel
// ---------------------------------------------------------------------------

class DeptListPanel extends ConsumerWidget {
  const DeptListPanel({
    super.key,
    required this.departments,
    required this.allDepts,
    required this.selectedId,
    required this.searchCtrl,
    required this.isDark,
    required this.borderColor,
  });

  final List<Department> departments;
  final List<Department> allDepts;
  final String? selectedId;
  final TextEditingController searchCtrl;
  final bool isDark;
  final Color borderColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final surfaceColor = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final mutedColor = isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;

    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: DeptSearchBar(
              controller: searchCtrl,
              hintText: 'Search departments...',
              mutedColor: mutedColor,
              isDark: isDark,
              borderColor: borderColor,
            ),
          ),
          Divider(height: 1, color: borderColor),
          if (departments.isEmpty)
            Padding(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: Text(
                  'No departments found',
                  style: context.textTheme.bodyMedium?.copyWith(color: mutedColor),
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: departments.length,
              separatorBuilder: (_, _) => Divider(height: 1, color: borderColor),
              itemBuilder: (context, index) {
                final dept = departments[index];
                final globalIndex = allDepts.indexWhere((d) => d.id == dept.id);
                final color = deptAvatarColor(globalIndex < 0 ? index : globalIndex);
                final isSelected = dept.id == selectedId;

                return DeptListRow(
                  department: dept,
                  avatarColor: color,
                  isSelected: isSelected,
                  mutedColor: mutedColor,
                  onTap: () => ref
                      .read(departmentsProvider.notifier)
                      .selectDepartment(isSelected ? null : dept.id),
                  onEdit: () =>
                      AddEditDepartmentDialog.show(context, existing: dept),
                  onDelete: () =>
                      _confirmDeleteDepartment(context, ref, dept),
                );
              },
            ),
        ],
      ),
    );
  }
}
