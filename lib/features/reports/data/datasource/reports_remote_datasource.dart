import '../../../../core/network/api_client.dart';

abstract class ReportsRemoteDataSource {}

class ReportsRemoteDataSourceImpl implements ReportsRemoteDataSource {
  ReportsRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  ApiClient get apiClient => _apiClient;
}
