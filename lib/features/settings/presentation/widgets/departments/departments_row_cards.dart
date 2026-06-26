import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/extensions.dart';
import '../../../domain/entities/department.dart';

// ---------------------------------------------------------------------------
// Department list row (desktop left panel)
// ---------------------------------------------------------------------------

class DeptListRow extends StatelessWidget {
  const DeptListRow({
    super.key,
    required this.department,
    required this.avatarColor,
    required this.isSelected,
    required this.mutedColor,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  final Department department;
  final Color avatarColor;
  final bool isSelected;
  final Color mutedColor;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final selectedBg = AppColors.primary.withValues(alpha: 0.07);

    return InkWell(
      onTap: onTap,
      child: Container(
        color: isSelected ? selectedBg : null,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: avatarColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  department.name.isNotEmpty
                      ? department.name[0].toUpperCase()
                      : '?',
                  style: TextStyle(
                    color: avatarColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          department.name,
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (department.isActive) ...[
                        const SizedBox(width: 6),
                        Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                            color: AppColors.success,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${department.designationCount} designation${department.designationCount == 1 ? '' : 's'}',
                    style: context.textTheme.bodySmall?.copyWith(color: mutedColor),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.edit_outlined, size: 16, color: mutedColor),
              onPressed: onEdit,
              tooltip: 'Edit',
              visualDensity: VisualDensity.compact,
            ),
            IconButton(
              icon: const Icon(
                Icons.delete_outline,
                size: 16,
                color: AppColors.error,
              ),
              onPressed: onDelete,
              tooltip: 'Delete',
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Designation card (used in both mobile expansion and desktop panel)
// ---------------------------------------------------------------------------

class DeptDesignationCard extends StatelessWidget {
  const DeptDesignationCard({
    super.key,
    required this.designation,
    required this.avatarColor,
    required this.mutedColor,
    required this.borderColor,
    required this.isDark,
    required this.onEdit,
    required this.onDelete,
  });

  final Designation designation;
  final Color avatarColor;
  final Color mutedColor;
  final Color borderColor;
  final bool isDark;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final cardBg = isDark ? AppColors.darkFieldFill : AppColors.lightBackground;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: avatarColor.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                designation.name.isNotEmpty
                    ? designation.name[0].toUpperCase()
                    : '?',
                style: TextStyle(
                  color: avatarColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              designation.name,
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 6),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: designation.isActive ? AppColors.success : AppColors.error,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                designation.isActive ? 'Active' : 'Inactive',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: designation.isActive ? AppColors.success : AppColors.error,
                ),
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.edit_outlined, size: 15, color: mutedColor),
            onPressed: onEdit,
            tooltip: 'Edit',
            visualDensity: VisualDensity.compact,
          ),
          IconButton(
            icon: const Icon(
              Icons.delete_outline,
              size: 15,
              color: AppColors.error,
            ),
            onPressed: onDelete,
            tooltip: 'Delete',
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}
