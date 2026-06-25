import '../../../../core/network/api_client.dart';

abstract class ReferralsRemoteDataSource {}

class ReferralsRemoteDataSourceImpl implements ReferralsRemoteDataSource {
  ReferralsRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  ApiClient get apiClient => _apiClient;
}
