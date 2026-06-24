import '../../../../core/network/api_client.dart';

abstract class SettingsRemoteDataSource {}

class SettingsRemoteDataSourceImpl implements SettingsRemoteDataSource {
  SettingsRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  ApiClient get apiClient => _apiClient;
}
