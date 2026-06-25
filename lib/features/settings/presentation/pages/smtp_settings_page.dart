import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../domain/entities/smtp_config.dart';
import '../providers/smtp_form_state.dart';
import '../providers/smtp_settings_notifier.dart';
import '../widgets/smtp_config_card.dart';
import '../widgets/smtp_form_dialog.dart';

class SmtpSettingsPage extends ConsumerWidget {
  const SmtpSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final smtpAsync = ref.watch(smtpConfigsProvider);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightSurface,
        elevation: 0,
        leading: BackButton(color: AppColors.lightOnSurface),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'SMTP Settings',
              style: textTheme.titleMedium?.copyWith(
                color: AppColors.lightOnSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Configure outgoing mail servers for transactional emails',
              style: textTheme.bodySmall?.copyWith(
                color: AppColors.lightTextMuted,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(0, 36),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Add SMTP'),
              onPressed: () => _showFormDialog(context, ref, null),
            ),
          ),
        ],
      ),
      body: smtpAsync.when(
        loading: () => const AppLoader(message: 'Loading SMTP configurations...'),
        error: (error, _) => AppErrorView(
          message: error.toString(),
          onRetry: () => ref.invalidate(smtpConfigsProvider),
        ),
        data: (configs) => _SmtpSettingsBody(
          configs: configs,
          onEdit: (config) => _showFormDialog(context, ref, config),
          onTest: (config) async {
            await ref
                .read(smtpFormNotifierProvider.notifier)
                .testSmtpConfig(config.id);
            if (!context.mounted) return;
            final s = ref.read(smtpFormNotifierProvider);
            if (s.status == SmtpFormStatus.success) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Test email sent successfully')),
              );
            } else if (s.failure != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(_failureMessage(s.failure!)),
                  backgroundColor: AppColors.error,
                ),
              );
            }
            ref.read(smtpFormNotifierProvider.notifier).reset();
          },
          onSetActive: (config) async {
            await ref
                .read(smtpFormNotifierProvider.notifier)
                .setSmtpConfigActive(config.id);
            if (!context.mounted) return;
            final s = ref.read(smtpFormNotifierProvider);
            if (s.status == SmtpFormStatus.success) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('SMTP configuration set as active')),
              );
            } else if (s.failure != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(_failureMessage(s.failure!)),
                  backgroundColor: AppColors.error,
                ),
              );
            }
            ref.read(smtpFormNotifierProvider.notifier).reset();
          },
          onDelete: (config) async {
            await ref
                .read(smtpFormNotifierProvider.notifier)
                .deleteSmtpConfig(config.id);
            if (!context.mounted) return;
            final s = ref.read(smtpFormNotifierProvider);
            if (s.status == SmtpFormStatus.success) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Configuration deleted')),
              );
            } else if (s.failure != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(_failureMessage(s.failure!)),
                  backgroundColor: AppColors.error,
                ),
              );
            }
            ref.read(smtpFormNotifierProvider.notifier).reset();
          },
        ),
      ),
    );
  }

  void _showFormDialog(
    BuildContext context,
    WidgetRef ref,
    SmtpConfig? existingConfig,
  ) {
    showDialog<void>(
      context: context,
      useRootNavigator: true,
      builder: (_) => SmtpFormDialog(existingConfig: existingConfig),
    );
  }
}

class _SmtpSettingsBody extends StatelessWidget {
  const _SmtpSettingsBody({
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
          _ActiveBanner(config: activeConfig),
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

String _failureMessage(Failure failure) => switch (failure) {
  ServerFailure(:final message) => message,
  NetworkFailure(:final message) => message,
  UnauthorizedFailure(:final message) => message,
  ValidationFailure(:final message) => message,
  CacheFailure(:final message) => message,
  UnknownFailure(:final message) => message,
};

class _ActiveBanner extends StatelessWidget {
  const _ActiveBanner({required this.config});

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
          const Icon(Icons.check_circle_outline, color: AppColors.success, size: 20),
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
