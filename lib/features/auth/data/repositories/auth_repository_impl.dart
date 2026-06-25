import '../../domain/entities/auth_session.dart';
import '../../domain/entities/password_reset_challenge.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasource/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    final response = await _remoteDataSource.login(
      email: email,
      password: password,
    );
    return response.toEntity();
  }

  @override
  Future<void> requestPasswordResetOtp({required String email}) {
    return _remoteDataSource.requestPasswordResetOtp(email: email);
  }

  @override
  Future<PasswordResetChallenge> verifyPasswordResetOtp({
    required String email,
    required String otp,
  }) async {
    final model = await _remoteDataSource.verifyPasswordResetOtp(
      email: email,
      otp: otp,
    );
    return model.toEntity();
  }

  @override
  Future<void> resetPassword({
    required String resetToken,
    required String newPassword,
  }) {
    return _remoteDataSource.resetPassword(
      resetToken: resetToken,
      newPassword: newPassword,
    );
  }
}
