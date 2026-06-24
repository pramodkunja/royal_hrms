import '../../../../core/network/api_client.dart';

abstract class PayrollRemoteDataSource {}

class PayrollRemoteDataSourceImpl implements PayrollRemoteDataSource {
  PayrollRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  ApiClient get apiClient => _apiClient;
}
