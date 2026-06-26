import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/extensions.dart';
import '../../providers/departments_providers.dart';
import 'departments_atom_widgets.dart';
import 'departments_designation_list_desktop.dart';

// ---------------------------------------------------------------------------
// Desktop right panel
// ---------------------------------------------------------------------------

class DeptDesignationPanel extends ConsumerWidget {
  const DeptDesignationPanel({super.key, required this.state});

  final DepartmentsState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = context.theme.brightness == Brightness.dark;
    final surfaceColor = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final mutedColor = isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;

    final selectedDept = state.selectedDepartment;

    if (selectedDept == null) {
      return Container(
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor),
        ),
        child: DeptEmptyDesignationState(mutedColor: mutedColor),
      );
    }

    final selectedIndex =
        state.departments.indexWhere((d) => d.id == selectedDept.id);
    final avatarColor = deptAvatarColor(selectedIndex < 0 ? 0 : selectedIndex);

    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: DeptDesignationListDesktop(
        department: selectedDept,
        avatarColor: avatarColor,
        mutedColor: mutedColor,
        borderColor: borderColor,
        isDark: isDark,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Empty state placeholder
// ---------------------------------------------------------------------------

class DeptEmptyDesignationState extends StatelessWidget {
  const DeptEmptyDesignationState({super.key, required this.mutedColor});

  final Color mutedColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.account_tree_outlined,
              size: 48,
              color: mutedColor.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No department selected',
              style: context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Pick a department to view and manage its designations',
              style: context.textTheme.bodySmall?.copyWith(color: mutedColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
