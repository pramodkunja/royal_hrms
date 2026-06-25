import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import 'auth_providers.dart';
import 'password_reset_state.dart';

/// Drives the multi-step forgot-password wizard (request OTP → verify
/// OTP → set new password). Holds the email/reset-token across steps so
/// pages don't need to thread that data through route params.
class PasswordResetController extends Notifier<PasswordResetState> {
  @override
  PasswordResetState build() => const PasswordResetState();

  /// Clears any state left over from a previous attempt. Call when
  /// entering the flow fresh (forgot-password request page).
  void reset() => state = const PasswordResetState();

  Future<bool> sendOtp({required String email}) async {
    state = state.copyWith(phase: PasswordResetPhase.submitting, failure: null);
    try {
      await ref
          .read(requestPasswordResetOtpUseCaseProvider)
          .execute(email: email);
      state = state.copyWith(phase: PasswordResetPhase.idle, email: email);
      return true;
    } on AppException catch (exception) {
      state = state.copyWith(
        phase: PasswordResetPhase.failure,
        failure: Failure.fromException(exception),
      );
      return false;
    }
  }

  Future<bool> verifyOtp({required String otp}) async {
    final email = state.email;
    if (email == null) return false;

    state = state.copyWith(phase: PasswordResetPhase.submitting, failure: null);
    try {
      final challenge = await ref
          .read(verifyPasswordResetOtpUseCaseProvider)
          .execute(email: email, otp: otp);
      state = state.copyWith(
        phase: PasswordResetPhase.idle,
        resetToken: challenge.resetToken,
      );
      return true;
    } on AppException catch (exception) {
      state = state.copyWith(
        phase: PasswordResetPhase.failure,
        failure: Failure.fromException(exception),
      );
      return false;
    }
  }

  Future<bool> resetPassword({required String newPassword}) async {
    final resetToken = state.resetToken;
    if (resetToken == null) return false;

    state = state.copyWith(phase: PasswordResetPhase.submitting, failure: null);
    try {
      await ref
          .read(resetPasswordUseCaseProvider)
          .execute(resetToken: resetToken, newPassword: newPassword);
      state = state.copyWith(phase: PasswordResetPhase.idle, isComplete: true);
      return true;
    } on AppException catch (exception) {
      state = state.copyWith(
        phase: PasswordResetPhase.failure,
        failure: Failure.fromException(exception),
      );
      return false;
    }
  }
}

final passwordResetControllerProvider =
    NotifierProvider<PasswordResetController, PasswordResetState>(
      PasswordResetController.new,
    );
