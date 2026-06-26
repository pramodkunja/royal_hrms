import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/extensions.dart';
import '../../domain/entities/department.dart';
import '../providers/departments_providers.dart';
import 'add_edit_department_dialog.dart';
import 'add_edit_designation_dialog.dart';
import 'departments_atom_widgets.dart';
import 'departments_row_cards.dart';

// ---------------------------------------------------------------------------
// Module-level delete confirmation helper
// ---------------------------------------------------------------------------

Future<void> _confirmDeleteDesignation(
  BuildContext context,
  WidgetRef ref,
  Designation desig,
) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Delete Designation'),
      content: Text('Are you sure you want to delete "${desig.name}"?'),
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
      await ref.read(departmentsProvider.notifier).deleteDesignation(desig.id);
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
// Designation expansion content (inside accordion)
// ---------------------------------------------------------------------------

class DeptDesignationExpansion extends ConsumerWidget {
  const DeptDesignationExpansion({
    super.key,
    required this.department,
    required this.avatarColor,
    required this.isDark,
    required this.borderColor,
    required this.mutedColor,
  });

  final Department department;
  final Color avatarColor;
  final bool isDark;
  final Color borderColor;
  final Color mutedColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designations = department.designations;
    final chipBg = isDark ? AppColors.darkFieldFill : AppColors.lightFieldFill;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Action buttons row
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
          child: Row(
            children: [
              DeptInfoChip(
                icon: Icons.people_outline,
                label: '${department.employeeCount} People',
                bgColor: chipBg,
                textColor: mutedColor,
              ),
              const Spacer(),
              OutlinedButton.icon(
                onPressed: () => AddEditDepartmentDialog.show(
                  context,
                  existing: department,
                ),
                icon: const Icon(Icons.edit_outlined, size: 14),
                label: const Text('Edit'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary),
                  minimumSize: const Size(0, 32),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  textStyle: const TextStyle(fontSize: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              FilledButton.icon(
                onPressed: () => AddEditDesignationDialog.show(
                  context,
                  departmentId: department.id,
                  departmentName: department.name,
                ),
                icon: const Icon(Icons.add, size: 14),
                label: const Text('Add'),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(0, 32),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  textStyle: const TextStyle(fontSize: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),
        Divider(height: 1, color: borderColor),

        // Designations header
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 8),
          child: Text(
            'Designations (${department.designationCount})',
            style: context.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: mutedColor,
            ),
          ),
        ),

        // Designation cards
        if (designations.isEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 16),
            child: Text(
              'No designations yet — tap Add to create one.',
              style: context.textTheme.bodySmall?.copyWith(
                color: mutedColor,
                fontStyle: FontStyle.italic,
              ),
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(designations.length, (i) {
                final desig = designations[i];
                return DeptDesignationCard(
                  designation: desig,
                  avatarColor: deptAvatarColor(i),
                  mutedColor: mutedColor,
                  borderColor: borderColor,
                  isDark: isDark,
                  onEdit: () => AddEditDesignationDialog.show(
                    context,
                    departmentId: department.id,
                    departmentName: department.name,
                    existing: desig,
                  ),
                  onDelete: () =>
                      _confirmDeleteDesignation(context, ref, desig),
                );
              }),
            ),
          ),
      ],
    );
  }
}
