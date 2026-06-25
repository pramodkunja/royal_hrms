import '../../../../core/network/api_client.dart';

abstract class SeparationRemoteDataSource {}

class SeparationRemoteDataSourceImpl implements SeparationRemoteDataSource {
  SeparationRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  ApiClient get apiClient => _apiClient;
}
