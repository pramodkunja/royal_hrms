import '../repositories/auth_repository.dart';

/// Single-purpose business operation: ask the backend to send a
/// one-time password-reset code to the given email.
class RequestPasswordResetOtpUseCase {
  const RequestPasswordResetOtpUseCase(this._authRepository);

  final AuthRepository _authRepository;

  Future<void> execute({required String email}) {
    return _authRepository.requestPasswordResetOtp(email: email.trim());
  }
}
