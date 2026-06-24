import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    final hasToken = await ref.read(tokenStorageServiceProvider).hasAccessToken();
    state = hasToken ? AuthStatus.authenticated : AuthStatus.unauthenticated;
  }

  void setAuthenticated() => state = AuthStatus.authenticated;

  Future<void> setUnauthenticated() async {
    await ref.read(tokenStorageServiceProvider).clearTokens();
    await ref.read(userSessionServiceProvider).clearSession();
    state = AuthStatus.unauthenticated;
  }
}

final authStatusNotifierProvider = NotifierProvider<AuthStatusNotifier, AuthStatus>(
  AuthStatusNotifier.new,
);
