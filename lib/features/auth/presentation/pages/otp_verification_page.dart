import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/router/route_paths.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/validators.dart';
import '../providers/password_reset_controller.dart';
import '../providers/password_reset_state.dart';
import '../widgets/auth_error_banner.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/back_to_sign_in_link.dart';
import '../widgets/labeled_text_field.dart';

class OtpVerificationPage extends ConsumerStatefulWidget {
  const OtpVerificationPage({super.key});

  @override
  ConsumerState<OtpVerificationPage> createState() =>
      _OtpVerificationPageState();
}

class _OtpVerificationPageState extends ConsumerState<OtpVerificationPage> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      if (ref.read(passwordResetControllerProvider).email == null) {
        context.go(RoutePaths.forgotPassword);
      }
    });
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _backToSignIn() => context.go(RoutePaths.login);

  Future<void> _resendCode() async {
    final email = ref.read(passwordResetControllerProvider).email;
    if (email == null) return;

    final succeeded = await ref
        .read(passwordResetControllerProvider.notifier)
        .sendOtp(email: email);
    if (succeeded && mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Code resent.')));
    }
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    final succeeded = await ref
        .read(passwordResetControllerProvider.notifier)
        .verifyOtp(otp: _otpController.text);
    if (succeeded && mounted) {
      context.push(RoutePaths.resetPassword);
    }
  }

  @override
  Widget build(BuildContext context) {
    final resetState = ref.watch(passwordResetControllerProvider);
    final isSubmitting = resetState.phase == PasswordResetPhase.submitting;
    final email = resetState.email ?? '';

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
            Text('Enter OTP', style: context.textTheme.titleLarge),
            const SizedBox(height: 8),
            Text.rich(
              TextSpan(
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
                children: [
                  const TextSpan(text: 'A 6-digit code was sent to '),
                  TextSpan(
                    text: email,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const TextSpan(text: '. Enter it below.'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            LabeledTextField(
              label: 'One-time code',
              controller: _otpController,
              hintText: '123456',
              enabled: !isSubmitting,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              validator: Validators.otp,
              onFieldSubmitted: (_) => _submit(),
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
                  : const Text('Verify OTP'),
            ),
            const SizedBox(height: 12),
            Center(
              child: TextButton(
                onPressed: isSubmitting ? null : _resendCode,
                child: const Text('Resend code'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
