import '../entities/dashboard_overview.dart';

abstract class DashboardRepository {
  Future<DashboardOverview> getDashboardOverview();
}
