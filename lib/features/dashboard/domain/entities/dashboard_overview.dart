import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_overview.freezed.dart';

enum HrActionType { leave, separation, smtp, document }

enum ActivityType { onboarded, emailSent, interview, leaveApproved }

@freezed
abstract class WorkforceSummary with _$WorkforceSummary {
  const factory WorkforceSummary({
    required String greetingName,
    required String dateLabel,
    required int candidatesInPipeline,
    required int birthdaysToday,
    required int totalWorkforce,
    required int pendingActions,
    required int activeInterviews,
    required String payrollAmountLabel,
  }) = _WorkforceSummary;
}

@freezed
abstract class HiringTrendPoint with _$HiringTrendPoint {
  const factory HiringTrendPoint({
    required String month,
    required int hires,
    required int exits,
  }) = _HiringTrendPoint;
}

@freezed
abstract class FunnelStage with _$FunnelStage {
  const factory FunnelStage({required String label, required int count}) =
      _FunnelStage;
}

@freezed
abstract class BirthdayEntry with _$BirthdayEntry {
  const factory BirthdayEntry({
    required String name,
    required String subtitle,
  }) = _BirthdayEntry;
}

@freezed
abstract class AnniversaryEntry with _$AnniversaryEntry {
  const factory AnniversaryEntry({
    required String name,
    required String initials,
    required String detail,
    required int years,
  }) = _AnniversaryEntry;
}

@freezed
abstract class HrActionItem with _$HrActionItem {
  const factory HrActionItem({
    required HrActionType type,
    required String title,
    required String subtitle,
  }) = _HrActionItem;
}

@freezed
abstract class DepartmentHeadcount with _$DepartmentHeadcount {
  const factory DepartmentHeadcount({
    required String name,
    required int count,
  }) = _DepartmentHeadcount;
}

@freezed
abstract class ActivityEntry with _$ActivityEntry {
  const factory ActivityEntry({
    required ActivityType type,
    required String title,
    required String timeLabel,
  }) = _ActivityEntry;
}

@freezed
abstract class DashboardOverview with _$DashboardOverview {
  const factory DashboardOverview({
    required WorkforceSummary workforceSummary,
    required List<HiringTrendPoint> hiringTrend,
    required List<FunnelStage> recruitmentFunnel,
    required List<BirthdayEntry> todaysBirthdays,
    required List<AnniversaryEntry> workAnniversaries,
    required List<HrActionItem> hrActionQueue,
    required List<DepartmentHeadcount> departmentHeadcount,
    required List<ActivityEntry> liveActivity,
  }) = _DashboardOverview;
}
