import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/storage_keys.dart';
import 'secure_storage_service.dart';

/// Persists and retrieves the JWT access/refresh token pair from secure
/// storage. This is the single source of truth the network layer and
/// session-aware UI consult to know whether a token exists.
class TokenStorageService {
  TokenStorageService(this._secureStorageService);

  final SecureStorageService _secureStorageService;

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _secureStorageService.write(key: StorageKeys.accessToken, value: accessToken);
    await _secureStorageService.write(key: StorageKeys.refreshToken, value: refreshToken);
  }

  Future<String?> getAccessToken() {
    return _secureStorageService.read(key: StorageKeys.accessToken);
  }

  Future<String?> getRefreshToken() {
    return _secureStorageService.read(key: StorageKeys.refreshToken);
  }

  Future<bool> hasAccessToken() async => (await getAccessToken()) != null;

  Future<void> clearTokens() async {
    await _secureStorageService.delete(key: StorageKeys.accessToken);
    await _secureStorageService.delete(key: StorageKeys.refreshToken);
  }
}

final tokenStorageServiceProvider = Provider<TokenStorageService>((ref) {
  return TokenStorageService(ref.watch(secureStorageServiceProvider));
});
