import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _kAccessToken = 'access_token';
const _kRefreshToken = 'refresh_token';

const _storage = FlutterSecureStorage();

Future<void> saveTokens(String access, String refresh) async {
  await Future.wait([
    _storage.write(key: _kAccessToken, value: access),
    _storage.write(key: _kRefreshToken, value: refresh),
  ]);
}

Future<String?> getAccessToken() => _storage.read(key: _kAccessToken);

Future<String?> getRefreshToken() => _storage.read(key: _kRefreshToken);

Future<void> clearTokens() async {
  await Future.wait([
    _storage.delete(key: _kAccessToken),
    _storage.delete(key: _kRefreshToken),
  ]);
}
