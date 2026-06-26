import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/api_constants.dart';
import '../errors/exceptions.dart';
import '../network/api_client.dart';
import '../storage/token_storage_service.dart';
import '../storage/user_session_service.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthStatusNotifier extends Notifier<AuthStatus> {
  @override
  AuthStatus build() => AuthStatus.unknown;

  /// Called from SplashPage: reads the local "logged in" flag. No network
  /// call — fast even offline. The real session validity is enforced by
  /// the first authenticated API call (401 → refresh → or expired).
  Future<void> checkInitialStatus() async {
    final loggedIn =
        await ref.read(tokenStorageServiceProvider).isLoggedIn();
    state = loggedIn ? AuthStatus.authenticated : AuthStatus.unauthenticated;
  }

  void setAuthenticated() => state = AuthStatus.authenticated;

  /// User-initiated sign-out: asks the server to invalidate the session
  /// cookie (best-effort), then always clears local state.
  Future<void> logout() async {
    try {
      // No body needed — the cookie jar / browser sends the refresh cookie.
      await ref
          .read(apiClientProvider)
          .post<void>(ApiConstants.logoutEndpoint);
    } on AppException {
      // Proceed with local logout regardless of server outcome.
    }
    await setUnauthenticated();
  }

  Future<void> setUnauthenticated() async {
    await ref.read(tokenStorageServiceProvider).clearLoggedIn();
    await ref.read(userSessionServiceProvider).clearSession();
    // Remove stale cookies from the jar so they are not sent on the
    // next login request (web: server clears via Set-Cookie Max-Age=0).
    if (!kIsWeb) {
      await ref.read(cookieJarProvider).deleteAll();
    }
    state = AuthStatus.unauthenticated;
    ref.invalidate(currentUserSessionProvider);
  }
}

final authStatusNotifierProvider =
    NotifierProvider<AuthStatusNotifier, AuthStatus>(AuthStatusNotifier.new);
