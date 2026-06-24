import '../../domain/repositories/attendance_repository.dart';
import '../datasource/attendance_remote_datasource.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  AttendanceRepositoryImpl(this._remoteDataSource);

  final AttendanceRemoteDataSource _remoteDataSource;

  AttendanceRemoteDataSource get remoteDataSource => _remoteDataSource;
}
