// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_overview_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WorkforceSummaryModel _$WorkforceSummaryModelFromJson(
  Map<String, dynamic> json,
) => _WorkforceSummaryModel(
  greetingName: json['greetingName'] as String,
  dateLabel: json['dateLabel'] as String,
  candidatesInPipeline: (json['candidatesInPipeline'] as num).toInt(),
  birthdaysToday: (json['birthdaysToday'] as num).toInt(),
  totalWorkforce: (json['totalWorkforce'] as num).toInt(),
  pendingActions: (json['pendingActions'] as num).toInt(),
  activeInterviews: (json['activeInterviews'] as num).toInt(),
  payrollAmountLabel: json['payrollAmountLabel'] as String,
);

Map<String, dynamic> _$WorkforceSummaryModelToJson(
  _WorkforceSummaryModel instance,
) => <String, dynamic>{
  'greetingName': instance.greetingName,
  'dateLabel': instance.dateLabel,
  'candidatesInPipeline': instance.candidatesInPipeline,
  'birthdaysToday': instance.birthdaysToday,
  'totalWorkforce': instance.totalWorkforce,
  'pendingActions': instance.pendingActions,
  'activeInterviews': instance.activeInterviews,
  'payrollAmountLabel': instance.payrollAmountLabel,
};

_HiringTrendPointModel _$HiringTrendPointModelFromJson(
  Map<String, dynamic> json,
) => _HiringTrendPointModel(
  month: json['month'] as String,
  hires: (json['hires'] as num).toInt(),
  exits: (json['exits'] as num).toInt(),
);

Map<String, dynamic> _$HiringTrendPointModelToJson(
  _HiringTrendPointModel instance,
) => <String, dynamic>{
  'month': instance.month,
  'hires': instance.hires,
  'exits': instance.exits,
};

_FunnelStageModel _$FunnelStageModelFromJson(Map<String, dynamic> json) =>
    _FunnelStageModel(
      label: json['label'] as String,
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$FunnelStageModelToJson(_FunnelStageModel instance) =>
    <String, dynamic>{'label': instance.label, 'count': instance.count};

_BirthdayEntryModel _$BirthdayEntryModelFromJson(Map<String, dynamic> json) =>
    _BirthdayEntryModel(
      name: json['name'] as String,
      subtitle: json['subtitle'] as String,
    );

Map<String, dynamic> _$BirthdayEntryModelToJson(_BirthdayEntryModel instance) =>
    <String, dynamic>{'name': instance.name, 'subtitle': instance.subtitle};

_AnniversaryEntryModel _$AnniversaryEntryModelFromJson(
  Map<String, dynamic> json,
) => _AnniversaryEntryModel(
  name: json['name'] as String,
  initials: json['initials'] as String,
  detail: json['detail'] as String,
  years: (json['years'] as num).toInt(),
);

Map<String, dynamic> _$AnniversaryEntryModelToJson(
  _AnniversaryEntryModel instance,
) => <String, dynamic>{
  'name': instance.name,
  'initials': instance.initials,
  'detail': instance.detail,
  'years': instance.years,
};

_HrActionItemModel _$HrActionItemModelFromJson(Map<String, dynamic> json) =>
    _HrActionItemModel(
      type: $enumDecode(_$HrActionTypeEnumMap, json['type']),
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
    );

Map<String, dynamic> _$HrActionItemModelToJson(_HrActionItemModel instance) =>
    <String, dynamic>{
      'type': _$HrActionTypeEnumMap[instance.type]!,
      'title': instance.title,
      'subtitle': instance.subtitle,
    };

const _$HrActionTypeEnumMap = {
  HrActionType.leave: 'leave',
  HrActionType.separation: 'separation',
  HrActionType.smtp: 'smtp',
  HrActionType.document: 'document',
};

_DepartmentHeadcountModel _$DepartmentHeadcountModelFromJson(
  Map<String, dynamic> json,
) => _DepartmentHeadcountModel(
  name: json['name'] as String,
  count: (json['count'] as num).toInt(),
);

Map<String, dynamic> _$DepartmentHeadcountModelToJson(
  _DepartmentHeadcountModel instance,
) => <String, dynamic>{'name': instance.name, 'count': instance.count};

_ActivityEntryModel _$ActivityEntryModelFromJson(Map<String, dynamic> json) =>
    _ActivityEntryModel(
      type: $enumDecode(_$ActivityTypeEnumMap, json['type']),
      title: json['title'] as String,
      timeLabel: json['timeLabel'] as String,
    );

Map<String, dynamic> _$ActivityEntryModelToJson(_ActivityEntryModel instance) =>
    <String, dynamic>{
      'type': _$ActivityTypeEnumMap[instance.type]!,
      'title': instance.title,
      'timeLabel': instance.timeLabel,
    };

const _$ActivityTypeEnumMap = {
  ActivityType.onboarded: 'onboarded',
  ActivityType.emailSent: 'emailSent',
  ActivityType.interview: 'interview',
  ActivityType.leaveApproved: 'leaveApproved',
};

_DashboardOverviewModel _$DashboardOverviewModelFromJson(
  Map<String, dynamic> json,
) => _DashboardOverviewModel(
  workforceSummary: WorkforceSummaryModel.fromJson(
    json['workforceSummary'] as Map<String, dynamic>,
  ),
  hiringTrend: (json['hiringTrend'] as List<dynamic>)
      .map((e) => HiringTrendPointModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  recruitmentFunnel: (json['recruitmentFunnel'] as List<dynamic>)
      .map((e) => FunnelStageModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  todaysBirthdays: (json['todaysBirthdays'] as List<dynamic>)
      .map((e) => BirthdayEntryModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  workAnniversaries: (json['workAnniversaries'] as List<dynamic>)
      .map((e) => AnniversaryEntryModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  hrActionQueue: (json['hrActionQueue'] as List<dynamic>)
      .map((e) => HrActionItemModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  departmentHeadcount: (json['departmentHeadcount'] as List<dynamic>)
      .map((e) => DepartmentHeadcountModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  liveActivity: (json['liveActivity'] as List<dynamic>)
      .map((e) => ActivityEntryModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$DashboardOverviewModelToJson(
  _DashboardOverviewModel instance,
) => <String, dynamic>{
  'workforceSummary': instance.workforceSummary,
  'hiringTrend': instance.hiringTrend,
  'recruitmentFunnel': instance.recruitmentFunnel,
  'todaysBirthdays': instance.todaysBirthdays,
  'workAnniversaries': instance.workAnniversaries,
  'hrActionQueue': instance.hrActionQueue,
  'departmentHeadcount': instance.departmentHeadcount,
  'liveActivity': instance.liveActivity,
};
