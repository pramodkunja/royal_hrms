import '../../../../core/network/api_client.dart';

abstract class BranchesRemoteDataSource {}

class BranchesRemoteDataSourceImpl implements BranchesRemoteDataSource {
  BranchesRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  ApiClient get apiClient => _apiClient;
}
