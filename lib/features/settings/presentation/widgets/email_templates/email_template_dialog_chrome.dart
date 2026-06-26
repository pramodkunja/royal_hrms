import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/extensions.dart';
import '../../../domain/entities/email_template.dart';

class EmailTemplateDialogHeader extends StatelessWidget {
  const EmailTemplateDialogHeader({
    super.key,
    required this.existing,
    required this.onClose,
  });

  final EmailTemplate? existing;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;
    final mutedColor =
        isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;
    final isEditing = existing != null;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 18, 16, 14),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: isEditing ? 'Edit — ' : 'Add Email Template',
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    children: isEditing
                        ? [
                            TextSpan(
                              text: existing!.name,
                              style: TextStyle(
                                color: context.colorScheme.primary,
                              ),
                            ),
                          ]
                        : null,
                  ),
                ),
                if (isEditing) ...[
                  const SizedBox(height: 2),
                  Text(
                    existing!.description,
                    style: context.textTheme.bodySmall
                        ?.copyWith(color: mutedColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          IconButton(
            onPressed: onClose,
            icon: const Icon(Icons.close),
            tooltip: 'Close',
          ),
        ],
      ),
    );
  }
}

class EmailTemplateDialogFooter extends StatelessWidget {
  const EmailTemplateDialogFooter({
    super.key,
    required this.onCancel,
    required this.onSubmit,
    this.isSaving = false,
  });

  final VoidCallback onCancel;
  final VoidCallback onSubmit;
  final bool isSaving;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton(
            onPressed: isSaving ? null : onCancel,
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(0, 44),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            ),
            child: const Text('Cancel'),
          ),
          const SizedBox(width: 12),
          FilledButton.icon(
            onPressed: isSaving ? null : onSubmit,
            icon: isSaving
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.save_outlined, size: 16),
            label: const Text('Save Template'),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              minimumSize: const Size(0, 44),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            ),
          ),
        ],
      ),
    );
  }
}

class EmailTemplateErrorBanner extends StatelessWidget {
  const EmailTemplateErrorBanner({
    super.key,
    required this.message,
    required this.onDismiss,
  });

  final String message;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final errorColor = Theme.of(context).colorScheme.error;
    final errorContainerColor = Theme.of(context).colorScheme.errorContainer;
    final onErrorContainerColor =
        Theme.of(context).colorScheme.onErrorContainer;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: errorContainerColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: errorColor.withValues(alpha: 0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Icon(Icons.error_outline, size: 18, color: errorColor),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: onErrorContainerColor,
                    fontWeight: FontWeight.w500,
                    height: 1.45,
                  ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onDismiss,
            child: Icon(Icons.close, size: 16, color: errorColor),
          ),
        ],
      ),
    );
  }
}

class EmailTemplateFieldLabel extends StatelessWidget {
  const EmailTemplateFieldLabel({
    super.key,
    required this.label,
    this.required = false,
  });

  final String label;
  final bool required;

  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;
    return RichText(
      text: TextSpan(
        text: label,
        style: context.textTheme.labelMedium?.copyWith(
          color: isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface,
          fontWeight: FontWeight.w500,
        ),
        children: required
            ? [
                TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ]
            : null,
      ),
    );
  }
}

class EmailTemplateHtmlToggleButton extends StatelessWidget {
  const EmailTemplateHtmlToggleButton({
    super.key,
    required this.showHtmlSource,
    required this.onToggle,
  });

  final bool showHtmlSource;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onToggle,
      icon: const Icon(Icons.code, size: 14),
      label: Text(
        showHtmlSource ? 'Visual editor' : 'HTML source',
        style: const TextStyle(fontSize: 12),
      ),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        visualDensity: VisualDensity.compact,
      ),
    );
  }
}
