import '../../../../core/network/api_client.dart';

abstract class ApprovalsRemoteDataSource {}

class ApprovalsRemoteDataSourceImpl implements ApprovalsRemoteDataSource {
  ApprovalsRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  ApiClient get apiClient => _apiClient;
}
