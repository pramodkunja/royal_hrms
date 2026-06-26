import 'package:flutter/material.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/theme/app_colors.dart';

class SmtpFormTitleBar extends StatelessWidget {
  const SmtpFormTitleBar({
    super.key,
    required this.isEditing,
    required this.onClose,
  });

  final bool isEditing;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 12, 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  isEditing
                      ? 'Edit SMTP Configuration'
                      : 'Add SMTP Configuration',
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.lightOnSurface,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, size: 20),
                color: AppColors.lightTextMuted,
                onPressed: onClose,
              ),
            ],
          ),
        ),
        const Divider(height: 1, color: AppColors.lightBorder),
      ],
    );
  }
}

class SmtpFormErrorBanner extends StatelessWidget {
  const SmtpFormErrorBanner({super.key, required this.failure});

  final Failure failure;

  @override
  Widget build(BuildContext context) {
    final message = switch (failure) {
      ServerFailure(:final message) => message,
      NetworkFailure(:final message) => message,
      UnauthorizedFailure(:final message) => message,
      ValidationFailure(:final message) => message,
      CacheFailure(:final message) => message,
      UnknownFailure(:final message) => message,
    };

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: AppColors.error, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.error,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class SmtpFormFooter extends StatelessWidget {
  const SmtpFormFooter({
    super.key,
    required this.isEditing,
    required this.isSubmitting,
    required this.onSubmit,
    required this.onCancel,
  });

  final bool isEditing;
  final bool isSubmitting;
  final VoidCallback onSubmit;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.lightBorder)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: OverflowBar(
        alignment: MainAxisAlignment.end,
        spacing: 8,
        overflowAlignment: OverflowBarAlignment.end,
        overflowSpacing: 8,
        children: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: AppColors.lightTextMuted,
              minimumSize: const Size(0, 40),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: isSubmitting ? null : onCancel,
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              minimumSize: const Size(0, 40),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: isSubmitting ? null : onSubmit,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isSubmitting)
                  const SizedBox(
                    width: 14,
                    height: 14,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                else
                  const Icon(Icons.save_outlined, size: 16),
                const SizedBox(width: 6),
                Text(isEditing ? 'Save' : 'Add Configuration'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
