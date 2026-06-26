import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/extensions.dart';
import '../../../domain/entities/department.dart';
import 'departments_atom_widgets.dart';

// ---------------------------------------------------------------------------
// Rich header for the desktop designation panel
// ---------------------------------------------------------------------------

class DeptDesignationDetailHeader extends StatelessWidget {
  const DeptDesignationDetailHeader({
    super.key,
    required this.department,
    required this.avatarColor,
    required this.mutedColor,
    required this.chipBg,
    required this.isDark,
    required this.onEditDepartment,
    required this.onAddDesignation,
  });

  final Department department;
  final Color avatarColor;
  final Color mutedColor;
  final Color chipBg;
  final bool isDark;
  final VoidCallback onEditDepartment;
  final VoidCallback onAddDesignation;

  @override
  Widget build(BuildContext context) {
    final designationCount = department.designationCount;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: avatarColor.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    department.name.isNotEmpty
                        ? department.name[0].toUpperCase()
                        : '?',
                    style: TextStyle(
                      color: avatarColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            department.name,
                            style: context.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: department.isActive
                                ? AppColors.success.withValues(alpha: 0.12)
                                : chipBg,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            department.isActive ? 'Active' : 'Inactive',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: department.isActive
                                  ? AppColors.success
                                  : mutedColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        DeptInfoChip(
                          icon: Icons.business_outlined,
                          label:
                              '$designationCount Designation${designationCount == 1 ? '' : 's'}',
                          bgColor: chipBg,
                          textColor: mutedColor,
                        ),
                        const SizedBox(width: 8),
                        DeptInfoChip(
                          icon: Icons.people_outline,
                          label: '${department.employeeCount} People',
                          bgColor: chipBg,
                          textColor: mutedColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              OutlinedButton.icon(
                onPressed: onEditDepartment,
                icon: const Icon(Icons.edit_outlined, size: 15),
                label: const Text('Edit'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(0, 34),
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  textStyle: const TextStyle(fontSize: 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              FilledButton.icon(
                onPressed: onAddDesignation,
                icon: const Icon(Icons.add, size: 15),
                label: const Text('Add Designation'),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(0, 34),
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  textStyle: const TextStyle(fontSize: 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
