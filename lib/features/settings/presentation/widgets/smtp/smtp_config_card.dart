import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../domain/entities/smtp_config.dart';
import 'smtp_config_card_widgets.dart';

class SmtpConfigCard extends StatelessWidget {
  const SmtpConfigCard({
    super.key,
    required this.config,
    required this.onTest,
    required this.onEdit,
    this.onSetActive,
    this.onDelete,
  });

  final SmtpConfig config;
  final VoidCallback onTest;
  final VoidCallback onEdit;

  /// Null means the card is the active one — "Set Active" button is hidden.
  final VoidCallback? onSetActive;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final typeName = config.type == SmtpType.local
        ? 'Local — Gmail / Custom SMTP'
        : 'Server — Dedicated Mail Server';
    final updatedLabel =
        'Updated ${DateFormat('d MMM yyyy, h:mm a').format(config.updatedAt)}';

    return Card(
      color: AppColors.lightSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.lightBorder),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.email_outlined,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        config.name,
                        style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.lightOnSurface,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        typeName,
                        style: textTheme.bodySmall?.copyWith(
                          color: AppColors.lightTextMuted,
                        ),
                      ),
                      const SizedBox(height: 1),
                      Text(
                        updatedLabel,
                        style: textTheme.bodySmall?.copyWith(
                          color: AppColors.lightTextMuted,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                SmtpStatusBadge(isActive: config.isActive),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(color: AppColors.lightBorder, height: 1),
            const SizedBox(height: 16),
            SmtpDetailGrid(config: config),
            const SizedBox(height: 16),
            const Divider(color: AppColors.lightBorder, height: 1),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                OutlinedButton.icon(
                  style: _outlinedStyle(),
                  icon: const Icon(Icons.send_outlined, size: 16),
                  label: const Text('Test'),
                  onPressed: onTest,
                ),
                if (onSetActive != null)
                  OutlinedButton.icon(
                    style: _outlinedStyle(),
                    icon: const Icon(Icons.star_outline, size: 16),
                    label: const Text('Set Active'),
                    onPressed: onSetActive,
                  ),
                if (onDelete != null)
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.error,
                      side: BorderSide(
                          color: AppColors.error.withValues(alpha: 0.5)),
                      minimumSize: const Size(0, 36),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    icon: const Icon(Icons.delete_outline, size: 16),
                    label: const Text('Delete'),
                    onPressed: () => _confirmDelete(context),
                  ),
                FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(0, 36),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(Icons.edit_outlined, size: 16),
                  label: const Text('Edit'),
                  onPressed: onEdit,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog<bool>(
      context: context,
      useRootNavigator: true,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Configuration'),
        content: Text(
          'Are you sure you want to delete "${config.name}"? '
          'This action cannot be undone.',
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(minimumSize: const Size(0, 36)),
            onPressed: () =>
                Navigator.of(ctx, rootNavigator: true).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.error,
              minimumSize: const Size(0, 36),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            onPressed: () =>
                Navigator.of(ctx, rootNavigator: true).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    ).then((confirmed) {
      if (confirmed == true) onDelete!();
    });
  }

  ButtonStyle _outlinedStyle() => OutlinedButton.styleFrom(
    foregroundColor: AppColors.lightOnSurface,
    side: const BorderSide(color: AppColors.lightBorder),
    minimumSize: const Size(0, 36),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  );
}
