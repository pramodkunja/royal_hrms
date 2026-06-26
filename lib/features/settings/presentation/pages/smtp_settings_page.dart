import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../domain/entities/smtp_config.dart';
import '../providers/smtp_form_state.dart';
import '../providers/smtp_settings_notifier.dart';
import '../widgets/smtp_form_dialog.dart';
import 'smtp_settings_body.dart';

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
        loading: () =>
            const AppLoader(message: 'Loading SMTP configurations...'),
        error: (error, _) => AppErrorView(
          message: error.toString(),
          onRetry: () => ref.invalidate(smtpConfigsProvider),
        ),
        data: (configs) => SmtpSettingsBody(
          configs: configs,
          onEdit: (config) => _showFormDialog(context, ref, config),
          onTest: (config) => _handleTest(context, ref, config),
          onSetActive: (config) => _handleSetActive(context, ref, config),
          onDelete: (config) => _handleDelete(context, ref, config),
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

  Future<void> _handleTest(
    BuildContext context,
    WidgetRef ref,
    SmtpConfig config,
  ) async {
    await ref.read(smtpFormNotifierProvider.notifier).testSmtpConfig(config.id);
    if (!context.mounted) return;
    final s = ref.read(smtpFormNotifierProvider);
    if (s.status == SmtpFormStatus.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Test email sent successfully')),
      );
    } else if (s.failure != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(smtpFailureMessage(s.failure!)),
          backgroundColor: AppColors.error,
        ),
      );
    }
    ref.read(smtpFormNotifierProvider.notifier).reset();
  }

  Future<void> _handleSetActive(
    BuildContext context,
    WidgetRef ref,
    SmtpConfig config,
  ) async {
    await ref
        .read(smtpFormNotifierProvider.notifier)
        .setSmtpConfigActive(config.id);
    if (!context.mounted) return;
    final s = ref.read(smtpFormNotifierProvider);
    if (s.status == SmtpFormStatus.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('SMTP configuration set as active')),
      );
    } else if (s.failure != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(smtpFailureMessage(s.failure!)),
          backgroundColor: AppColors.error,
        ),
      );
    }
    ref.read(smtpFormNotifierProvider.notifier).reset();
  }

  Future<void> _handleDelete(
    BuildContext context,
    WidgetRef ref,
    SmtpConfig config,
  ) async {
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
          content: Text(smtpFailureMessage(s.failure!)),
          backgroundColor: AppColors.error,
        ),
      );
    }
    ref.read(smtpFormNotifierProvider.notifier).reset();
  }
}
