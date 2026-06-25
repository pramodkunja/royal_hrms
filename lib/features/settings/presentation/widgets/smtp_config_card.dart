import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/smtp_config.dart';

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
            // ----------------------------------------------------------------
            // Header
            // ----------------------------------------------------------------
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
                _StatusBadge(isActive: config.isActive),
              ],
            ),

            const SizedBox(height: 16),
            const Divider(color: AppColors.lightBorder, height: 1),
            const SizedBox(height: 16),

            // ----------------------------------------------------------------
            // Detail grid — two columns
            // ----------------------------------------------------------------
            _DetailGrid(config: config),

            const SizedBox(height: 16),
            const Divider(color: AppColors.lightBorder, height: 1),
            const SizedBox(height: 12),

            // ----------------------------------------------------------------
            // Action buttons
            // ----------------------------------------------------------------
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
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
          'Are you sure you want to delete "${config.name}"? This action cannot be undone.',
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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

// ---------------------------------------------------------------------------
// Status badge
// ---------------------------------------------------------------------------

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.success : AppColors.lightTextMuted;
    final label = isActive ? 'Active' : 'Inactive';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Detail grid — pairs of label + value, rendered in two columns
// ---------------------------------------------------------------------------

class _DetailGrid extends StatelessWidget {
  const _DetailGrid({required this.config});

  final SmtpConfig config;

  String get _priorityLabel =>
      config.priority == SmtpPriority.normal ? 'Normal' : 'High';

  String get _receiverLabel =>
      config.receiverEmail == SmtpReceiverEmail.emailId
          ? 'Email ID'
          : 'Personal Email ID';

  @override
  Widget build(BuildContext context) {
    final portLabel =
        config.useTls ? '${config.port} · TLS' : config.port.toString();

    final rows = <(String, String)>[
      ('HOST', config.host),
      ('PORT', portLabel),
      ('FROM EMAIL', config.fromEmail),
      ('SENDER NAME', config.senderName),
      ('USERNAME', config.username),
      ('PASSWORD', '••••••••'),
      ('BCC EMAIL', config.bccEmail ?? '-'),
      ('PRIORITY', _priorityLabel),
      ('RECEIVER EMAIL', _receiverLabel),
    ];

    // Split into pairs of two per row
    final List<Widget> rowWidgets = [];
    for (int i = 0; i < rows.length; i += 2) {
      final left = rows[i];
      final right = i + 1 < rows.length ? rows[i + 1] : null;
      rowWidgets.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              Expanded(child: _DetailCell(label: left.$1, value: left.$2)),
              if (right != null)
                Expanded(child: _DetailCell(label: right.$1, value: right.$2)),
            ],
          ),
        ),
      );
    }

    return Column(children: rowWidgets);
  }
}

class _DetailCell extends StatelessWidget {
  const _DetailCell({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textTheme.labelSmall?.copyWith(
            color: AppColors.lightTextMuted,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: textTheme.bodySmall?.copyWith(
            color: AppColors.lightOnSurface,
            fontWeight: FontWeight.w500,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
