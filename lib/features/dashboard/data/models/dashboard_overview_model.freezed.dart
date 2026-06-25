// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_overview_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WorkforceSummaryModel {

 String get greetingName; String get dateLabel; int get candidatesInPipeline; int get birthdaysToday; int get totalWorkforce; int get pendingActions; int get activeInterviews; String get payrollAmountLabel;
/// Create a copy of WorkforceSummaryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkforceSummaryModelCopyWith<WorkforceSummaryModel> get copyWith => _$WorkforceSummaryModelCopyWithImpl<WorkforceSummaryModel>(this as WorkforceSummaryModel, _$identity);

  /// Serializes this WorkforceSummaryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkforceSummaryModel&&(identical(other.greetingName, greetingName) || other.greetingName == greetingName)&&(identical(other.dateLabel, dateLabel) || other.dateLabel == dateLabel)&&(identical(other.candidatesInPipeline, candidatesInPipeline) || other.candidatesInPipeline == candidatesInPipeline)&&(identical(other.birthdaysToday, birthdaysToday) || other.birthdaysToday == birthdaysToday)&&(identical(other.totalWorkforce, totalWorkforce) || other.totalWorkforce == totalWorkforce)&&(identical(other.pendingActions, pendingActions) || other.pendingActions == pendingActions)&&(identical(other.activeInterviews, activeInterviews) || other.activeInterviews == activeInterviews)&&(identical(other.payrollAmountLabel, payrollAmountLabel) || other.payrollAmountLabel == payrollAmountLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,greetingName,dateLabel,candidatesInPipeline,birthdaysToday,totalWorkforce,pendingActions,activeInterviews,payrollAmountLabel);

@override
String toString() {
  return 'WorkforceSummaryModel(greetingName: $greetingName, dateLabel: $dateLabel, candidatesInPipeline: $candidatesInPipeline, birthdaysToday: $birthdaysToday, totalWorkforce: $totalWorkforce, pendingActions: $pendingActions, activeInterviews: $activeInterviews, payrollAmountLabel: $payrollAmountLabel)';
}


}

/// @nodoc
abstract mixin class $WorkforceSummaryModelCopyWith<$Res>  {
  factory $WorkforceSummaryModelCopyWith(WorkforceSummaryModel value, $Res Function(WorkforceSummaryModel) _then) = _$WorkforceSummaryModelCopyWithImpl;
@useResult
$Res call({
 String greetingName, String dateLabel, int candidatesInPipeline, int birthdaysToday, int totalWorkforce, int pendingActions, int activeInterviews, String payrollAmountLabel
});




}
/// @nodoc
class _$WorkforceSummaryModelCopyWithImpl<$Res>
    implements $WorkforceSummaryModelCopyWith<$Res> {
  _$WorkforceSummaryModelCopyWithImpl(this._self, this._then);

  final WorkforceSummaryModel _self;
  final $Res Function(WorkforceSummaryModel) _then;

/// Create a copy of WorkforceSummaryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? greetingName = null,Object? dateLabel = null,Object? candidatesInPipeline = null,Object? birthdaysToday = null,Object? totalWorkforce = null,Object? pendingActions = null,Object? activeInterviews = null,Object? payrollAmountLabel = null,}) {
  return _then(_self.copyWith(
greetingName: null == greetingName ? _self.greetingName : greetingName // ignore: cast_nullable_to_non_nullable
as String,dateLabel: null == dateLabel ? _self.dateLabel : dateLabel // ignore: cast_nullable_to_non_nullable
as String,candidatesInPipeline: null == candidatesInPipeline ? _self.candidatesInPipeline : candidatesInPipeline // ignore: cast_nullable_to_non_nullable
as int,birthdaysToday: null == birthdaysToday ? _self.birthdaysToday : birthdaysToday // ignore: cast_nullable_to_non_nullable
as int,totalWorkforce: null == totalWorkforce ? _self.totalWorkforce : totalWorkforce // ignore: cast_nullable_to_non_nullable
as int,pendingActions: null == pendingActions ? _self.pendingActions : pendingActions // ignore: cast_nullable_to_non_nullable
as int,activeInterviews: null == activeInterviews ? _self.activeInterviews : activeInterviews // ignore: cast_nullable_to_non_nullable
as int,payrollAmountLabel: null == payrollAmountLabel ? _self.payrollAmountLabel : payrollAmountLabel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkforceSummaryModel].
extension WorkforceSummaryModelPatterns on WorkforceSummaryModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkforceSummaryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkforceSummaryModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkforceSummaryModel value)  $default,){
final _that = this;
switch (_that) {
case _WorkforceSummaryModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkforceSummaryModel value)?  $default,){
final _that = this;
switch (_that) {
case _WorkforceSummaryModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String greetingName,  String dateLabel,  int candidatesInPipeline,  int birthdaysToday,  int totalWorkforce,  int pendingActions,  int activeInterviews,  String payrollAmountLabel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkforceSummaryModel() when $default != null:
return $default(_that.greetingName,_that.dateLabel,_that.candidatesInPipeline,_that.birthdaysToday,_that.totalWorkforce,_that.pendingActions,_that.activeInterviews,_that.payrollAmountLabel);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String greetingName,  String dateLabel,  int candidatesInPipeline,  int birthdaysToday,  int totalWorkforce,  int pendingActions,  int activeInterviews,  String payrollAmountLabel)  $default,) {final _that = this;
switch (_that) {
case _WorkforceSummaryModel():
return $default(_that.greetingName,_that.dateLabel,_that.candidatesInPipeline,_that.birthdaysToday,_that.totalWorkforce,_that.pendingActions,_that.activeInterviews,_that.payrollAmountLabel);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String greetingName,  String dateLabel,  int candidatesInPipeline,  int birthdaysToday,  int totalWorkforce,  int pendingActions,  int activeInterviews,  String payrollAmountLabel)?  $default,) {final _that = this;
switch (_that) {
case _WorkforceSummaryModel() when $default != null:
return $default(_that.greetingName,_that.dateLabel,_that.candidatesInPipeline,_that.birthdaysToday,_that.totalWorkforce,_that.pendingActions,_that.activeInterviews,_that.payrollAmountLabel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WorkforceSummaryModel extends WorkforceSummaryModel {
  const _WorkforceSummaryModel({required this.greetingName, required this.dateLabel, required this.candidatesInPipeline, required this.birthdaysToday, required this.totalWorkforce, required this.pendingActions, required this.activeInterviews, required this.payrollAmountLabel}): super._();
  factory _WorkforceSummaryModel.fromJson(Map<String, dynamic> json) => _$WorkforceSummaryModelFromJson(json);

@override final  String greetingName;
@override final  String dateLabel;
@override final  int candidatesInPipeline;
@override final  int birthdaysToday;
@override final  int totalWorkforce;
@override final  int pendingActions;
@override final  int activeInterviews;
@override final  String payrollAmountLabel;

/// Create a copy of WorkforceSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkforceSummaryModelCopyWith<_WorkforceSummaryModel> get copyWith => __$WorkforceSummaryModelCopyWithImpl<_WorkforceSummaryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WorkforceSummaryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkforceSummaryModel&&(identical(other.greetingName, greetingName) || other.greetingName == greetingName)&&(identical(other.dateLabel, dateLabel) || other.dateLabel == dateLabel)&&(identical(other.candidatesInPipeline, candidatesInPipeline) || other.candidatesInPipeline == candidatesInPipeline)&&(identical(other.birthdaysToday, birthdaysToday) || other.birthdaysToday == birthdaysToday)&&(identical(other.totalWorkforce, totalWorkforce) || other.totalWorkforce == totalWorkforce)&&(identical(other.pendingActions, pendingActions) || other.pendingActions == pendingActions)&&(identical(other.activeInterviews, activeInterviews) || other.activeInterviews == activeInterviews)&&(identical(other.payrollAmountLabel, payrollAmountLabel) || other.payrollAmountLabel == payrollAmountLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,greetingName,dateLabel,candidatesInPipeline,birthdaysToday,totalWorkforce,pendingActions,activeInterviews,payrollAmountLabel);

@override
String toString() {
  return 'WorkforceSummaryModel(greetingName: $greetingName, dateLabel: $dateLabel, candidatesInPipeline: $candidatesInPipeline, birthdaysToday: $birthdaysToday, totalWorkforce: $totalWorkforce, pendingActions: $pendingActions, activeInterviews: $activeInterviews, payrollAmountLabel: $payrollAmountLabel)';
}


}

/// @nodoc
abstract mixin class _$WorkforceSummaryModelCopyWith<$Res> implements $WorkforceSummaryModelCopyWith<$Res> {
  factory _$WorkforceSummaryModelCopyWith(_WorkforceSummaryModel value, $Res Function(_WorkforceSummaryModel) _then) = __$WorkforceSummaryModelCopyWithImpl;
@override @useResult
$Res call({
 String greetingName, String dateLabel, int candidatesInPipeline, int birthdaysToday, int totalWorkforce, int pendingActions, int activeInterviews, String payrollAmountLabel
});




}
/// @nodoc
class __$WorkforceSummaryModelCopyWithImpl<$Res>
    implements _$WorkforceSummaryModelCopyWith<$Res> {
  __$WorkforceSummaryModelCopyWithImpl(this._self, this._then);

  final _WorkforceSummaryModel _self;
  final $Res Function(_WorkforceSummaryModel) _then;

/// Create a copy of WorkforceSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? greetingName = null,Object? dateLabel = null,Object? candidatesInPipeline = null,Object? birthdaysToday = null,Object? totalWorkforce = null,Object? pendingActions = null,Object? activeInterviews = null,Object? payrollAmountLabel = null,}) {
  return _then(_WorkforceSummaryModel(
greetingName: null == greetingName ? _self.greetingName : greetingName // ignore: cast_nullable_to_non_nullable
as String,dateLabel: null == dateLabel ? _self.dateLabel : dateLabel // ignore: cast_nullable_to_non_nullable
as String,candidatesInPipeline: null == candidatesInPipeline ? _self.candidatesInPipeline : candidatesInPipeline // ignore: cast_nullable_to_non_nullable
as int,birthdaysToday: null == birthdaysToday ? _self.birthdaysToday : birthdaysToday // ignore: cast_nullable_to_non_nullable
as int,totalWorkforce: null == totalWorkforce ? _self.totalWorkforce : totalWorkforce // ignore: cast_nullable_to_non_nullable
as int,pendingActions: null == pendingActions ? _self.pendingActions : pendingActions // ignore: cast_nullable_to_non_nullable
as int,activeInterviews: null == activeInterviews ? _self.activeInterviews : activeInterviews // ignore: cast_nullable_to_non_nullable
as int,payrollAmountLabel: null == payrollAmountLabel ? _self.payrollAmountLabel : payrollAmountLabel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$HiringTrendPointModel {

 String get month; int get hires; int get exits;
/// Create a copy of HiringTrendPointModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HiringTrendPointModelCopyWith<HiringTrendPointModel> get copyWith => _$HiringTrendPointModelCopyWithImpl<HiringTrendPointModel>(this as HiringTrendPointModel, _$identity);

  /// Serializes this HiringTrendPointModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HiringTrendPointModel&&(identical(other.month, month) || other.month == month)&&(identical(other.hires, hires) || other.hires == hires)&&(identical(other.exits, exits) || other.exits == exits));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,month,hires,exits);

@override
String toString() {
  return 'HiringTrendPointModel(month: $month, hires: $hires, exits: $exits)';
}


}

/// @nodoc
abstract mixin class $HiringTrendPointModelCopyWith<$Res>  {
  factory $HiringTrendPointModelCopyWith(HiringTrendPointModel value, $Res Function(HiringTrendPointModel) _then) = _$HiringTrendPointModelCopyWithImpl;
@useResult
$Res call({
 String month, int hires, int exits
});




}
/// @nodoc
class _$HiringTrendPointModelCopyWithImpl<$Res>
    implements $HiringTrendPointModelCopyWith<$Res> {
  _$HiringTrendPointModelCopyWithImpl(this._self, this._then);

  final HiringTrendPointModel _self;
  final $Res Function(HiringTrendPointModel) _then;

/// Create a copy of HiringTrendPointModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? month = null,Object? hires = null,Object? exits = null,}) {
  return _then(_self.copyWith(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String,hires: null == hires ? _self.hires : hires // ignore: cast_nullable_to_non_nullable
as int,exits: null == exits ? _self.exits : exits // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [HiringTrendPointModel].
extension HiringTrendPointModelPatterns on HiringTrendPointModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HiringTrendPointModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HiringTrendPointModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HiringTrendPointModel value)  $default,){
final _that = this;
switch (_that) {
case _HiringTrendPointModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HiringTrendPointModel value)?  $default,){
final _that = this;
switch (_that) {
case _HiringTrendPointModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String month,  int hires,  int exits)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HiringTrendPointModel() when $default != null:
return $default(_that.month,_that.hires,_that.exits);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String month,  int hires,  int exits)  $default,) {final _that = this;
switch (_that) {
case _HiringTrendPointModel():
return $default(_that.month,_that.hires,_that.exits);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String month,  int hires,  int exits)?  $default,) {final _that = this;
switch (_that) {
case _HiringTrendPointModel() when $default != null:
return $default(_that.month,_that.hires,_that.exits);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HiringTrendPointModel extends HiringTrendPointModel {
  const _HiringTrendPointModel({required this.month, required this.hires, required this.exits}): super._();
  factory _HiringTrendPointModel.fromJson(Map<String, dynamic> json) => _$HiringTrendPointModelFromJson(json);

@override final  String month;
@override final  int hires;
@override final  int exits;

/// Create a copy of HiringTrendPointModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HiringTrendPointModelCopyWith<_HiringTrendPointModel> get copyWith => __$HiringTrendPointModelCopyWithImpl<_HiringTrendPointModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HiringTrendPointModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HiringTrendPointModel&&(identical(other.month, month) || other.month == month)&&(identical(other.hires, hires) || other.hires == hires)&&(identical(other.exits, exits) || other.exits == exits));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,month,hires,exits);

@override
String toString() {
  return 'HiringTrendPointModel(month: $month, hires: $hires, exits: $exits)';
}


}

/// @nodoc
abstract mixin class _$HiringTrendPointModelCopyWith<$Res> implements $HiringTrendPointModelCopyWith<$Res> {
  factory _$HiringTrendPointModelCopyWith(_HiringTrendPointModel value, $Res Function(_HiringTrendPointModel) _then) = __$HiringTrendPointModelCopyWithImpl;
@override @useResult
$Res call({
 String month, int hires, int exits
});




}
/// @nodoc
class __$HiringTrendPointModelCopyWithImpl<$Res>
    implements _$HiringTrendPointModelCopyWith<$Res> {
  __$HiringTrendPointModelCopyWithImpl(this._self, this._then);

  final _HiringTrendPointModel _self;
  final $Res Function(_HiringTrendPointModel) _then;

/// Create a copy of HiringTrendPointModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? month = null,Object? hires = null,Object? exits = null,}) {
  return _then(_HiringTrendPointModel(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String,hires: null == hires ? _self.hires : hires // ignore: cast_nullable_to_non_nullable
as int,exits: null == exits ? _self.exits : exits // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$FunnelStageModel {

 String get label; int get count;
/// Create a copy of FunnelStageModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FunnelStageModelCopyWith<FunnelStageModel> get copyWith => _$FunnelStageModelCopyWithImpl<FunnelStageModel>(this as FunnelStageModel, _$identity);

  /// Serializes this FunnelStageModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FunnelStageModel&&(identical(other.label, label) || other.label == label)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,count);

@override
String toString() {
  return 'FunnelStageModel(label: $label, count: $count)';
}


}

/// @nodoc
abstract mixin class $FunnelStageModelCopyWith<$Res>  {
  factory $FunnelStageModelCopyWith(FunnelStageModel value, $Res Function(FunnelStageModel) _then) = _$FunnelStageModelCopyWithImpl;
@useResult
$Res call({
 String label, int count
});




}
/// @nodoc
class _$FunnelStageModelCopyWithImpl<$Res>
    implements $FunnelStageModelCopyWith<$Res> {
  _$FunnelStageModelCopyWithImpl(this._self, this._then);

  final FunnelStageModel _self;
  final $Res Function(FunnelStageModel) _then;

/// Create a copy of FunnelStageModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? count = null,}) {
  return _then(_self.copyWith(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [FunnelStageModel].
extension FunnelStageModelPatterns on FunnelStageModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FunnelStageModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FunnelStageModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FunnelStageModel value)  $default,){
final _that = this;
switch (_that) {
case _FunnelStageModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FunnelStageModel value)?  $default,){
final _that = this;
switch (_that) {
case _FunnelStageModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FunnelStageModel() when $default != null:
return $default(_that.label,_that.count);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  int count)  $default,) {final _that = this;
switch (_that) {
case _FunnelStageModel():
return $default(_that.label,_that.count);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  int count)?  $default,) {final _that = this;
switch (_that) {
case _FunnelStageModel() when $default != null:
return $default(_that.label,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FunnelStageModel extends FunnelStageModel {
  const _FunnelStageModel({required this.label, required this.count}): super._();
  factory _FunnelStageModel.fromJson(Map<String, dynamic> json) => _$FunnelStageModelFromJson(json);

@override final  String label;
@override final  int count;

/// Create a copy of FunnelStageModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FunnelStageModelCopyWith<_FunnelStageModel> get copyWith => __$FunnelStageModelCopyWithImpl<_FunnelStageModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FunnelStageModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FunnelStageModel&&(identical(other.label, label) || other.label == label)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,count);

@override
String toString() {
  return 'FunnelStageModel(label: $label, count: $count)';
}


}

/// @nodoc
abstract mixin class _$FunnelStageModelCopyWith<$Res> implements $FunnelStageModelCopyWith<$Res> {
  factory _$FunnelStageModelCopyWith(_FunnelStageModel value, $Res Function(_FunnelStageModel) _then) = __$FunnelStageModelCopyWithImpl;
@override @useResult
$Res call({
 String label, int count
});




}
/// @nodoc
class __$FunnelStageModelCopyWithImpl<$Res>
    implements _$FunnelStageModelCopyWith<$Res> {
  __$FunnelStageModelCopyWithImpl(this._self, this._then);

  final _FunnelStageModel _self;
  final $Res Function(_FunnelStageModel) _then;

/// Create a copy of FunnelStageModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? count = null,}) {
  return _then(_FunnelStageModel(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$BirthdayEntryModel {

 String get name; String get subtitle;
/// Create a copy of BirthdayEntryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BirthdayEntryModelCopyWith<BirthdayEntryModel> get copyWith => _$BirthdayEntryModelCopyWithImpl<BirthdayEntryModel>(this as BirthdayEntryModel, _$identity);

  /// Serializes this BirthdayEntryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BirthdayEntryModel&&(identical(other.name, name) || other.name == name)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,subtitle);

@override
String toString() {
  return 'BirthdayEntryModel(name: $name, subtitle: $subtitle)';
}


}

/// @nodoc
abstract mixin class $BirthdayEntryModelCopyWith<$Res>  {
  factory $BirthdayEntryModelCopyWith(BirthdayEntryModel value, $Res Function(BirthdayEntryModel) _then) = _$BirthdayEntryModelCopyWithImpl;
@useResult
$Res call({
 String name, String subtitle
});




}
/// @nodoc
class _$BirthdayEntryModelCopyWithImpl<$Res>
    implements $BirthdayEntryModelCopyWith<$Res> {
  _$BirthdayEntryModelCopyWithImpl(this._self, this._then);

  final BirthdayEntryModel _self;
  final $Res Function(BirthdayEntryModel) _then;

/// Create a copy of BirthdayEntryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? subtitle = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BirthdayEntryModel].
extension BirthdayEntryModelPatterns on BirthdayEntryModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BirthdayEntryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BirthdayEntryModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BirthdayEntryModel value)  $default,){
final _that = this;
switch (_that) {
case _BirthdayEntryModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BirthdayEntryModel value)?  $default,){
final _that = this;
switch (_that) {
case _BirthdayEntryModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String subtitle)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BirthdayEntryModel() when $default != null:
return $default(_that.name,_that.subtitle);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String subtitle)  $default,) {final _that = this;
switch (_that) {
case _BirthdayEntryModel():
return $default(_that.name,_that.subtitle);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String subtitle)?  $default,) {final _that = this;
switch (_that) {
case _BirthdayEntryModel() when $default != null:
return $default(_that.name,_that.subtitle);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BirthdayEntryModel extends BirthdayEntryModel {
  const _BirthdayEntryModel({required this.name, required this.subtitle}): super._();
  factory _BirthdayEntryModel.fromJson(Map<String, dynamic> json) => _$BirthdayEntryModelFromJson(json);

@override final  String name;
@override final  String subtitle;

/// Create a copy of BirthdayEntryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BirthdayEntryModelCopyWith<_BirthdayEntryModel> get copyWith => __$BirthdayEntryModelCopyWithImpl<_BirthdayEntryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BirthdayEntryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BirthdayEntryModel&&(identical(other.name, name) || other.name == name)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,subtitle);

@override
String toString() {
  return 'BirthdayEntryModel(name: $name, subtitle: $subtitle)';
}


}

/// @nodoc
abstract mixin class _$BirthdayEntryModelCopyWith<$Res> implements $BirthdayEntryModelCopyWith<$Res> {
  factory _$BirthdayEntryModelCopyWith(_BirthdayEntryModel value, $Res Function(_BirthdayEntryModel) _then) = __$BirthdayEntryModelCopyWithImpl;
@override @useResult
$Res call({
 String name, String subtitle
});




}
/// @nodoc
class __$BirthdayEntryModelCopyWithImpl<$Res>
    implements _$BirthdayEntryModelCopyWith<$Res> {
  __$BirthdayEntryModelCopyWithImpl(this._self, this._then);

  final _BirthdayEntryModel _self;
  final $Res Function(_BirthdayEntryModel) _then;

/// Create a copy of BirthdayEntryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? subtitle = null,}) {
  return _then(_BirthdayEntryModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$AnniversaryEntryModel {

 String get name; String get initials; String get detail; int get years;
/// Create a copy of AnniversaryEntryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnniversaryEntryModelCopyWith<AnniversaryEntryModel> get copyWith => _$AnniversaryEntryModelCopyWithImpl<AnniversaryEntryModel>(this as AnniversaryEntryModel, _$identity);

  /// Serializes this AnniversaryEntryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnniversaryEntryModel&&(identical(other.name, name) || other.name == name)&&(identical(other.initials, initials) || other.initials == initials)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.years, years) || other.years == years));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,initials,detail,years);

@override
String toString() {
  return 'AnniversaryEntryModel(name: $name, initials: $initials, detail: $detail, years: $years)';
}


}

/// @nodoc
abstract mixin class $AnniversaryEntryModelCopyWith<$Res>  {
  factory $AnniversaryEntryModelCopyWith(AnniversaryEntryModel value, $Res Function(AnniversaryEntryModel) _then) = _$AnniversaryEntryModelCopyWithImpl;
@useResult
$Res call({
 String name, String initials, String detail, int years
});




}
/// @nodoc
class _$AnniversaryEntryModelCopyWithImpl<$Res>
    implements $AnniversaryEntryModelCopyWith<$Res> {
  _$AnniversaryEntryModelCopyWithImpl(this._self, this._then);

  final AnniversaryEntryModel _self;
  final $Res Function(AnniversaryEntryModel) _then;

/// Create a copy of AnniversaryEntryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? initials = null,Object? detail = null,Object? years = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,initials: null == initials ? _self.initials : initials // ignore: cast_nullable_to_non_nullable
as String,detail: null == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String,years: null == years ? _self.years : years // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AnniversaryEntryModel].
extension AnniversaryEntryModelPatterns on AnniversaryEntryModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AnniversaryEntryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AnniversaryEntryModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AnniversaryEntryModel value)  $default,){
final _that = this;
switch (_that) {
case _AnniversaryEntryModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AnniversaryEntryModel value)?  $default,){
final _that = this;
switch (_that) {
case _AnniversaryEntryModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String initials,  String detail,  int years)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnniversaryEntryModel() when $default != null:
return $default(_that.name,_that.initials,_that.detail,_that.years);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String initials,  String detail,  int years)  $default,) {final _that = this;
switch (_that) {
case _AnniversaryEntryModel():
return $default(_that.name,_that.initials,_that.detail,_that.years);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String initials,  String detail,  int years)?  $default,) {final _that = this;
switch (_that) {
case _AnniversaryEntryModel() when $default != null:
return $default(_that.name,_that.initials,_that.detail,_that.years);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AnniversaryEntryModel extends AnniversaryEntryModel {
  const _AnniversaryEntryModel({required this.name, required this.initials, required this.detail, required this.years}): super._();
  factory _AnniversaryEntryModel.fromJson(Map<String, dynamic> json) => _$AnniversaryEntryModelFromJson(json);

@override final  String name;
@override final  String initials;
@override final  String detail;
@override final  int years;

/// Create a copy of AnniversaryEntryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnniversaryEntryModelCopyWith<_AnniversaryEntryModel> get copyWith => __$AnniversaryEntryModelCopyWithImpl<_AnniversaryEntryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnniversaryEntryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnniversaryEntryModel&&(identical(other.name, name) || other.name == name)&&(identical(other.initials, initials) || other.initials == initials)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.years, years) || other.years == years));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,initials,detail,years);

@override
String toString() {
  return 'AnniversaryEntryModel(name: $name, initials: $initials, detail: $detail, years: $years)';
}


}

/// @nodoc
abstract mixin class _$AnniversaryEntryModelCopyWith<$Res> implements $AnniversaryEntryModelCopyWith<$Res> {
  factory _$AnniversaryEntryModelCopyWith(_AnniversaryEntryModel value, $Res Function(_AnniversaryEntryModel) _then) = __$AnniversaryEntryModelCopyWithImpl;
@override @useResult
$Res call({
 String name, String initials, String detail, int years
});




}
/// @nodoc
class __$AnniversaryEntryModelCopyWithImpl<$Res>
    implements _$AnniversaryEntryModelCopyWith<$Res> {
  __$AnniversaryEntryModelCopyWithImpl(this._self, this._then);

  final _AnniversaryEntryModel _self;
  final $Res Function(_AnniversaryEntryModel) _then;

/// Create a copy of AnniversaryEntryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? initials = null,Object? detail = null,Object? years = null,}) {
  return _then(_AnniversaryEntryModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,initials: null == initials ? _self.initials : initials // ignore: cast_nullable_to_non_nullable
as String,detail: null == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String,years: null == years ? _self.years : years // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$HrActionItemModel {

 HrActionType get type; String get title; String get subtitle;
/// Create a copy of HrActionItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HrActionItemModelCopyWith<HrActionItemModel> get copyWith => _$HrActionItemModelCopyWithImpl<HrActionItemModel>(this as HrActionItemModel, _$identity);

  /// Serializes this HrActionItemModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HrActionItemModel&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,title,subtitle);

@override
String toString() {
  return 'HrActionItemModel(type: $type, title: $title, subtitle: $subtitle)';
}


}

/// @nodoc
abstract mixin class $HrActionItemModelCopyWith<$Res>  {
  factory $HrActionItemModelCopyWith(HrActionItemModel value, $Res Function(HrActionItemModel) _then) = _$HrActionItemModelCopyWithImpl;
@useResult
$Res call({
 HrActionType type, String title, String subtitle
});




}
/// @nodoc
class _$HrActionItemModelCopyWithImpl<$Res>
    implements $HrActionItemModelCopyWith<$Res> {
  _$HrActionItemModelCopyWithImpl(this._self, this._then);

  final HrActionItemModel _self;
  final $Res Function(HrActionItemModel) _then;

/// Create a copy of HrActionItemModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? title = null,Object? subtitle = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as HrActionType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [HrActionItemModel].
extension HrActionItemModelPatterns on HrActionItemModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HrActionItemModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HrActionItemModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HrActionItemModel value)  $default,){
final _that = this;
switch (_that) {
case _HrActionItemModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HrActionItemModel value)?  $default,){
final _that = this;
switch (_that) {
case _HrActionItemModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( HrActionType type,  String title,  String subtitle)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HrActionItemModel() when $default != null:
return $default(_that.type,_that.title,_that.subtitle);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( HrActionType type,  String title,  String subtitle)  $default,) {final _that = this;
switch (_that) {
case _HrActionItemModel():
return $default(_that.type,_that.title,_that.subtitle);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( HrActionType type,  String title,  String subtitle)?  $default,) {final _that = this;
switch (_that) {
case _HrActionItemModel() when $default != null:
return $default(_that.type,_that.title,_that.subtitle);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HrActionItemModel extends HrActionItemModel {
  const _HrActionItemModel({required this.type, required this.title, required this.subtitle}): super._();
  factory _HrActionItemModel.fromJson(Map<String, dynamic> json) => _$HrActionItemModelFromJson(json);

@override final  HrActionType type;
@override final  String title;
@override final  String subtitle;

/// Create a copy of HrActionItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HrActionItemModelCopyWith<_HrActionItemModel> get copyWith => __$HrActionItemModelCopyWithImpl<_HrActionItemModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HrActionItemModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HrActionItemModel&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,title,subtitle);

@override
String toString() {
  return 'HrActionItemModel(type: $type, title: $title, subtitle: $subtitle)';
}


}

/// @nodoc
abstract mixin class _$HrActionItemModelCopyWith<$Res> implements $HrActionItemModelCopyWith<$Res> {
  factory _$HrActionItemModelCopyWith(_HrActionItemModel value, $Res Function(_HrActionItemModel) _then) = __$HrActionItemModelCopyWithImpl;
@override @useResult
$Res call({
 HrActionType type, String title, String subtitle
});




}
/// @nodoc
class __$HrActionItemModelCopyWithImpl<$Res>
    implements _$HrActionItemModelCopyWith<$Res> {
  __$HrActionItemModelCopyWithImpl(this._self, this._then);

  final _HrActionItemModel _self;
  final $Res Function(_HrActionItemModel) _then;

/// Create a copy of HrActionItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? title = null,Object? subtitle = null,}) {
  return _then(_HrActionItemModel(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as HrActionType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$DepartmentHeadcountModel {

 String get name; int get count;
/// Create a copy of DepartmentHeadcountModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DepartmentHeadcountModelCopyWith<DepartmentHeadcountModel> get copyWith => _$DepartmentHeadcountModelCopyWithImpl<DepartmentHeadcountModel>(this as DepartmentHeadcountModel, _$identity);

  /// Serializes this DepartmentHeadcountModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DepartmentHeadcountModel&&(identical(other.name, name) || other.name == name)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,count);

@override
String toString() {
  return 'DepartmentHeadcountModel(name: $name, count: $count)';
}


}

/// @nodoc
abstract mixin class $DepartmentHeadcountModelCopyWith<$Res>  {
  factory $DepartmentHeadcountModelCopyWith(DepartmentHeadcountModel value, $Res Function(DepartmentHeadcountModel) _then) = _$DepartmentHeadcountModelCopyWithImpl;
@useResult
$Res call({
 String name, int count
});




}
/// @nodoc
class _$DepartmentHeadcountModelCopyWithImpl<$Res>
    implements $DepartmentHeadcountModelCopyWith<$Res> {
  _$DepartmentHeadcountModelCopyWithImpl(this._self, this._then);

  final DepartmentHeadcountModel _self;
  final $Res Function(DepartmentHeadcountModel) _then;

/// Create a copy of DepartmentHeadcountModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? count = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DepartmentHeadcountModel].
extension DepartmentHeadcountModelPatterns on DepartmentHeadcountModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DepartmentHeadcountModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DepartmentHeadcountModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DepartmentHeadcountModel value)  $default,){
final _that = this;
switch (_that) {
case _DepartmentHeadcountModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DepartmentHeadcountModel value)?  $default,){
final _that = this;
switch (_that) {
case _DepartmentHeadcountModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DepartmentHeadcountModel() when $default != null:
return $default(_that.name,_that.count);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  int count)  $default,) {final _that = this;
switch (_that) {
case _DepartmentHeadcountModel():
return $default(_that.name,_that.count);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  int count)?  $default,) {final _that = this;
switch (_that) {
case _DepartmentHeadcountModel() when $default != null:
return $default(_that.name,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DepartmentHeadcountModel extends DepartmentHeadcountModel {
  const _DepartmentHeadcountModel({required this.name, required this.count}): super._();
  factory _DepartmentHeadcountModel.fromJson(Map<String, dynamic> json) => _$DepartmentHeadcountModelFromJson(json);

@override final  String name;
@override final  int count;

/// Create a copy of DepartmentHeadcountModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DepartmentHeadcountModelCopyWith<_DepartmentHeadcountModel> get copyWith => __$DepartmentHeadcountModelCopyWithImpl<_DepartmentHeadcountModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DepartmentHeadcountModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DepartmentHeadcountModel&&(identical(other.name, name) || other.name == name)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,count);

@override
String toString() {
  return 'DepartmentHeadcountModel(name: $name, count: $count)';
}


}

/// @nodoc
abstract mixin class _$DepartmentHeadcountModelCopyWith<$Res> implements $DepartmentHeadcountModelCopyWith<$Res> {
  factory _$DepartmentHeadcountModelCopyWith(_DepartmentHeadcountModel value, $Res Function(_DepartmentHeadcountModel) _then) = __$DepartmentHeadcountModelCopyWithImpl;
@override @useResult
$Res call({
 String name, int count
});




}
/// @nodoc
class __$DepartmentHeadcountModelCopyWithImpl<$Res>
    implements _$DepartmentHeadcountModelCopyWith<$Res> {
  __$DepartmentHeadcountModelCopyWithImpl(this._self, this._then);

  final _DepartmentHeadcountModel _self;
  final $Res Function(_DepartmentHeadcountModel) _then;

/// Create a copy of DepartmentHeadcountModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? count = null,}) {
  return _then(_DepartmentHeadcountModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ActivityEntryModel {

 ActivityType get type; String get title; String get timeLabel;
/// Create a copy of ActivityEntryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityEntryModelCopyWith<ActivityEntryModel> get copyWith => _$ActivityEntryModelCopyWithImpl<ActivityEntryModel>(this as ActivityEntryModel, _$identity);

  /// Serializes this ActivityEntryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityEntryModel&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.timeLabel, timeLabel) || other.timeLabel == timeLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,title,timeLabel);

@override
String toString() {
  return 'ActivityEntryModel(type: $type, title: $title, timeLabel: $timeLabel)';
}


}

/// @nodoc
abstract mixin class $ActivityEntryModelCopyWith<$Res>  {
  factory $ActivityEntryModelCopyWith(ActivityEntryModel value, $Res Function(ActivityEntryModel) _then) = _$ActivityEntryModelCopyWithImpl;
@useResult
$Res call({
 ActivityType type, String title, String timeLabel
});




}
/// @nodoc
class _$ActivityEntryModelCopyWithImpl<$Res>
    implements $ActivityEntryModelCopyWith<$Res> {
  _$ActivityEntryModelCopyWithImpl(this._self, this._then);

  final ActivityEntryModel _self;
  final $Res Function(ActivityEntryModel) _then;

/// Create a copy of ActivityEntryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? title = null,Object? timeLabel = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ActivityType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,timeLabel: null == timeLabel ? _self.timeLabel : timeLabel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ActivityEntryModel].
extension ActivityEntryModelPatterns on ActivityEntryModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActivityEntryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActivityEntryModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActivityEntryModel value)  $default,){
final _that = this;
switch (_that) {
case _ActivityEntryModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActivityEntryModel value)?  $default,){
final _that = this;
switch (_that) {
case _ActivityEntryModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ActivityType type,  String title,  String timeLabel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActivityEntryModel() when $default != null:
return $default(_that.type,_that.title,_that.timeLabel);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ActivityType type,  String title,  String timeLabel)  $default,) {final _that = this;
switch (_that) {
case _ActivityEntryModel():
return $default(_that.type,_that.title,_that.timeLabel);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ActivityType type,  String title,  String timeLabel)?  $default,) {final _that = this;
switch (_that) {
case _ActivityEntryModel() when $default != null:
return $default(_that.type,_that.title,_that.timeLabel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActivityEntryModel extends ActivityEntryModel {
  const _ActivityEntryModel({required this.type, required this.title, required this.timeLabel}): super._();
  factory _ActivityEntryModel.fromJson(Map<String, dynamic> json) => _$ActivityEntryModelFromJson(json);

@override final  ActivityType type;
@override final  String title;
@override final  String timeLabel;

/// Create a copy of ActivityEntryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivityEntryModelCopyWith<_ActivityEntryModel> get copyWith => __$ActivityEntryModelCopyWithImpl<_ActivityEntryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActivityEntryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivityEntryModel&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.timeLabel, timeLabel) || other.timeLabel == timeLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,title,timeLabel);

@override
String toString() {
  return 'ActivityEntryModel(type: $type, title: $title, timeLabel: $timeLabel)';
}


}

/// @nodoc
abstract mixin class _$ActivityEntryModelCopyWith<$Res> implements $ActivityEntryModelCopyWith<$Res> {
  factory _$ActivityEntryModelCopyWith(_ActivityEntryModel value, $Res Function(_ActivityEntryModel) _then) = __$ActivityEntryModelCopyWithImpl;
@override @useResult
$Res call({
 ActivityType type, String title, String timeLabel
});




}
/// @nodoc
class __$ActivityEntryModelCopyWithImpl<$Res>
    implements _$ActivityEntryModelCopyWith<$Res> {
  __$ActivityEntryModelCopyWithImpl(this._self, this._then);

  final _ActivityEntryModel _self;
  final $Res Function(_ActivityEntryModel) _then;

/// Create a copy of ActivityEntryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? title = null,Object? timeLabel = null,}) {
  return _then(_ActivityEntryModel(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ActivityType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,timeLabel: null == timeLabel ? _self.timeLabel : timeLabel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$DashboardOverviewModel {

 WorkforceSummaryModel get workforceSummary; List<HiringTrendPointModel> get hiringTrend; List<FunnelStageModel> get recruitmentFunnel; List<BirthdayEntryModel> get todaysBirthdays; List<AnniversaryEntryModel> get workAnniversaries; List<HrActionItemModel> get hrActionQueue; List<DepartmentHeadcountModel> get departmentHeadcount; List<ActivityEntryModel> get liveActivity;
/// Create a copy of DashboardOverviewModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardOverviewModelCopyWith<DashboardOverviewModel> get copyWith => _$DashboardOverviewModelCopyWithImpl<DashboardOverviewModel>(this as DashboardOverviewModel, _$identity);

  /// Serializes this DashboardOverviewModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardOverviewModel&&(identical(other.workforceSummary, workforceSummary) || other.workforceSummary == workforceSummary)&&const DeepCollectionEquality().equals(other.hiringTrend, hiringTrend)&&const DeepCollectionEquality().equals(other.recruitmentFunnel, recruitmentFunnel)&&const DeepCollectionEquality().equals(other.todaysBirthdays, todaysBirthdays)&&const DeepCollectionEquality().equals(other.workAnniversaries, workAnniversaries)&&const DeepCollectionEquality().equals(other.hrActionQueue, hrActionQueue)&&const DeepCollectionEquality().equals(other.departmentHeadcount, departmentHeadcount)&&const DeepCollectionEquality().equals(other.liveActivity, liveActivity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,workforceSummary,const DeepCollectionEquality().hash(hiringTrend),const DeepCollectionEquality().hash(recruitmentFunnel),const DeepCollectionEquality().hash(todaysBirthdays),const DeepCollectionEquality().hash(workAnniversaries),const DeepCollectionEquality().hash(hrActionQueue),const DeepCollectionEquality().hash(departmentHeadcount),const DeepCollectionEquality().hash(liveActivity));

@override
String toString() {
  return 'DashboardOverviewModel(workforceSummary: $workforceSummary, hiringTrend: $hiringTrend, recruitmentFunnel: $recruitmentFunnel, todaysBirthdays: $todaysBirthdays, workAnniversaries: $workAnniversaries, hrActionQueue: $hrActionQueue, departmentHeadcount: $departmentHeadcount, liveActivity: $liveActivity)';
}


}

/// @nodoc
abstract mixin class $DashboardOverviewModelCopyWith<$Res>  {
  factory $DashboardOverviewModelCopyWith(DashboardOverviewModel value, $Res Function(DashboardOverviewModel) _then) = _$DashboardOverviewModelCopyWithImpl;
@useResult
$Res call({
 WorkforceSummaryModel workforceSummary, List<HiringTrendPointModel> hiringTrend, List<FunnelStageModel> recruitmentFunnel, List<BirthdayEntryModel> todaysBirthdays, List<AnniversaryEntryModel> workAnniversaries, List<HrActionItemModel> hrActionQueue, List<DepartmentHeadcountModel> departmentHeadcount, List<ActivityEntryModel> liveActivity
});


$WorkforceSummaryModelCopyWith<$Res> get workforceSummary;

}
/// @nodoc
class _$DashboardOverviewModelCopyWithImpl<$Res>
    implements $DashboardOverviewModelCopyWith<$Res> {
  _$DashboardOverviewModelCopyWithImpl(this._self, this._then);

  final DashboardOverviewModel _self;
  final $Res Function(DashboardOverviewModel) _then;

/// Create a copy of DashboardOverviewModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? workforceSummary = null,Object? hiringTrend = null,Object? recruitmentFunnel = null,Object? todaysBirthdays = null,Object? workAnniversaries = null,Object? hrActionQueue = null,Object? departmentHeadcount = null,Object? liveActivity = null,}) {
  return _then(_self.copyWith(
workforceSummary: null == workforceSummary ? _self.workforceSummary : workforceSummary // ignore: cast_nullable_to_non_nullable
as WorkforceSummaryModel,hiringTrend: null == hiringTrend ? _self.hiringTrend : hiringTrend // ignore: cast_nullable_to_non_nullable
as List<HiringTrendPointModel>,recruitmentFunnel: null == recruitmentFunnel ? _self.recruitmentFunnel : recruitmentFunnel // ignore: cast_nullable_to_non_nullable
as List<FunnelStageModel>,todaysBirthdays: null == todaysBirthdays ? _self.todaysBirthdays : todaysBirthdays // ignore: cast_nullable_to_non_nullable
as List<BirthdayEntryModel>,workAnniversaries: null == workAnniversaries ? _self.workAnniversaries : workAnniversaries // ignore: cast_nullable_to_non_nullable
as List<AnniversaryEntryModel>,hrActionQueue: null == hrActionQueue ? _self.hrActionQueue : hrActionQueue // ignore: cast_nullable_to_non_nullable
as List<HrActionItemModel>,departmentHeadcount: null == departmentHeadcount ? _self.departmentHeadcount : departmentHeadcount // ignore: cast_nullable_to_non_nullable
as List<DepartmentHeadcountModel>,liveActivity: null == liveActivity ? _self.liveActivity : liveActivity // ignore: cast_nullable_to_non_nullable
as List<ActivityEntryModel>,
  ));
}
/// Create a copy of DashboardOverviewModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WorkforceSummaryModelCopyWith<$Res> get workforceSummary {
  
  return $WorkforceSummaryModelCopyWith<$Res>(_self.workforceSummary, (value) {
    return _then(_self.copyWith(workforceSummary: value));
  });
}
}


/// Adds pattern-matching-related methods to [DashboardOverviewModel].
extension DashboardOverviewModelPatterns on DashboardOverviewModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardOverviewModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardOverviewModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardOverviewModel value)  $default,){
final _that = this;
switch (_that) {
case _DashboardOverviewModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardOverviewModel value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardOverviewModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( WorkforceSummaryModel workforceSummary,  List<HiringTrendPointModel> hiringTrend,  List<FunnelStageModel> recruitmentFunnel,  List<BirthdayEntryModel> todaysBirthdays,  List<AnniversaryEntryModel> workAnniversaries,  List<HrActionItemModel> hrActionQueue,  List<DepartmentHeadcountModel> departmentHeadcount,  List<ActivityEntryModel> liveActivity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardOverviewModel() when $default != null:
return $default(_that.workforceSummary,_that.hiringTrend,_that.recruitmentFunnel,_that.todaysBirthdays,_that.workAnniversaries,_that.hrActionQueue,_that.departmentHeadcount,_that.liveActivity);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( WorkforceSummaryModel workforceSummary,  List<HiringTrendPointModel> hiringTrend,  List<FunnelStageModel> recruitmentFunnel,  List<BirthdayEntryModel> todaysBirthdays,  List<AnniversaryEntryModel> workAnniversaries,  List<HrActionItemModel> hrActionQueue,  List<DepartmentHeadcountModel> departmentHeadcount,  List<ActivityEntryModel> liveActivity)  $default,) {final _that = this;
switch (_that) {
case _DashboardOverviewModel():
return $default(_that.workforceSummary,_that.hiringTrend,_that.recruitmentFunnel,_that.todaysBirthdays,_that.workAnniversaries,_that.hrActionQueue,_that.departmentHeadcount,_that.liveActivity);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( WorkforceSummaryModel workforceSummary,  List<HiringTrendPointModel> hiringTrend,  List<FunnelStageModel> recruitmentFunnel,  List<BirthdayEntryModel> todaysBirthdays,  List<AnniversaryEntryModel> workAnniversaries,  List<HrActionItemModel> hrActionQueue,  List<DepartmentHeadcountModel> departmentHeadcount,  List<ActivityEntryModel> liveActivity)?  $default,) {final _that = this;
switch (_that) {
case _DashboardOverviewModel() when $default != null:
return $default(_that.workforceSummary,_that.hiringTrend,_that.recruitmentFunnel,_that.todaysBirthdays,_that.workAnniversaries,_that.hrActionQueue,_that.departmentHeadcount,_that.liveActivity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DashboardOverviewModel extends DashboardOverviewModel {
  const _DashboardOverviewModel({required this.workforceSummary, required final  List<HiringTrendPointModel> hiringTrend, required final  List<FunnelStageModel> recruitmentFunnel, required final  List<BirthdayEntryModel> todaysBirthdays, required final  List<AnniversaryEntryModel> workAnniversaries, required final  List<HrActionItemModel> hrActionQueue, required final  List<DepartmentHeadcountModel> departmentHeadcount, required final  List<ActivityEntryModel> liveActivity}): _hiringTrend = hiringTrend,_recruitmentFunnel = recruitmentFunnel,_todaysBirthdays = todaysBirthdays,_workAnniversaries = workAnniversaries,_hrActionQueue = hrActionQueue,_departmentHeadcount = departmentHeadcount,_liveActivity = liveActivity,super._();
  factory _DashboardOverviewModel.fromJson(Map<String, dynamic> json) => _$DashboardOverviewModelFromJson(json);

@override final  WorkforceSummaryModel workforceSummary;
 final  List<HiringTrendPointModel> _hiringTrend;
@override List<HiringTrendPointModel> get hiringTrend {
  if (_hiringTrend is EqualUnmodifiableListView) return _hiringTrend;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hiringTrend);
}

 final  List<FunnelStageModel> _recruitmentFunnel;
@override List<FunnelStageModel> get recruitmentFunnel {
  if (_recruitmentFunnel is EqualUnmodifiableListView) return _recruitmentFunnel;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recruitmentFunnel);
}

 final  List<BirthdayEntryModel> _todaysBirthdays;
@override List<BirthdayEntryModel> get todaysBirthdays {
  if (_todaysBirthdays is EqualUnmodifiableListView) return _todaysBirthdays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_todaysBirthdays);
}

 final  List<AnniversaryEntryModel> _workAnniversaries;
@override List<AnniversaryEntryModel> get workAnniversaries {
  if (_workAnniversaries is EqualUnmodifiableListView) return _workAnniversaries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_workAnniversaries);
}

 final  List<HrActionItemModel> _hrActionQueue;
@override List<HrActionItemModel> get hrActionQueue {
  if (_hrActionQueue is EqualUnmodifiableListView) return _hrActionQueue;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hrActionQueue);
}

 final  List<DepartmentHeadcountModel> _departmentHeadcount;
@override List<DepartmentHeadcountModel> get departmentHeadcount {
  if (_departmentHeadcount is EqualUnmodifiableListView) return _departmentHeadcount;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_departmentHeadcount);
}

 final  List<ActivityEntryModel> _liveActivity;
@override List<ActivityEntryModel> get liveActivity {
  if (_liveActivity is EqualUnmodifiableListView) return _liveActivity;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_liveActivity);
}


/// Create a copy of DashboardOverviewModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardOverviewModelCopyWith<_DashboardOverviewModel> get copyWith => __$DashboardOverviewModelCopyWithImpl<_DashboardOverviewModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DashboardOverviewModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardOverviewModel&&(identical(other.workforceSummary, workforceSummary) || other.workforceSummary == workforceSummary)&&const DeepCollectionEquality().equals(other._hiringTrend, _hiringTrend)&&const DeepCollectionEquality().equals(other._recruitmentFunnel, _recruitmentFunnel)&&const DeepCollectionEquality().equals(other._todaysBirthdays, _todaysBirthdays)&&const DeepCollectionEquality().equals(other._workAnniversaries, _workAnniversaries)&&const DeepCollectionEquality().equals(other._hrActionQueue, _hrActionQueue)&&const DeepCollectionEquality().equals(other._departmentHeadcount, _departmentHeadcount)&&const DeepCollectionEquality().equals(other._liveActivity, _liveActivity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,workforceSummary,const DeepCollectionEquality().hash(_hiringTrend),const DeepCollectionEquality().hash(_recruitmentFunnel),const DeepCollectionEquality().hash(_todaysBirthdays),const DeepCollectionEquality().hash(_workAnniversaries),const DeepCollectionEquality().hash(_hrActionQueue),const DeepCollectionEquality().hash(_departmentHeadcount),const DeepCollectionEquality().hash(_liveActivity));

@override
String toString() {
  return 'DashboardOverviewModel(workforceSummary: $workforceSummary, hiringTrend: $hiringTrend, recruitmentFunnel: $recruitmentFunnel, todaysBirthdays: $todaysBirthdays, workAnniversaries: $workAnniversaries, hrActionQueue: $hrActionQueue, departmentHeadcount: $departmentHeadcount, liveActivity: $liveActivity)';
}


}

/// @nodoc
abstract mixin class _$DashboardOverviewModelCopyWith<$Res> implements $DashboardOverviewModelCopyWith<$Res> {
  factory _$DashboardOverviewModelCopyWith(_DashboardOverviewModel value, $Res Function(_DashboardOverviewModel) _then) = __$DashboardOverviewModelCopyWithImpl;
@override @useResult
$Res call({
 WorkforceSummaryModel workforceSummary, List<HiringTrendPointModel> hiringTrend, List<FunnelStageModel> recruitmentFunnel, List<BirthdayEntryModel> todaysBirthdays, List<AnniversaryEntryModel> workAnniversaries, List<HrActionItemModel> hrActionQueue, List<DepartmentHeadcountModel> departmentHeadcount, List<ActivityEntryModel> liveActivity
});


@override $WorkforceSummaryModelCopyWith<$Res> get workforceSummary;

}
/// @nodoc
class __$DashboardOverviewModelCopyWithImpl<$Res>
    implements _$DashboardOverviewModelCopyWith<$Res> {
  __$DashboardOverviewModelCopyWithImpl(this._self, this._then);

  final _DashboardOverviewModel _self;
  final $Res Function(_DashboardOverviewModel) _then;

/// Create a copy of DashboardOverviewModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? workforceSummary = null,Object? hiringTrend = null,Object? recruitmentFunnel = null,Object? todaysBirthdays = null,Object? workAnniversaries = null,Object? hrActionQueue = null,Object? departmentHeadcount = null,Object? liveActivity = null,}) {
  return _then(_DashboardOverviewModel(
workforceSummary: null == workforceSummary ? _self.workforceSummary : workforceSummary // ignore: cast_nullable_to_non_nullable
as WorkforceSummaryModel,hiringTrend: null == hiringTrend ? _self._hiringTrend : hiringTrend // ignore: cast_nullable_to_non_nullable
as List<HiringTrendPointModel>,recruitmentFunnel: null == recruitmentFunnel ? _self._recruitmentFunnel : recruitmentFunnel // ignore: cast_nullable_to_non_nullable
as List<FunnelStageModel>,todaysBirthdays: null == todaysBirthdays ? _self._todaysBirthdays : todaysBirthdays // ignore: cast_nullable_to_non_nullable
as List<BirthdayEntryModel>,workAnniversaries: null == workAnniversaries ? _self._workAnniversaries : workAnniversaries // ignore: cast_nullable_to_non_nullable
as List<AnniversaryEntryModel>,hrActionQueue: null == hrActionQueue ? _self._hrActionQueue : hrActionQueue // ignore: cast_nullable_to_non_nullable
as List<HrActionItemModel>,departmentHeadcount: null == departmentHeadcount ? _self._departmentHeadcount : departmentHeadcount // ignore: cast_nullable_to_non_nullable
as List<DepartmentHeadcountModel>,liveActivity: null == liveActivity ? _self._liveActivity : liveActivity // ignore: cast_nullable_to_non_nullable
as List<ActivityEntryModel>,
  ));
}

/// Create a copy of DashboardOverviewModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WorkforceSummaryModelCopyWith<$Res> get workforceSummary {
  
  return $WorkforceSummaryModelCopyWith<$Res>(_self.workforceSummary, (value) {
    return _then(_self.copyWith(workforceSummary: value));
  });
}
}

// dart format on
