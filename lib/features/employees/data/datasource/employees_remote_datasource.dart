import '../../../../core/network/api_client.dart';

abstract class EmployeesRemoteDataSource {}

class EmployeesRemoteDataSourceImpl implements EmployeesRemoteDataSource {
  EmployeesRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  ApiClient get apiClient => _apiClient;
}
