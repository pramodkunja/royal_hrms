import '../../domain/repositories/branches_repository.dart';
import '../datasource/branches_remote_datasource.dart';

class BranchesRepositoryImpl implements BranchesRepository {
  BranchesRepositoryImpl(this._remoteDataSource);

  final BranchesRemoteDataSource _remoteDataSource;

  BranchesRemoteDataSource get remoteDataSource => _remoteDataSource;
}
