import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/services/auth_status_notifier.dart';
import '../../../../core/storage/models/user_session_model.dart';
import '../../../../core/storage/token_storage_service.dart';
import '../../../../core/storage/user_session_service.dart';
import 'auth_providers.dart';
import 'login_state.dart';

/// Drives the login screen: validates nothing itself (the form already
/// validated input before calling [submit]) and orchestrates the
/// Domain → Data → session-persistence → auth-state sequence described
/// in the mandatory feature workflow.
class LoginController extends Notifier<LoginState> {
  @override
  LoginState build() => const LoginState();

  Future<void> submit({required String email, required String password}) async {
    state = const LoginState(status: LoginStatus.submitting);

    try {
      final session = await ref
          .read(loginUseCaseProvider)
          .execute(email: email, password: password);

      await ref
          .read(tokenStorageServiceProvider)
          .saveTokens(
            accessToken: session.accessToken,
            refreshToken: session.refreshToken,
          );

      await ref
          .read(userSessionServiceProvider)
          .saveSession(
            UserSessionModel(
              userId: session.user.id,
              name: session.user.name,
              email: session.user.email,
              role: session.user.role,
              roleDisplay: session.user.roleDisplay,
              permissions: session.user.permissions,
            ),
          );

      ref.read(authStatusNotifierProvider.notifier).setAuthenticated();
      state = const LoginState(status: LoginStatus.success);
    } on AppException catch (exception) {
      state = LoginState(
        status: LoginStatus.failure,
        failure: Failure.fromException(exception),
      );
    }
  }
}

final loginControllerProvider = NotifierProvider<LoginController, LoginState>(
  LoginController.new,
);
