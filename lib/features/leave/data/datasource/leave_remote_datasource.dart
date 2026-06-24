import '../../../../core/network/api_client.dart';

abstract class LeaveRemoteDataSource {}

class LeaveRemoteDataSourceImpl implements LeaveRemoteDataSource {
  LeaveRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  ApiClient get apiClient => _apiClient;
}
