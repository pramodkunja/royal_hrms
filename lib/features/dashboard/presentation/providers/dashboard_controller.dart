import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import 'dashboard_providers.dart';
import 'dashboard_state.dart';

/// Drives the dashboard screen: loads the overview via
/// [GetDashboardOverviewUseCase] and exposes it as [DashboardState] so
/// the UI can render loading/loaded/failure without touching the
/// repository or use case directly.
class DashboardController extends Notifier<DashboardState> {
  @override
  DashboardState build() => const DashboardState();

  Future<void> load() async {
    state = state.copyWith(status: DashboardStatus.loading);
    try {
      final overview = await ref
          .read(getDashboardOverviewUseCaseProvider)
          .execute();
      state = DashboardState(
        status: DashboardStatus.loaded,
        overview: overview,
      );
    } on AppException catch (exception) {
      state = DashboardState(
        status: DashboardStatus.failure,
        failure: Failure.fromException(exception),
      );
    }
  }
}

final dashboardControllerProvider =
    NotifierProvider<DashboardController, DashboardState>(
      DashboardController.new,
    );
