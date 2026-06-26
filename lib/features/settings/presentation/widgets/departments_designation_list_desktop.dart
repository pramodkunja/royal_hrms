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
import 'departments_designation_detail_header.dart';
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
// Desktop designation list (rich header + cards)
// ---------------------------------------------------------------------------

class DeptDesignationListDesktop extends ConsumerWidget {
  const DeptDesignationListDesktop({
    super.key,
    required this.department,
    required this.avatarColor,
    required this.mutedColor,
    required this.borderColor,
    required this.isDark,
  });

  final Department department;
  final Color avatarColor;
  final Color mutedColor;
  final Color borderColor;
  final bool isDark;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designations = department.designations;
    final designationCount = department.designationCount;
    final chipBg = isDark ? AppColors.darkFieldFill : AppColors.lightFieldFill;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DeptDesignationDetailHeader(
          department: department,
          avatarColor: avatarColor,
          mutedColor: mutedColor,
          chipBg: chipBg,
          isDark: isDark,
          onEditDepartment: () =>
              AddEditDepartmentDialog.show(context, existing: department),
          onAddDesignation: () => AddEditDesignationDialog.show(
            context,
            departmentId: department.id,
            departmentName: department.name,
          ),
        ),
        Divider(height: 1, color: borderColor),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 10),
          child: Text(
            'Designations ($designationCount)',
            style: context.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        if (designations.isEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
            child: Text(
              'No designations yet — add one above',
              style: context.textTheme.bodySmall?.copyWith(
                color: mutedColor,
                fontStyle: FontStyle.italic,
              ),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 16),
            itemCount: designations.length,
            itemBuilder: (context, index) {
              final desig = designations[index];
              return DeptDesignationCard(
                designation: desig,
                avatarColor: deptAvatarColor(index),
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
            },
          ),
      ],
    );
  }
}
