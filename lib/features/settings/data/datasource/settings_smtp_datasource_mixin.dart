import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../models/smtp_config_model.dart';

mixin SmtpDataSourceMixin {
  ApiClient get apiClient;

  Map<String, dynamic> _extractModel(dynamic body) {
    if (body is Map<String, dynamic>) {
      if (body['data'] is Map<String, dynamic>) {
        return body['data'] as Map<String, dynamic>;
      }
      return body;
    }
    throw const UnknownException('Unexpected response format');
  }

  Future<List<SmtpConfigModel>> getSmtpConfigs() async {
    try {
      final response = await apiClient.get<dynamic>(
        ApiConstants.smtpConfigsEndpoint,
      );
      final raw = response.data;
      final List<dynamic> items;
      if (raw is List) {
        items = raw;
      } else if (raw is Map) {
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

  Future<SmtpConfigModel> createSmtpConfig(Map<String, dynamic> data) async {
    try {
      final response = await apiClient.post<dynamic>(
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

  Future<SmtpConfigModel> updateSmtpConfig(
    String id,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await apiClient.patch<dynamic>(
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

  Future<void> deleteSmtpConfig(String id) async {
    try {
      await apiClient.delete<dynamic>(
        '${ApiConstants.smtpConfigsEndpoint}$id/',
      );
    } on AppException {
      rethrow;
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }

  Future<void> setSmtpConfigActive(String id) async {
    try {
      await apiClient.post<dynamic>(
        '${ApiConstants.smtpConfigsEndpoint}$id/activate/',
      );
    } on AppException {
      rethrow;
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }

  Future<void> testSmtpConfig(String id) async {
    try {
      await apiClient.post<dynamic>(
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
