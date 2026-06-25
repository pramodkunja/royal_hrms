import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/dashboard_overview.dart';

part 'dashboard_state.freezed.dart';

enum DashboardStatus { initial, loading, loaded, failure }

@freezed
abstract class DashboardState with _$DashboardState {
  const factory DashboardState({
    @Default(DashboardStatus.initial) DashboardStatus status,
    DashboardOverview? overview,
    Failure? failure,
  }) = _DashboardState;
}
