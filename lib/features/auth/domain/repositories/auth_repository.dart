import '../entities/auth_session.dart';
import '../entities/password_reset_challenge.dart';

abstract class AuthRepository {
  Future<AuthSession> login({required String email, required String password});

  Future<void> requestPasswordResetOtp({required String email});

  Future<PasswordResetChallenge> verifyPasswordResetOtp({
    required String email,
    required String otp,
  });

  Future<void> resetPassword({
    required String resetToken,
    required String newPassword,
  });
}
