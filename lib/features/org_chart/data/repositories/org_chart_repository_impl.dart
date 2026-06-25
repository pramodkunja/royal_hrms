import '../../domain/repositories/org_chart_repository.dart';
import '../datasource/org_chart_remote_datasource.dart';

class OrgChartRepositoryImpl implements OrgChartRepository {
  OrgChartRepositoryImpl(this._remoteDataSource);

  final OrgChartRemoteDataSource _remoteDataSource;

  OrgChartRemoteDataSource get remoteDataSource => _remoteDataSource;
}
