import '../../domain/repositories/reports_repository.dart';
import '../datasource/reports_remote_datasource.dart';

class ReportsRepositoryImpl implements ReportsRepository {
  ReportsRepositoryImpl(this._remoteDataSource);

  final ReportsRemoteDataSource _remoteDataSource;

  ReportsRemoteDataSource get remoteDataSource => _remoteDataSource;
}
