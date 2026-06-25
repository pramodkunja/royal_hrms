import '../../../../core/network/api_client.dart';

abstract class AuditRemoteDataSource {}

class AuditRemoteDataSourceImpl implements AuditRemoteDataSource {
  AuditRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  ApiClient get apiClient => _apiClient;
}
