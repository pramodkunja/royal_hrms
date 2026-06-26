import 'package:flutter/material.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/smtp_config.dart';
import '../widgets/smtp_config_card.dart';

String smtpFailureMessage(Failure failure) => switch (failure) {
  ServerFailure(:final message) => message,
  NetworkFailure(:final message) => message,
  UnauthorizedFailure(:final message) => message,
  ValidationFailure(:final message) => message,
  CacheFailure(:final message) => message,
  UnknownFailure(:final message) => message,
};

class SmtpSettingsBody extends StatelessWidget {
  const SmtpSettingsBody({
    super.key,
    required this.configs,
    required this.onEdit,
    required this.onTest,
    required this.onSetActive,
    required this.onDelete,
  });

  final List<SmtpConfig> configs;
  final void Function(SmtpConfig) onEdit;
  final void Function(SmtpConfig) onTest;
  final void Function(SmtpConfig) onSetActive;
  final void Function(SmtpConfig) onDelete;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final activeConfig = configs.where((c) => c.isActive).firstOrNull;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (activeConfig != null) ...[
          SmtpActiveBanner(config: activeConfig),
          const SizedBox(height: 16),
        ],
        if (configs.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 48),
              child: Column(
                children: [
                  Icon(
                    Icons.email_outlined,
                    size: 48,
                    color: AppColors.lightTextMuted,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'No SMTP configurations yet.',
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.lightTextMuted,
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          ...configs.map(
            (config) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: SmtpConfigCard(
                config: config,
                onTest: () => onTest(config),
                onSetActive: config.isActive ? null : () => onSetActive(config),
                onEdit: () => onEdit(config),
                onDelete: () => onDelete(config),
              ),
            ),
          ),
      ],
    );
  }
}

class SmtpActiveBanner extends StatelessWidget {
  const SmtpActiveBanner({super.key, required this.config});

  final SmtpConfig config;

  String get _typeName => config.type == SmtpType.local
      ? 'Local (Gmail / Custom SMTP)'
      : 'Server (Dedicated Mail Server)';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.success.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_outline,
            color: AppColors.success,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Currently using $_typeName for sending emails.',
              style: textTheme.bodySmall?.copyWith(
                color: AppColors.success,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
