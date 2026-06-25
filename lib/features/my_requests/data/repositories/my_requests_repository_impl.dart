import '../../domain/repositories/my_requests_repository.dart';
import '../datasource/my_requests_remote_datasource.dart';

class MyRequestsRepositoryImpl implements MyRequestsRepository {
  MyRequestsRepositoryImpl(this._remoteDataSource);

  final MyRequestsRemoteDataSource _remoteDataSource;

  MyRequestsRemoteDataSource get remoteDataSource => _remoteDataSource;
}
