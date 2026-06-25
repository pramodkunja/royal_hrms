import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/extensions.dart';
import '../../domain/entities/email_template.dart';

class EmailTemplateCard extends StatelessWidget {
  const EmailTemplateCard({
    super.key,
    required this.template,
    required this.accentColor,
    required this.onView,
    required this.onEdit,
    required this.onToggleActive,
  });

  final EmailTemplate template;
  final Color accentColor;
  final VoidCallback onView;
  final VoidCallback onEdit;
  final ValueChanged<bool> onToggleActive;

  IconData _iconFor(EmailTemplateCategory category) {
    return switch (category) {
      EmailTemplateCategory.document => Icons.description_outlined,
      EmailTemplateCategory.notification => Icons.notifications_outlined,
      EmailTemplateCategory.reminder => Icons.alarm_outlined,
      EmailTemplateCategory.wish => Icons.celebration_outlined,
    };
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final bgColor = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final mutedColor =
        isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;
    final codeBackground =
        isDark ? AppColors.darkFieldFill : AppColors.lightFieldFill;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category icon
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _iconFor(template.category),
              color: accentColor,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          // Name + description + subject
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  template.name,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (template.description.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    template.description,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: mutedColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: codeBackground,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    template.subject,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: mutedColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Actions: view, edit, active toggle
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _ActionButton(
                    icon: Icons.visibility_outlined,
                    tooltip: 'View',
                    onTap: onView,
                    color: mutedColor,
                  ),
                  const SizedBox(width: 4),
                  _ActionButton(
                    icon: Icons.edit_outlined,
                    tooltip: 'Edit',
                    onTap: onEdit,
                    color: mutedColor,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Tooltip(
                message: template.isActive ? 'Active' : 'Inactive',
                child: Switch(
                  value: template.isActive,
                  onChanged: onToggleActive,
                  activeThumbColor: AppColors.primary,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
    required this.color,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            border: Border.all(
              color: color.withValues(alpha: 0.3),
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, size: 16, color: color),
        ),
      ),
    );
  }
}
