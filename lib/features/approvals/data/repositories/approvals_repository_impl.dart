import '../../domain/repositories/approvals_repository.dart';
import '../datasource/approvals_remote_datasource.dart';

class ApprovalsRepositoryImpl implements ApprovalsRepository {
  ApprovalsRepositoryImpl(this._remoteDataSource);

  final ApprovalsRemoteDataSource _remoteDataSource;

  ApprovalsRemoteDataSource get remoteDataSource => _remoteDataSource;
}
