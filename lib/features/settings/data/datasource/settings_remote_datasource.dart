import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../models/smtp_config_model.dart';

abstract class SettingsRemoteDataSource {
  Future<List<SmtpConfigModel>> getSmtpConfigs();
  Future<SmtpConfigModel> createSmtpConfig(Map<String, dynamic> data);
  Future<SmtpConfigModel> updateSmtpConfig(String id, Map<String, dynamic> data);
  Future<void> deleteSmtpConfig(String id);
  Future<void> setSmtpConfigActive(String id);
  Future<void> testSmtpConfig(String id);
}

class SettingsRemoteDataSourceImpl implements SettingsRemoteDataSource {
  SettingsRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  // GET /settings/smtp/
  // Handles both plain list [{...}] and paginated {"count":N,"results":[...]}
  @override
  Future<List<SmtpConfigModel>> getSmtpConfigs() async {
    try {
      final response = await _apiClient.get<dynamic>(
        ApiConstants.smtpConfigsEndpoint,
      );
      final raw = response.data;
      final List<dynamic> items;
      if (raw is List) {
        items = raw;
      } else if (raw is Map) {
        // {"status":"success","data":[...]} envelope (project standard)
        if (raw['data'] is List) {
          items = raw['data'] as List<dynamic>;
        } else if (raw['results'] is List) {
          items = raw['results'] as List<dynamic>;
        } else {
          return [];
        }
      } else {
        return [];
      }
      return items
          .whereType<Map<String, dynamic>>()
          .map(SmtpConfigModel.fromJson)
          .toList();
    } on AppException {
      rethrow;
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }

  // POST /settings/smtp/
  @override
  Future<SmtpConfigModel> createSmtpConfig(Map<String, dynamic> data) async {
    try {
      final response = await _apiClient.post<dynamic>(
        ApiConstants.smtpConfigsEndpoint,
        data: data,
      );
      return SmtpConfigModel.fromJson(_extractModel(response.data));
    } on AppException {
      rethrow;
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }

  // PATCH /settings/smtp/<pk>/
  @override
  Future<SmtpConfigModel> updateSmtpConfig(
    String id,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _apiClient.patch<dynamic>(
        '${ApiConstants.smtpConfigsEndpoint}$id/',
        data: data,
      );
      return SmtpConfigModel.fromJson(_extractModel(response.data));
    } on AppException {
      rethrow;
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }

  // DELETE /settings/smtp/<pk>/
  @override
  Future<void> deleteSmtpConfig(String id) async {
    try {
      await _apiClient.delete<dynamic>(
        '${ApiConstants.smtpConfigsEndpoint}$id/',
      );
    } on AppException {
      rethrow;
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }

  // Extracts the config map from both plain and enveloped responses:
  // {"status":"success","data":{...}} or just {...}
  Map<String, dynamic> _extractModel(dynamic body) {
    if (body is Map<String, dynamic>) {
      if (body['data'] is Map<String, dynamic>) {
        return body['data'] as Map<String, dynamic>;
      }
      return body;
    }
    throw const UnknownException('Unexpected response format');
  }

  // POST /settings/smtp/<pk>/activate/
  // The activate endpoint returns a success message, not the full config.
  // We just fire-and-forget; the caller refreshes the list separately.
  @override
  Future<void> setSmtpConfigActive(String id) async {
    try {
      await _apiClient.post<dynamic>(
        '${ApiConstants.smtpConfigsEndpoint}$id/activate/',
      );
    } on AppException {
      rethrow;
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }

  // POST /settings/smtp/test/
  @override
  Future<void> testSmtpConfig(String id) async {
    try {
      await _apiClient.post<dynamic>(
        '${ApiConstants.smtpConfigsEndpoint}test/',
        data: {'smtp_id': id},
      );
    } on AppException {
      rethrow;
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }
}
