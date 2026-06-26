import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/extensions.dart';
import '../../../domain/entities/department.dart';
import 'departments_designation_expansion.dart';

// ---------------------------------------------------------------------------
// Accordion item: card header + inline expansion panel
// ---------------------------------------------------------------------------

class DeptAccordionItem extends ConsumerWidget {
  const DeptAccordionItem({
    super.key,
    required this.department,
    required this.fullDepartment,
    required this.avatarColor,
    required this.isSelected,
    required this.isDark,
    required this.borderColor,
    required this.mutedColor,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  final Department department;
  final Department fullDepartment;
  final Color avatarColor;
  final bool isSelected;
  final bool isDark;
  final Color borderColor;
  final Color mutedColor;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final surfaceColor = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final selectedBg = AppColors.primary.withValues(alpha: 0.05);
    final activeBorder = AppColors.primary;

    final cardRadius = isSelected
        ? const BorderRadius.vertical(top: Radius.circular(14))
        : BorderRadius.circular(14);

    final cardBorder = isSelected
        ? Border(
            top: BorderSide(color: activeBorder, width: 1.5),
            left: BorderSide(color: activeBorder, width: 1.5),
            right: BorderSide(color: activeBorder, width: 1.5),
          )
        : Border.all(color: borderColor);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Card header
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: cardRadius,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                decoration: BoxDecoration(
                  color: isSelected ? selectedBg : surfaceColor,
                  borderRadius: cardRadius,
                  border: cardBorder,
                ),
                child: Row(
                  children: [
                    // Avatar
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: avatarColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          department.name.isNotEmpty
                              ? department.name[0].toUpperCase()
                              : '?',
                          style: TextStyle(
                            color: avatarColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Name + meta
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            department.name,
                            style: context.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '${department.designationCount} designation${department.designationCount == 1 ? '' : 's'}',
                            style: context.textTheme.bodySmall
                                ?.copyWith(color: mutedColor),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Active/Inactive badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: department.isActive
                            ? AppColors.success.withValues(alpha: 0.10)
                            : AppColors.error.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        department.isActive ? 'Active' : 'Inactive',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: department.isActive
                              ? AppColors.success
                              : AppColors.error,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    IconButton(
                      icon: Icon(Icons.edit_outlined, size: 18, color: mutedColor),
                      onPressed: onEdit,
                      tooltip: 'Edit',
                      visualDensity: VisualDensity.compact,
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                        size: 18,
                        color: AppColors.error,
                      ),
                      onPressed: onDelete,
                      tooltip: 'Delete',
                      visualDensity: VisualDensity.compact,
                    ),
                    Icon(
                      isSelected
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      size: 20,
                      color: isSelected ? AppColors.primary : mutedColor,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Inline expansion panel
          if (isSelected)
            Container(
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(14),
                ),
                border: Border(
                  bottom: BorderSide(color: AppColors.primary, width: 1.5),
                  left: BorderSide(color: AppColors.primary, width: 1.5),
                  right: BorderSide(color: AppColors.primary, width: 1.5),
                ),
              ),
              child: DeptDesignationExpansion(
                department: fullDepartment,
                avatarColor: avatarColor,
                isDark: isDark,
                borderColor: borderColor,
                mutedColor: mutedColor,
              ),
            ),
        ],
      ),
    );
  }
}
