import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/storage_keys.dart';
import 'secure_storage_service.dart';

/// Tracks whether a user session is active. With cookie-based auth the
/// actual JWT tokens live in HttpOnly cookies managed by the browser or
/// the Dio cookie jar — this service only stores a simple boolean flag
/// so the splash screen can decide whether to start authenticated without
/// making a network call.
class TokenStorageService {
  TokenStorageService(this._secureStorageService);

  final SecureStorageService _secureStorageService;

  Future<void> setLoggedIn() {
    return _secureStorageService.write(
      key: StorageKeys.isLoggedIn,
      value: 'true',
    );
  }

  Future<bool> isLoggedIn() async {
    final value =
        await _secureStorageService.read(key: StorageKeys.isLoggedIn);
    return value == 'true';
  }

  Future<void> clearLoggedIn() {
    return _secureStorageService.delete(key: StorageKeys.isLoggedIn);
  }
}

final tokenStorageServiceProvider = Provider<TokenStorageService>((ref) {
  return TokenStorageService(ref.watch(secureStorageServiceProvider));
});
