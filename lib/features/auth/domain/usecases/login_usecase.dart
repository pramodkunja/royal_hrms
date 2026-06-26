import '../entities/auth_user.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  const LoginUseCase(this._authRepository);

  final AuthRepository _authRepository;

  Future<AuthUser> execute({
    required String email,
    required String password,
  }) {
    return _authRepository.login(email: email.trim(), password: password);
  }
}
