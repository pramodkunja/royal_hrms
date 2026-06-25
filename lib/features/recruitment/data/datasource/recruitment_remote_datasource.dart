import '../../../../core/network/api_client.dart';

abstract class RecruitmentRemoteDataSource {}

class RecruitmentRemoteDataSourceImpl implements RecruitmentRemoteDataSource {
  RecruitmentRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  ApiClient get apiClient => _apiClient;
}
