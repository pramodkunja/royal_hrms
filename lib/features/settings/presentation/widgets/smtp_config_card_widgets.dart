import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/smtp_config.dart';

class SmtpStatusBadge extends StatelessWidget {
  const SmtpStatusBadge({super.key, required this.isActive});

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

class SmtpDetailGrid extends StatelessWidget {
  const SmtpDetailGrid({super.key, required this.config});

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

    final List<Widget> rowWidgets = [];
    for (int i = 0; i < rows.length; i += 2) {
      final left = rows[i];
      final right = i + 1 < rows.length ? rows[i + 1] : null;
      rowWidgets.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              Expanded(
                child: SmtpDetailCell(label: left.$1, value: left.$2),
              ),
              if (right != null)
                Expanded(
                  child: SmtpDetailCell(label: right.$1, value: right.$2),
                ),
            ],
          ),
        ),
      );
    }

    return Column(children: rowWidgets);
  }
}

class SmtpDetailCell extends StatelessWidget {
  const SmtpDetailCell({super.key, required this.label, required this.value});

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
