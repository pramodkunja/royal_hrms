import '../../domain/repositories/leave_repository.dart';
import '../datasource/leave_remote_datasource.dart';

class LeaveRepositoryImpl implements LeaveRepository {
  LeaveRepositoryImpl(this._remoteDataSource);

  final LeaveRemoteDataSource _remoteDataSource;

  LeaveRemoteDataSource get remoteDataSource => _remoteDataSource;
}
