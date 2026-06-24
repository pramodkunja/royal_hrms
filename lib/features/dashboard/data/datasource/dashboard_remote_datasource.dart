import '../../../../core/network/api_client.dart';

abstract class DashboardRemoteDataSource {}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  DashboardRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  ApiClient get apiClient => _apiClient;
}
