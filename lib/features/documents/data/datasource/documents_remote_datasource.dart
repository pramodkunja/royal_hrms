import '../../../../core/network/api_client.dart';

abstract class DocumentsRemoteDataSource {}

class DocumentsRemoteDataSourceImpl implements DocumentsRemoteDataSource {
  DocumentsRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  ApiClient get apiClient => _apiClient;
}
