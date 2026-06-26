import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/extensions.dart';
import '../../domain/entities/email_template.dart';
import '../providers/email_templates_providers.dart';

class EmailTemplateTagsSidebar extends StatelessWidget {
  const EmailTemplateTagsSidebar({
    super.key,
    required this.category,
    required this.existing,
    required this.onTagTap,
  });

  final EmailTemplateCategory category;
  final EmailTemplate? existing;
  final ValueChanged<String> onTagTap;

  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;
    final mutedColor =
        isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;
    final chipBg =
        isDark ? AppColors.darkFieldFill : AppColors.lightFieldFill;

    final tags = (existing?.availableVariables.isNotEmpty ?? false)
        ? existing!.availableVariables
        : tagsForCategory(category);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AVAILABLE TAGS',
            style: context.textTheme.labelSmall?.copyWith(
              color: mutedColor,
              letterSpacing: 0.8,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 14),
          ...tags.map(
            (tag) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _TagChip(
                tag: tag,
                background: chipBg,
                onTap: () => onTagTap(tag),
              ),
            ),
          ),
          if (existing != null) ...[
            const SizedBox(height: 20),
            _LastUpdatedSection(template: existing!),
          ],
        ],
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip({
    required this.tag,
    required this.background,
    required this.onTap,
  });

  final String tag;
  final Color background;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          tag,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            color: context.colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _LastUpdatedSection extends StatelessWidget {
  const _LastUpdatedSection({required this.template});

  final EmailTemplate template;

  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;
    final mutedColor =
        isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;
    final dateStr = template.lastUpdatedAt != null
        ? DateFormat('d MMM yyyy, h:mm a').format(template.lastUpdatedAt!)
        : '—';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Last updated',
          style: context.textTheme.labelSmall?.copyWith(color: mutedColor),
        ),
        const SizedBox(height: 2),
        Text(
          dateStr,
          style: context.textTheme.bodySmall?.copyWith(
            color: isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
        if (template.isBuiltIn) ...[
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(
                Icons.verified_outlined,
                size: 14,
                color: AppColors.emailCategoryNotification,
              ),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  'Built-in template',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.emailCategoryNotification,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
