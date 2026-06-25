import '../../../../core/network/api_client.dart';

abstract class AnnouncementsRemoteDataSource {}

class AnnouncementsRemoteDataSourceImpl
    implements AnnouncementsRemoteDataSource {
  AnnouncementsRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  ApiClient get apiClient => _apiClient;
}
