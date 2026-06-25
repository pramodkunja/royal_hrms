import '../../domain/repositories/separation_repository.dart';
import '../datasource/separation_remote_datasource.dart';

class SeparationRepositoryImpl implements SeparationRepository {
  SeparationRepositoryImpl(this._remoteDataSource);

  final SeparationRemoteDataSource _remoteDataSource;

  SeparationRemoteDataSource get remoteDataSource => _remoteDataSource;
}
