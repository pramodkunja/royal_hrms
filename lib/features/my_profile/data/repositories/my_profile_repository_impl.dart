import '../../domain/repositories/my_profile_repository.dart';
import '../datasource/my_profile_remote_datasource.dart';

class MyProfileRepositoryImpl implements MyProfileRepository {
  MyProfileRepositoryImpl(this._remoteDataSource);

  final MyProfileRemoteDataSource _remoteDataSource;

  MyProfileRemoteDataSource get remoteDataSource => _remoteDataSource;
}
