import '../repositories/auth_repository.dart';

/// Single-purpose business operation: set a new password using the
/// reset token obtained from [VerifyPasswordResetOtpUseCase].
class ResetPasswordUseCase {
  const ResetPasswordUseCase(this._authRepository);

  final AuthRepository _authRepository;

  Future<void> execute({
    required String resetToken,
    required String newPassword,
  }) {
    return _authRepository.resetPassword(
      resetToken: resetToken,
      newPassword: newPassword,
    );
  }
}
