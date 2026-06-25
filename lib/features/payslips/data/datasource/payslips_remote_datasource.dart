import '../../../../core/network/api_client.dart';

abstract class PayslipsRemoteDataSource {}

class PayslipsRemoteDataSourceImpl implements PayslipsRemoteDataSource {
  PayslipsRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  ApiClient get apiClient => _apiClient;
}
