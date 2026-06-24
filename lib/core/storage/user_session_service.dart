import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/enums.dart';
import '../constants/storage_keys.dart';
import 'models/user_session_model.dart';
import 'secure_storage_service.dart';

/// Caches the signed-in user's profile/role locally so the app can
/// render session-aware UI (and resolve role-based navigation) without
/// waiting on a network round trip.
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

  Future<UserRole?> getUserRole() async {
    final session = await getSession();
    return session?.role;
  }

  Future<void> clearSession() {
    return _secureStorageService.delete(key: StorageKeys.userSession);
  }
}

final userSessionServiceProvider = Provider<UserSessionService>((ref) {
  return UserSessionService(ref.watch(secureStorageServiceProvider));
});
