import '../../../../core/network/api_client.dart';

abstract class AttendanceRemoteDataSource {}

class AttendanceRemoteDataSourceImpl implements AttendanceRemoteDataSource {
  AttendanceRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  ApiClient get apiClient => _apiClient;
}
