import '../../../../core/network/api_client.dart';

abstract class MyProfileRemoteDataSource {}

class MyProfileRemoteDataSourceImpl implements MyProfileRemoteDataSource {
  MyProfileRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  ApiClient get apiClient => _apiClient;
}
