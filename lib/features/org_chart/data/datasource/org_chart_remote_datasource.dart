import '../../../../core/network/api_client.dart';

abstract class OrgChartRemoteDataSource {}

class OrgChartRemoteDataSourceImpl implements OrgChartRemoteDataSource {
  OrgChartRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  ApiClient get apiClient => _apiClient;
}
