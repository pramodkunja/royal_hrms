import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

/// Single-purpose business operation: authenticate with the given
/// credentials and return the resulting session.
class LoginUseCase {
  const LoginUseCase(this._authRepository);

  final AuthRepository _authRepository;

  Future<AuthSession> execute({
    required String email,
    required String password,
  }) {
    return _authRepository.login(email: email.trim(), password: password);
  }
}
