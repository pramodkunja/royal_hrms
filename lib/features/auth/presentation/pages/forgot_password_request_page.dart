import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_paths.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/validators.dart';
import '../providers/password_reset_controller.dart';
import '../providers/password_reset_state.dart';
import '../widgets/auth_error_banner.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/back_to_sign_in_link.dart';
import '../widgets/labeled_text_field.dart';

class ForgotPasswordRequestPage extends ConsumerStatefulWidget {
  const ForgotPasswordRequestPage({super.key});

  @override
  ConsumerState<ForgotPasswordRequestPage> createState() =>
      _ForgotPasswordRequestPageState();
}

class _ForgotPasswordRequestPageState
    extends ConsumerState<ForgotPasswordRequestPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(passwordResetControllerProvider.notifier).reset(),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _backToSignIn() => context.go(RoutePaths.login);

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    final succeeded = await ref
        .read(passwordResetControllerProvider.notifier)
        .sendOtp(email: _emailController.text);
    if (succeeded && mounted) {
      context.push(RoutePaths.verifyOtp);
    }
  }

  @override
  Widget build(BuildContext context) {
    final resetState = ref.watch(passwordResetControllerProvider);
    final isSubmitting = resetState.phase == PasswordResetPhase.submitting;

    return AuthScaffold(
      subtitle: 'Sign in to your Royal HRMS account',
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            BackToSignInLink(onPressed: _backToSignIn),
            const SizedBox(height: 20),
            Text('Reset your password', style: context.textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              "Enter your registered email and we'll send you a one-time code.",
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 20),
            LabeledTextField(
              label: 'Email',
              controller: _emailController,
              hintText: 'you@company.com',
              enabled: !isSubmitting,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.email],
              validator: Validators.email,
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
                  : const Text('Send OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
