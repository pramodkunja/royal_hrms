import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/services/auth_status_notifier.dart';
import '../../../../core/storage/models/user_session_model.dart';
import '../../../../core/storage/token_storage_service.dart';
import '../../../../core/storage/user_session_service.dart';
import 'auth_providers.dart';
import 'login_state.dart';

class LoginController extends Notifier<LoginState> {
  @override
  LoginState build() => const LoginState();

  Future<void> submit({required String email, required String password}) async {
    state = const LoginState(status: LoginStatus.submitting);

    try {
      // Tokens are now delivered as HttpOnly cookies by the server.
      // We only receive the user profile in the response body.
      final user = await ref
          .read(loginUseCaseProvider)
          .execute(email: email, password: password);

      await ref.read(userSessionServiceProvider).saveSession(
        UserSessionModel(
          userId: user.id,
          name: user.name,
          email: user.email,
          role: user.role,
          roleDisplay: user.roleDisplay,
          permissions: user.permissions,
        ),
      );

      // Persist a simple "logged in" flag used by the splash screen to
      // avoid a network call on every cold start.
      await ref.read(tokenStorageServiceProvider).setLoggedIn();

      ref.read(authStatusNotifierProvider.notifier).setAuthenticated();
      ref.invalidate(currentUserSessionProvider);
      state = const LoginState(status: LoginStatus.success);
    } on AppException catch (exception) {
      state = LoginState(
        status: LoginStatus.failure,
        failure: Failure.fromException(exception),
      );
    } catch (e) {
      state = LoginState(
        status: LoginStatus.failure,
        failure: Failure.unknown('Something went wrong. Please try again.'),
      );
    }
  }
}

final loginControllerProvider = NotifierProvider<LoginController, LoginState>(
  LoginController.new,
);
