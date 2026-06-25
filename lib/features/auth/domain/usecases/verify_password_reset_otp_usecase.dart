import '../entities/password_reset_challenge.dart';
import '../repositories/auth_repository.dart';

/// Single-purpose business operation: exchange a one-time code for a
/// short-lived reset token authorizing the password change.
class VerifyPasswordResetOtpUseCase {
  const VerifyPasswordResetOtpUseCase(this._authRepository);

  final AuthRepository _authRepository;

  Future<PasswordResetChallenge> execute({
    required String email,
    required String otp,
  }) {
    return _authRepository.verifyPasswordResetOtp(
      email: email.trim(),
      otp: otp.trim(),
    );
  }
}
