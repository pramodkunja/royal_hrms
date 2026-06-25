import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/storage_keys.dart';
import '../services/auth_status_notifier.dart';
import 'models/user_session_model.dart';
import 'secure_storage_service.dart';

/// Caches the signed-in user's profile/permissions locally so the app
/// can render session-aware UI (and resolve permission-based
/// navigation) without waiting on a network round trip.
class UserSessionService {
  UserSessionService(this._secureStorageService);

  final SecureStorageService _secureStorageService;

  Future<void> saveSession(UserSessionModel session) {
    return _secureStorageService.write(
      key: StorageKeys.userSession,
      value: jsonEncode(session.toJson()),
    );
  }

  Future<UserSessionModel?> getSession() async {
    final raw = await _secureStorageService.read(key: StorageKeys.userSession);
    if (raw == null) return null;
    return UserSessionModel.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  Future<Set<String>> getPermissions() async {
    final session = await getSession();
    return session?.permissions.toSet() ?? const {};
  }

  /// True if the session has at least one of [permissions] — pass an
  /// empty list to mean "any authenticated user".
  Future<bool> hasAnyPermission(Iterable<String> permissions) async {
    if (permissions.isEmpty) return true;
    final granted = await getPermissions();
    return permissions.any(granted.contains);
  }

  Future<void> clearSession() {
    return _secureStorageService.delete(key: StorageKeys.userSession);
  }
}

final userSessionServiceProvider = Provider<UserSessionService>((ref) {
  return UserSessionService(ref.watch(secureStorageServiceProvider));
});

/// The cached session, re-read whenever [AuthStatusNotifier]'s status
/// changes (sign-in populates it, sign-out clears it) so UI like
/// [AppNavDrawer]'s profile header stays in sync without manual refresh.
final currentUserSessionProvider = FutureProvider<UserSessionModel?>((ref) {
  ref.watch(authStatusNotifierProvider);
  return ref.watch(userSessionServiceProvider).getSession();
});
