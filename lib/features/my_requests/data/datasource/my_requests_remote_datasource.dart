import '../../../../core/network/api_client.dart';

abstract class MyRequestsRemoteDataSource {}

class MyRequestsRemoteDataSourceImpl implements MyRequestsRemoteDataSource {
  MyRequestsRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  ApiClient get apiClient => _apiClient;
}
