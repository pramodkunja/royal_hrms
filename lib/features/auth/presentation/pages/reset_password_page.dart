import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/router/route_paths.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/validators.dart';
import '../providers/password_reset_controller.dart';
import '../providers/password_reset_state.dart';
import '../widgets/auth_error_banner.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/back_to_sign_in_link.dart';
import '../widgets/labeled_text_field.dart';

class ResetPasswordPage extends ConsumerStatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  ConsumerState<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends ConsumerState<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _confirmFocusNode = FocusNode();
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      if (ref.read(passwordResetControllerProvider).resetToken == null) {
        context.go(RoutePaths.forgotPassword);
      }
    });
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _confirmFocusNode.dispose();
    super.dispose();
  }

  void _backToSignIn() {
    ref.read(passwordResetControllerProvider.notifier).reset();
    context.go(RoutePaths.login);
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    await ref
        .read(passwordResetControllerProvider.notifier)
        .resetPassword(newPassword: _newPasswordController.text);
  }

  @override
  Widget build(BuildContext context) {
    final resetState = ref.watch(passwordResetControllerProvider);
    final isSubmitting = resetState.phase == PasswordResetPhase.submitting;

    if (resetState.isComplete) {
      return AuthScaffold(
        subtitle: 'Sign in to your Royal HRMS account',
        backgroundImagePath: AppAssets.loginBackground,
        child: _ResetPasswordSuccess(onBackToSignIn: _backToSignIn),
      );
    }

    return AuthScaffold(
      subtitle: 'Sign in to your Royal HRMS account',
      backgroundImagePath: AppAssets.loginBackground,
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            BackToSignInLink(onPressed: _backToSignIn),
            const SizedBox(height: 20),
            Text('Set new password', style: context.textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              'Choose a strong password for your account.',
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 20),
            LabeledTextField(
              label: 'New password',
              controller: _newPasswordController,
              hintText: 'New password',
              enabled: !isSubmitting,
              obscureText: _obscureNewPassword,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.newPassword],
              validator: (value) =>
                  Validators.strongPassword(value, fieldName: 'New password'),
              onFieldSubmitted: (_) => _confirmFocusNode.requestFocus(),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureNewPassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
                onPressed: () =>
                    setState(() => _obscureNewPassword = !_obscureNewPassword),
              ),
            ),
            const SizedBox(height: 20),
            LabeledTextField(
              label: 'Confirm password',
              controller: _confirmPasswordController,
              focusNode: _confirmFocusNode,
              hintText: 'Confirm password',
              enabled: !isSubmitting,
              obscureText: _obscureConfirmPassword,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.newPassword],
              validator: (value) => Validators.confirmPassword(
                value,
                _newPasswordController.text,
              ),
              onFieldSubmitted: (_) => _submit(),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirmPassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
                onPressed: () => setState(
                  () => _obscureConfirmPassword = !_obscureConfirmPassword,
                ),
              ),
            ),
            if (resetState.phase == PasswordResetPhase.failure) ...[
              const SizedBox(height: 16),
              AuthErrorBanner(
                message: resetState.failure?.message ?? 'Something went wrong.',
              ),
            ],
            const SizedBox(height: 20),
            FilledButton(
              onPressed: isSubmitting ? null : _submit,
              child: isSubmitting
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2.4),
                    )
                  : const Text('Reset password'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResetPasswordSuccess extends StatelessWidget {
  const _ResetPasswordSuccess({required this.onBackToSignIn});

  final VoidCallback onBackToSignIn;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.success.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: const Icon(Icons.check, color: AppColors.success),
        ),
        const SizedBox(height: 16),
        Text(
          'Your password has been reset successfully. You can now sign in with your new password.',
          textAlign: TextAlign.center,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 20),
        FilledButton(
          onPressed: onBackToSignIn,
          child: const Text('Back to sign in'),
        ),
      ],
    );
  }
}
