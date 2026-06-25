import '../entities/dashboard_overview.dart';
import '../repositories/dashboard_repository.dart';

/// Single-purpose business operation: load the full dashboard overview
/// (welcome stats, charts, funnels, queues, activity feed).
class GetDashboardOverviewUseCase {
  const GetDashboardOverviewUseCase(this._repository);

  final DashboardRepository _repository;

  Future<DashboardOverview> execute() => _repository.getDashboardOverview();
}
