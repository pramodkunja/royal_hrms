import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/dashboard_overview.dart';

part 'dashboard_overview_model.freezed.dart';
part 'dashboard_overview_model.g.dart';

@freezed
abstract class WorkforceSummaryModel with _$WorkforceSummaryModel {
  const WorkforceSummaryModel._();

  const factory WorkforceSummaryModel({
    required String greetingName,
    required String dateLabel,
    required int candidatesInPipeline,
    required int birthdaysToday,
    required int totalWorkforce,
    required int pendingActions,
    required int activeInterviews,
    required String payrollAmountLabel,
  }) = _WorkforceSummaryModel;

  factory WorkforceSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$WorkforceSummaryModelFromJson(json);

  WorkforceSummary toEntity() => WorkforceSummary(
    greetingName: greetingName,
    dateLabel: dateLabel,
    candidatesInPipeline: candidatesInPipeline,
    birthdaysToday: birthdaysToday,
    totalWorkforce: totalWorkforce,
    pendingActions: pendingActions,
    activeInterviews: activeInterviews,
    payrollAmountLabel: payrollAmountLabel,
  );
}

@freezed
abstract class HiringTrendPointModel with _$HiringTrendPointModel {
  const HiringTrendPointModel._();

  const factory HiringTrendPointModel({
    required String month,
    required int hires,
    required int exits,
  }) = _HiringTrendPointModel;

  factory HiringTrendPointModel.fromJson(Map<String, dynamic> json) =>
      _$HiringTrendPointModelFromJson(json);

  HiringTrendPoint toEntity() =>
      HiringTrendPoint(month: month, hires: hires, exits: exits);
}

@freezed
abstract class FunnelStageModel with _$FunnelStageModel {
  const FunnelStageModel._();

  const factory FunnelStageModel({required String label, required int count}) =
      _FunnelStageModel;

  factory FunnelStageModel.fromJson(Map<String, dynamic> json) =>
      _$FunnelStageModelFromJson(json);

  FunnelStage toEntity() => FunnelStage(label: label, count: count);
}

@freezed
abstract class BirthdayEntryModel with _$BirthdayEntryModel {
  const BirthdayEntryModel._();

  const factory BirthdayEntryModel({
    required String name,
    required String subtitle,
  }) = _BirthdayEntryModel;

  factory BirthdayEntryModel.fromJson(Map<String, dynamic> json) =>
      _$BirthdayEntryModelFromJson(json);

  BirthdayEntry toEntity() => BirthdayEntry(name: name, subtitle: subtitle);
}

@freezed
abstract class AnniversaryEntryModel with _$AnniversaryEntryModel {
  const AnniversaryEntryModel._();

  const factory AnniversaryEntryModel({
    required String name,
    required String initials,
    required String detail,
    required int years,
  }) = _AnniversaryEntryModel;

  factory AnniversaryEntryModel.fromJson(Map<String, dynamic> json) =>
      _$AnniversaryEntryModelFromJson(json);

  AnniversaryEntry toEntity() => AnniversaryEntry(
    name: name,
    initials: initials,
    detail: detail,
    years: years,
  );
}

@freezed
abstract class HrActionItemModel with _$HrActionItemModel {
  const HrActionItemModel._();

  const factory HrActionItemModel({
    required HrActionType type,
    required String title,
    required String subtitle,
  }) = _HrActionItemModel;

  factory HrActionItemModel.fromJson(Map<String, dynamic> json) =>
      _$HrActionItemModelFromJson(json);

  HrActionItem toEntity() =>
      HrActionItem(type: type, title: title, subtitle: subtitle);
}

@freezed
abstract class DepartmentHeadcountModel with _$DepartmentHeadcountModel {
  const DepartmentHeadcountModel._();

  const factory DepartmentHeadcountModel({
    required String name,
    required int count,
  }) = _DepartmentHeadcountModel;

  factory DepartmentHeadcountModel.fromJson(Map<String, dynamic> json) =>
      _$DepartmentHeadcountModelFromJson(json);

  DepartmentHeadcount toEntity() =>
      DepartmentHeadcount(name: name, count: count);
}

@freezed
abstract class ActivityEntryModel with _$ActivityEntryModel {
  const ActivityEntryModel._();

  const factory ActivityEntryModel({
    required ActivityType type,
    required String title,
    required String timeLabel,
  }) = _ActivityEntryModel;

  factory ActivityEntryModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityEntryModelFromJson(json);

  ActivityEntry toEntity() =>
      ActivityEntry(type: type, title: title, timeLabel: timeLabel);
}

@freezed
abstract class DashboardOverviewModel with _$DashboardOverviewModel {
  const DashboardOverviewModel._();

  const factory DashboardOverviewModel({
    required WorkforceSummaryModel workforceSummary,
    required List<HiringTrendPointModel> hiringTrend,
    required List<FunnelStageModel> recruitmentFunnel,
    required List<BirthdayEntryModel> todaysBirthdays,
    required List<AnniversaryEntryModel> workAnniversaries,
    required List<HrActionItemModel> hrActionQueue,
    required List<DepartmentHeadcountModel> departmentHeadcount,
    required List<ActivityEntryModel> liveActivity,
  }) = _DashboardOverviewModel;

  factory DashboardOverviewModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardOverviewModelFromJson(json);

  DashboardOverview toEntity() => DashboardOverview(
    workforceSummary: workforceSummary.toEntity(),
    hiringTrend: hiringTrend.map((e) => e.toEntity()).toList(),
    recruitmentFunnel: recruitmentFunnel.map((e) => e.toEntity()).toList(),
    todaysBirthdays: todaysBirthdays.map((e) => e.toEntity()).toList(),
    workAnniversaries: workAnniversaries.map((e) => e.toEntity()).toList(),
    hrActionQueue: hrActionQueue.map((e) => e.toEntity()).toList(),
    departmentHeadcount: departmentHeadcount.map((e) => e.toEntity()).toList(),
    liveActivity: liveActivity.map((e) => e.toEntity()).toList(),
  );
}
