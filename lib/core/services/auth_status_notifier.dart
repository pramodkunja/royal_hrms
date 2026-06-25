import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/api_constants.dart';
import '../errors/exceptions.dart';
import '../network/api_client.dart';
import '../storage/token_storage_service.dart';
import '../storage/user_session_service.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

/// Cross-cutting auth state consulted by the router (for redirects) and
/// the network layer (to react to a 401 / session expiry). Real sign-in
/// and sign-out flows in the auth feature will drive this via
/// [setAuthenticated] / [setUnauthenticated].
class AuthStatusNotifier extends Notifier<AuthStatus> {
  @override
  AuthStatus build() => AuthStatus.unknown;

  Future<void> checkInitialStatus() async {
    final hasToken = await ref
        .read(tokenStorageServiceProvider)
        .hasAccessToken();
    state = hasToken ? AuthStatus.authenticated : AuthStatus.unauthenticated;
  }

  void setAuthenticated() => state = AuthStatus.authenticated;

  /// User-initiated sign-out: best-effort invalidates the refresh token
  /// server-side, then always clears the local session regardless of
  /// whether the network call succeeded.
  ///
  /// This calls [ApiClient] directly rather than going through the auth
  /// feature's repository — core must not depend on a feature, and
  /// token-lifecycle calls (this, and the refresh flow in
  /// [core/network/interceptors/auth_interceptor.dart]) are treated as
  /// core networking concerns for exactly that reason.
  Future<void> logout() async {
    final tokenStorageService = ref.read(tokenStorageServiceProvider);
    final refreshToken = await tokenStorageService.getRefreshToken();
    if (refreshToken != null) {
      try {
        await ref
            .read(apiClientProvider)
            .post<void>(
              ApiConstants.logoutEndpoint,
              data: {'refresh_token': refreshToken},
            );
      } on AppException {
        // Proceed with local logout regardless of server outcome.
      }
    }
    await setUnauthenticated();
  }

  Future<void> setUnauthenticated() async {
    await ref.read(tokenStorageServiceProvider).clearTokens();
    await ref.read(userSessionServiceProvider).clearSession();
    state = AuthStatus.unauthenticated;
    // Same reasoning as in LoginController.submit(): don't rely solely
    // on the state change to refresh dependents, in case this is called
    // twice in a row without an intervening sign-in.
    ref.invalidate(currentUserSessionProvider);
  }
}

final authStatusNotifierProvider =
    NotifierProvider<AuthStatusNotifier, AuthStatus>(AuthStatusNotifier.new);
