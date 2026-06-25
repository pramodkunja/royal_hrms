// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_overview.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WorkforceSummary {

 String get greetingName; String get dateLabel; int get candidatesInPipeline; int get birthdaysToday; int get totalWorkforce; int get pendingActions; int get activeInterviews; String get payrollAmountLabel;
/// Create a copy of WorkforceSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkforceSummaryCopyWith<WorkforceSummary> get copyWith => _$WorkforceSummaryCopyWithImpl<WorkforceSummary>(this as WorkforceSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkforceSummary&&(identical(other.greetingName, greetingName) || other.greetingName == greetingName)&&(identical(other.dateLabel, dateLabel) || other.dateLabel == dateLabel)&&(identical(other.candidatesInPipeline, candidatesInPipeline) || other.candidatesInPipeline == candidatesInPipeline)&&(identical(other.birthdaysToday, birthdaysToday) || other.birthdaysToday == birthdaysToday)&&(identical(other.totalWorkforce, totalWorkforce) || other.totalWorkforce == totalWorkforce)&&(identical(other.pendingActions, pendingActions) || other.pendingActions == pendingActions)&&(identical(other.activeInterviews, activeInterviews) || other.activeInterviews == activeInterviews)&&(identical(other.payrollAmountLabel, payrollAmountLabel) || other.payrollAmountLabel == payrollAmountLabel));
}


@override
int get hashCode => Object.hash(runtimeType,greetingName,dateLabel,candidatesInPipeline,birthdaysToday,totalWorkforce,pendingActions,activeInterviews,payrollAmountLabel);

@override
String toString() {
  return 'WorkforceSummary(greetingName: $greetingName, dateLabel: $dateLabel, candidatesInPipeline: $candidatesInPipeline, birthdaysToday: $birthdaysToday, totalWorkforce: $totalWorkforce, pendingActions: $pendingActions, activeInterviews: $activeInterviews, payrollAmountLabel: $payrollAmountLabel)';
}


}

/// @nodoc
abstract mixin class $WorkforceSummaryCopyWith<$Res>  {
  factory $WorkforceSummaryCopyWith(WorkforceSummary value, $Res Function(WorkforceSummary) _then) = _$WorkforceSummaryCopyWithImpl;
@useResult
$Res call({
 String greetingName, String dateLabel, int candidatesInPipeline, int birthdaysToday, int totalWorkforce, int pendingActions, int activeInterviews, String payrollAmountLabel
});




}
/// @nodoc
class _$WorkforceSummaryCopyWithImpl<$Res>
    implements $WorkforceSummaryCopyWith<$Res> {
  _$WorkforceSummaryCopyWithImpl(this._self, this._then);

  final WorkforceSummary _self;
  final $Res Function(WorkforceSummary) _then;

/// Create a copy of WorkforceSummary
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


/// Adds pattern-matching-related methods to [WorkforceSummary].
extension WorkforceSummaryPatterns on WorkforceSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkforceSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkforceSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkforceSummary value)  $default,){
final _that = this;
switch (_that) {
case _WorkforceSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkforceSummary value)?  $default,){
final _that = this;
switch (_that) {
case _WorkforceSummary() when $default != null:
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
case _WorkforceSummary() when $default != null:
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
case _WorkforceSummary():
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
case _WorkforceSummary() when $default != null:
return $default(_that.greetingName,_that.dateLabel,_that.candidatesInPipeline,_that.birthdaysToday,_that.totalWorkforce,_that.pendingActions,_that.activeInterviews,_that.payrollAmountLabel);case _:
  return null;

}
}

}

/// @nodoc


class _WorkforceSummary implements WorkforceSummary {
  const _WorkforceSummary({required this.greetingName, required this.dateLabel, required this.candidatesInPipeline, required this.birthdaysToday, required this.totalWorkforce, required this.pendingActions, required this.activeInterviews, required this.payrollAmountLabel});
  

@override final  String greetingName;
@override final  String dateLabel;
@override final  int candidatesInPipeline;
@override final  int birthdaysToday;
@override final  int totalWorkforce;
@override final  int pendingActions;
@override final  int activeInterviews;
@override final  String payrollAmountLabel;

/// Create a copy of WorkforceSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkforceSummaryCopyWith<_WorkforceSummary> get copyWith => __$WorkforceSummaryCopyWithImpl<_WorkforceSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkforceSummary&&(identical(other.greetingName, greetingName) || other.greetingName == greetingName)&&(identical(other.dateLabel, dateLabel) || other.dateLabel == dateLabel)&&(identical(other.candidatesInPipeline, candidatesInPipeline) || other.candidatesInPipeline == candidatesInPipeline)&&(identical(other.birthdaysToday, birthdaysToday) || other.birthdaysToday == birthdaysToday)&&(identical(other.totalWorkforce, totalWorkforce) || other.totalWorkforce == totalWorkforce)&&(identical(other.pendingActions, pendingActions) || other.pendingActions == pendingActions)&&(identical(other.activeInterviews, activeInterviews) || other.activeInterviews == activeInterviews)&&(identical(other.payrollAmountLabel, payrollAmountLabel) || other.payrollAmountLabel == payrollAmountLabel));
}


@override
int get hashCode => Object.hash(runtimeType,greetingName,dateLabel,candidatesInPipeline,birthdaysToday,totalWorkforce,pendingActions,activeInterviews,payrollAmountLabel);

@override
String toString() {
  return 'WorkforceSummary(greetingName: $greetingName, dateLabel: $dateLabel, candidatesInPipeline: $candidatesInPipeline, birthdaysToday: $birthdaysToday, totalWorkforce: $totalWorkforce, pendingActions: $pendingActions, activeInterviews: $activeInterviews, payrollAmountLabel: $payrollAmountLabel)';
}


}

/// @nodoc
abstract mixin class _$WorkforceSummaryCopyWith<$Res> implements $WorkforceSummaryCopyWith<$Res> {
  factory _$WorkforceSummaryCopyWith(_WorkforceSummary value, $Res Function(_WorkforceSummary) _then) = __$WorkforceSummaryCopyWithImpl;
@override @useResult
$Res call({
 String greetingName, String dateLabel, int candidatesInPipeline, int birthdaysToday, int totalWorkforce, int pendingActions, int activeInterviews, String payrollAmountLabel
});




}
/// @nodoc
class __$WorkforceSummaryCopyWithImpl<$Res>
    implements _$WorkforceSummaryCopyWith<$Res> {
  __$WorkforceSummaryCopyWithImpl(this._self, this._then);

  final _WorkforceSummary _self;
  final $Res Function(_WorkforceSummary) _then;

/// Create a copy of WorkforceSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? greetingName = null,Object? dateLabel = null,Object? candidatesInPipeline = null,Object? birthdaysToday = null,Object? totalWorkforce = null,Object? pendingActions = null,Object? activeInterviews = null,Object? payrollAmountLabel = null,}) {
  return _then(_WorkforceSummary(
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
mixin _$HiringTrendPoint {

 String get month; int get hires; int get exits;
/// Create a copy of HiringTrendPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HiringTrendPointCopyWith<HiringTrendPoint> get copyWith => _$HiringTrendPointCopyWithImpl<HiringTrendPoint>(this as HiringTrendPoint, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HiringTrendPoint&&(identical(other.month, month) || other.month == month)&&(identical(other.hires, hires) || other.hires == hires)&&(identical(other.exits, exits) || other.exits == exits));
}


@override
int get hashCode => Object.hash(runtimeType,month,hires,exits);

@override
String toString() {
  return 'HiringTrendPoint(month: $month, hires: $hires, exits: $exits)';
}


}

/// @nodoc
abstract mixin class $HiringTrendPointCopyWith<$Res>  {
  factory $HiringTrendPointCopyWith(HiringTrendPoint value, $Res Function(HiringTrendPoint) _then) = _$HiringTrendPointCopyWithImpl;
@useResult
$Res call({
 String month, int hires, int exits
});




}
/// @nodoc
class _$HiringTrendPointCopyWithImpl<$Res>
    implements $HiringTrendPointCopyWith<$Res> {
  _$HiringTrendPointCopyWithImpl(this._self, this._then);

  final HiringTrendPoint _self;
  final $Res Function(HiringTrendPoint) _then;

/// Create a copy of HiringTrendPoint
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


/// Adds pattern-matching-related methods to [HiringTrendPoint].
extension HiringTrendPointPatterns on HiringTrendPoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HiringTrendPoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HiringTrendPoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HiringTrendPoint value)  $default,){
final _that = this;
switch (_that) {
case _HiringTrendPoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HiringTrendPoint value)?  $default,){
final _that = this;
switch (_that) {
case _HiringTrendPoint() when $default != null:
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
case _HiringTrendPoint() when $default != null:
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
case _HiringTrendPoint():
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
case _HiringTrendPoint() when $default != null:
return $default(_that.month,_that.hires,_that.exits);case _:
  return null;

}
}

}

/// @nodoc


class _HiringTrendPoint implements HiringTrendPoint {
  const _HiringTrendPoint({required this.month, required this.hires, required this.exits});
  

@override final  String month;
@override final  int hires;
@override final  int exits;

/// Create a copy of HiringTrendPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HiringTrendPointCopyWith<_HiringTrendPoint> get copyWith => __$HiringTrendPointCopyWithImpl<_HiringTrendPoint>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HiringTrendPoint&&(identical(other.month, month) || other.month == month)&&(identical(other.hires, hires) || other.hires == hires)&&(identical(other.exits, exits) || other.exits == exits));
}


@override
int get hashCode => Object.hash(runtimeType,month,hires,exits);

@override
String toString() {
  return 'HiringTrendPoint(month: $month, hires: $hires, exits: $exits)';
}


}

/// @nodoc
abstract mixin class _$HiringTrendPointCopyWith<$Res> implements $HiringTrendPointCopyWith<$Res> {
  factory _$HiringTrendPointCopyWith(_HiringTrendPoint value, $Res Function(_HiringTrendPoint) _then) = __$HiringTrendPointCopyWithImpl;
@override @useResult
$Res call({
 String month, int hires, int exits
});




}
/// @nodoc
class __$HiringTrendPointCopyWithImpl<$Res>
    implements _$HiringTrendPointCopyWith<$Res> {
  __$HiringTrendPointCopyWithImpl(this._self, this._then);

  final _HiringTrendPoint _self;
  final $Res Function(_HiringTrendPoint) _then;

/// Create a copy of HiringTrendPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? month = null,Object? hires = null,Object? exits = null,}) {
  return _then(_HiringTrendPoint(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String,hires: null == hires ? _self.hires : hires // ignore: cast_nullable_to_non_nullable
as int,exits: null == exits ? _self.exits : exits // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$FunnelStage {

 String get label; int get count;
/// Create a copy of FunnelStage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FunnelStageCopyWith<FunnelStage> get copyWith => _$FunnelStageCopyWithImpl<FunnelStage>(this as FunnelStage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FunnelStage&&(identical(other.label, label) || other.label == label)&&(identical(other.count, count) || other.count == count));
}


@override
int get hashCode => Object.hash(runtimeType,label,count);

@override
String toString() {
  return 'FunnelStage(label: $label, count: $count)';
}


}

/// @nodoc
abstract mixin class $FunnelStageCopyWith<$Res>  {
  factory $FunnelStageCopyWith(FunnelStage value, $Res Function(FunnelStage) _then) = _$FunnelStageCopyWithImpl;
@useResult
$Res call({
 String label, int count
});




}
/// @nodoc
class _$FunnelStageCopyWithImpl<$Res>
    implements $FunnelStageCopyWith<$Res> {
  _$FunnelStageCopyWithImpl(this._self, this._then);

  final FunnelStage _self;
  final $Res Function(FunnelStage) _then;

/// Create a copy of FunnelStage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? count = null,}) {
  return _then(_self.copyWith(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [FunnelStage].
extension FunnelStagePatterns on FunnelStage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FunnelStage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FunnelStage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FunnelStage value)  $default,){
final _that = this;
switch (_that) {
case _FunnelStage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FunnelStage value)?  $default,){
final _that = this;
switch (_that) {
case _FunnelStage() when $default != null:
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
case _FunnelStage() when $default != null:
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
case _FunnelStage():
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
case _FunnelStage() when $default != null:
return $default(_that.label,_that.count);case _:
  return null;

}
}

}

/// @nodoc


class _FunnelStage implements FunnelStage {
  const _FunnelStage({required this.label, required this.count});
  

@override final  String label;
@override final  int count;

/// Create a copy of FunnelStage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FunnelStageCopyWith<_FunnelStage> get copyWith => __$FunnelStageCopyWithImpl<_FunnelStage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FunnelStage&&(identical(other.label, label) || other.label == label)&&(identical(other.count, count) || other.count == count));
}


@override
int get hashCode => Object.hash(runtimeType,label,count);

@override
String toString() {
  return 'FunnelStage(label: $label, count: $count)';
}


}

/// @nodoc
abstract mixin class _$FunnelStageCopyWith<$Res> implements $FunnelStageCopyWith<$Res> {
  factory _$FunnelStageCopyWith(_FunnelStage value, $Res Function(_FunnelStage) _then) = __$FunnelStageCopyWithImpl;
@override @useResult
$Res call({
 String label, int count
});




}
/// @nodoc
class __$FunnelStageCopyWithImpl<$Res>
    implements _$FunnelStageCopyWith<$Res> {
  __$FunnelStageCopyWithImpl(this._self, this._then);

  final _FunnelStage _self;
  final $Res Function(_FunnelStage) _then;

/// Create a copy of FunnelStage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? count = null,}) {
  return _then(_FunnelStage(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$BirthdayEntry {

 String get name; String get subtitle;
/// Create a copy of BirthdayEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BirthdayEntryCopyWith<BirthdayEntry> get copyWith => _$BirthdayEntryCopyWithImpl<BirthdayEntry>(this as BirthdayEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BirthdayEntry&&(identical(other.name, name) || other.name == name)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle));
}


@override
int get hashCode => Object.hash(runtimeType,name,subtitle);

@override
String toString() {
  return 'BirthdayEntry(name: $name, subtitle: $subtitle)';
}


}

/// @nodoc
abstract mixin class $BirthdayEntryCopyWith<$Res>  {
  factory $BirthdayEntryCopyWith(BirthdayEntry value, $Res Function(BirthdayEntry) _then) = _$BirthdayEntryCopyWithImpl;
@useResult
$Res call({
 String name, String subtitle
});




}
/// @nodoc
class _$BirthdayEntryCopyWithImpl<$Res>
    implements $BirthdayEntryCopyWith<$Res> {
  _$BirthdayEntryCopyWithImpl(this._self, this._then);

  final BirthdayEntry _self;
  final $Res Function(BirthdayEntry) _then;

/// Create a copy of BirthdayEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? subtitle = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BirthdayEntry].
extension BirthdayEntryPatterns on BirthdayEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BirthdayEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BirthdayEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BirthdayEntry value)  $default,){
final _that = this;
switch (_that) {
case _BirthdayEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BirthdayEntry value)?  $default,){
final _that = this;
switch (_that) {
case _BirthdayEntry() when $default != null:
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
case _BirthdayEntry() when $default != null:
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
case _BirthdayEntry():
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
case _BirthdayEntry() when $default != null:
return $default(_that.name,_that.subtitle);case _:
  return null;

}
}

}

/// @nodoc


class _BirthdayEntry implements BirthdayEntry {
  const _BirthdayEntry({required this.name, required this.subtitle});
  

@override final  String name;
@override final  String subtitle;

/// Create a copy of BirthdayEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BirthdayEntryCopyWith<_BirthdayEntry> get copyWith => __$BirthdayEntryCopyWithImpl<_BirthdayEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BirthdayEntry&&(identical(other.name, name) || other.name == name)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle));
}


@override
int get hashCode => Object.hash(runtimeType,name,subtitle);

@override
String toString() {
  return 'BirthdayEntry(name: $name, subtitle: $subtitle)';
}


}

/// @nodoc
abstract mixin class _$BirthdayEntryCopyWith<$Res> implements $BirthdayEntryCopyWith<$Res> {
  factory _$BirthdayEntryCopyWith(_BirthdayEntry value, $Res Function(_BirthdayEntry) _then) = __$BirthdayEntryCopyWithImpl;
@override @useResult
$Res call({
 String name, String subtitle
});




}
/// @nodoc
class __$BirthdayEntryCopyWithImpl<$Res>
    implements _$BirthdayEntryCopyWith<$Res> {
  __$BirthdayEntryCopyWithImpl(this._self, this._then);

  final _BirthdayEntry _self;
  final $Res Function(_BirthdayEntry) _then;

/// Create a copy of BirthdayEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? subtitle = null,}) {
  return _then(_BirthdayEntry(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$AnniversaryEntry {

 String get name; String get initials; String get detail; int get years;
/// Create a copy of AnniversaryEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnniversaryEntryCopyWith<AnniversaryEntry> get copyWith => _$AnniversaryEntryCopyWithImpl<AnniversaryEntry>(this as AnniversaryEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnniversaryEntry&&(identical(other.name, name) || other.name == name)&&(identical(other.initials, initials) || other.initials == initials)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.years, years) || other.years == years));
}


@override
int get hashCode => Object.hash(runtimeType,name,initials,detail,years);

@override
String toString() {
  return 'AnniversaryEntry(name: $name, initials: $initials, detail: $detail, years: $years)';
}


}

/// @nodoc
abstract mixin class $AnniversaryEntryCopyWith<$Res>  {
  factory $AnniversaryEntryCopyWith(AnniversaryEntry value, $Res Function(AnniversaryEntry) _then) = _$AnniversaryEntryCopyWithImpl;
@useResult
$Res call({
 String name, String initials, String detail, int years
});




}
/// @nodoc
class _$AnniversaryEntryCopyWithImpl<$Res>
    implements $AnniversaryEntryCopyWith<$Res> {
  _$AnniversaryEntryCopyWithImpl(this._self, this._then);

  final AnniversaryEntry _self;
  final $Res Function(AnniversaryEntry) _then;

/// Create a copy of AnniversaryEntry
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


/// Adds pattern-matching-related methods to [AnniversaryEntry].
extension AnniversaryEntryPatterns on AnniversaryEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AnniversaryEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AnniversaryEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AnniversaryEntry value)  $default,){
final _that = this;
switch (_that) {
case _AnniversaryEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AnniversaryEntry value)?  $default,){
final _that = this;
switch (_that) {
case _AnniversaryEntry() when $default != null:
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
case _AnniversaryEntry() when $default != null:
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
case _AnniversaryEntry():
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
case _AnniversaryEntry() when $default != null:
return $default(_that.name,_that.initials,_that.detail,_that.years);case _:
  return null;

}
}

}

/// @nodoc


class _AnniversaryEntry implements AnniversaryEntry {
  const _AnniversaryEntry({required this.name, required this.initials, required this.detail, required this.years});
  

@override final  String name;
@override final  String initials;
@override final  String detail;
@override final  int years;

/// Create a copy of AnniversaryEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnniversaryEntryCopyWith<_AnniversaryEntry> get copyWith => __$AnniversaryEntryCopyWithImpl<_AnniversaryEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnniversaryEntry&&(identical(other.name, name) || other.name == name)&&(identical(other.initials, initials) || other.initials == initials)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.years, years) || other.years == years));
}


@override
int get hashCode => Object.hash(runtimeType,name,initials,detail,years);

@override
String toString() {
  return 'AnniversaryEntry(name: $name, initials: $initials, detail: $detail, years: $years)';
}


}

/// @nodoc
abstract mixin class _$AnniversaryEntryCopyWith<$Res> implements $AnniversaryEntryCopyWith<$Res> {
  factory _$AnniversaryEntryCopyWith(_AnniversaryEntry value, $Res Function(_AnniversaryEntry) _then) = __$AnniversaryEntryCopyWithImpl;
@override @useResult
$Res call({
 String name, String initials, String detail, int years
});




}
/// @nodoc
class __$AnniversaryEntryCopyWithImpl<$Res>
    implements _$AnniversaryEntryCopyWith<$Res> {
  __$AnniversaryEntryCopyWithImpl(this._self, this._then);

  final _AnniversaryEntry _self;
  final $Res Function(_AnniversaryEntry) _then;

/// Create a copy of AnniversaryEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? initials = null,Object? detail = null,Object? years = null,}) {
  return _then(_AnniversaryEntry(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,initials: null == initials ? _self.initials : initials // ignore: cast_nullable_to_non_nullable
as String,detail: null == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String,years: null == years ? _self.years : years // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$HrActionItem {

 HrActionType get type; String get title; String get subtitle;
/// Create a copy of HrActionItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HrActionItemCopyWith<HrActionItem> get copyWith => _$HrActionItemCopyWithImpl<HrActionItem>(this as HrActionItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HrActionItem&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle));
}


@override
int get hashCode => Object.hash(runtimeType,type,title,subtitle);

@override
String toString() {
  return 'HrActionItem(type: $type, title: $title, subtitle: $subtitle)';
}


}

/// @nodoc
abstract mixin class $HrActionItemCopyWith<$Res>  {
  factory $HrActionItemCopyWith(HrActionItem value, $Res Function(HrActionItem) _then) = _$HrActionItemCopyWithImpl;
@useResult
$Res call({
 HrActionType type, String title, String subtitle
});




}
/// @nodoc
class _$HrActionItemCopyWithImpl<$Res>
    implements $HrActionItemCopyWith<$Res> {
  _$HrActionItemCopyWithImpl(this._self, this._then);

  final HrActionItem _self;
  final $Res Function(HrActionItem) _then;

/// Create a copy of HrActionItem
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


/// Adds pattern-matching-related methods to [HrActionItem].
extension HrActionItemPatterns on HrActionItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HrActionItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HrActionItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HrActionItem value)  $default,){
final _that = this;
switch (_that) {
case _HrActionItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HrActionItem value)?  $default,){
final _that = this;
switch (_that) {
case _HrActionItem() when $default != null:
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
case _HrActionItem() when $default != null:
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
case _HrActionItem():
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
case _HrActionItem() when $default != null:
return $default(_that.type,_that.title,_that.subtitle);case _:
  return null;

}
}

}

/// @nodoc


class _HrActionItem implements HrActionItem {
  const _HrActionItem({required this.type, required this.title, required this.subtitle});
  

@override final  HrActionType type;
@override final  String title;
@override final  String subtitle;

/// Create a copy of HrActionItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HrActionItemCopyWith<_HrActionItem> get copyWith => __$HrActionItemCopyWithImpl<_HrActionItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HrActionItem&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle));
}


@override
int get hashCode => Object.hash(runtimeType,type,title,subtitle);

@override
String toString() {
  return 'HrActionItem(type: $type, title: $title, subtitle: $subtitle)';
}


}

/// @nodoc
abstract mixin class _$HrActionItemCopyWith<$Res> implements $HrActionItemCopyWith<$Res> {
  factory _$HrActionItemCopyWith(_HrActionItem value, $Res Function(_HrActionItem) _then) = __$HrActionItemCopyWithImpl;
@override @useResult
$Res call({
 HrActionType type, String title, String subtitle
});




}
/// @nodoc
class __$HrActionItemCopyWithImpl<$Res>
    implements _$HrActionItemCopyWith<$Res> {
  __$HrActionItemCopyWithImpl(this._self, this._then);

  final _HrActionItem _self;
  final $Res Function(_HrActionItem) _then;

/// Create a copy of HrActionItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? title = null,Object? subtitle = null,}) {
  return _then(_HrActionItem(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as HrActionType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$DepartmentHeadcount {

 String get name; int get count;
/// Create a copy of DepartmentHeadcount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DepartmentHeadcountCopyWith<DepartmentHeadcount> get copyWith => _$DepartmentHeadcountCopyWithImpl<DepartmentHeadcount>(this as DepartmentHeadcount, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DepartmentHeadcount&&(identical(other.name, name) || other.name == name)&&(identical(other.count, count) || other.count == count));
}


@override
int get hashCode => Object.hash(runtimeType,name,count);

@override
String toString() {
  return 'DepartmentHeadcount(name: $name, count: $count)';
}


}

/// @nodoc
abstract mixin class $DepartmentHeadcountCopyWith<$Res>  {
  factory $DepartmentHeadcountCopyWith(DepartmentHeadcount value, $Res Function(DepartmentHeadcount) _then) = _$DepartmentHeadcountCopyWithImpl;
@useResult
$Res call({
 String name, int count
});




}
/// @nodoc
class _$DepartmentHeadcountCopyWithImpl<$Res>
    implements $DepartmentHeadcountCopyWith<$Res> {
  _$DepartmentHeadcountCopyWithImpl(this._self, this._then);

  final DepartmentHeadcount _self;
  final $Res Function(DepartmentHeadcount) _then;

/// Create a copy of DepartmentHeadcount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? count = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DepartmentHeadcount].
extension DepartmentHeadcountPatterns on DepartmentHeadcount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DepartmentHeadcount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DepartmentHeadcount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DepartmentHeadcount value)  $default,){
final _that = this;
switch (_that) {
case _DepartmentHeadcount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DepartmentHeadcount value)?  $default,){
final _that = this;
switch (_that) {
case _DepartmentHeadcount() when $default != null:
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
case _DepartmentHeadcount() when $default != null:
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
case _DepartmentHeadcount():
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
case _DepartmentHeadcount() when $default != null:
return $default(_that.name,_that.count);case _:
  return null;

}
}

}

/// @nodoc


class _DepartmentHeadcount implements DepartmentHeadcount {
  const _DepartmentHeadcount({required this.name, required this.count});
  

@override final  String name;
@override final  int count;

/// Create a copy of DepartmentHeadcount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DepartmentHeadcountCopyWith<_DepartmentHeadcount> get copyWith => __$DepartmentHeadcountCopyWithImpl<_DepartmentHeadcount>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DepartmentHeadcount&&(identical(other.name, name) || other.name == name)&&(identical(other.count, count) || other.count == count));
}


@override
int get hashCode => Object.hash(runtimeType,name,count);

@override
String toString() {
  return 'DepartmentHeadcount(name: $name, count: $count)';
}


}

/// @nodoc
abstract mixin class _$DepartmentHeadcountCopyWith<$Res> implements $DepartmentHeadcountCopyWith<$Res> {
  factory _$DepartmentHeadcountCopyWith(_DepartmentHeadcount value, $Res Function(_DepartmentHeadcount) _then) = __$DepartmentHeadcountCopyWithImpl;
@override @useResult
$Res call({
 String name, int count
});




}
/// @nodoc
class __$DepartmentHeadcountCopyWithImpl<$Res>
    implements _$DepartmentHeadcountCopyWith<$Res> {
  __$DepartmentHeadcountCopyWithImpl(this._self, this._then);

  final _DepartmentHeadcount _self;
  final $Res Function(_DepartmentHeadcount) _then;

/// Create a copy of DepartmentHeadcount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? count = null,}) {
  return _then(_DepartmentHeadcount(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$ActivityEntry {

 ActivityType get type; String get title; String get timeLabel;
/// Create a copy of ActivityEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityEntryCopyWith<ActivityEntry> get copyWith => _$ActivityEntryCopyWithImpl<ActivityEntry>(this as ActivityEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityEntry&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.timeLabel, timeLabel) || other.timeLabel == timeLabel));
}


@override
int get hashCode => Object.hash(runtimeType,type,title,timeLabel);

@override
String toString() {
  return 'ActivityEntry(type: $type, title: $title, timeLabel: $timeLabel)';
}


}

/// @nodoc
abstract mixin class $ActivityEntryCopyWith<$Res>  {
  factory $ActivityEntryCopyWith(ActivityEntry value, $Res Function(ActivityEntry) _then) = _$ActivityEntryCopyWithImpl;
@useResult
$Res call({
 ActivityType type, String title, String timeLabel
});




}
/// @nodoc
class _$ActivityEntryCopyWithImpl<$Res>
    implements $ActivityEntryCopyWith<$Res> {
  _$ActivityEntryCopyWithImpl(this._self, this._then);

  final ActivityEntry _self;
  final $Res Function(ActivityEntry) _then;

/// Create a copy of ActivityEntry
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


/// Adds pattern-matching-related methods to [ActivityEntry].
extension ActivityEntryPatterns on ActivityEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActivityEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActivityEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActivityEntry value)  $default,){
final _that = this;
switch (_that) {
case _ActivityEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActivityEntry value)?  $default,){
final _that = this;
switch (_that) {
case _ActivityEntry() when $default != null:
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
case _ActivityEntry() when $default != null:
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
case _ActivityEntry():
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
case _ActivityEntry() when $default != null:
return $default(_that.type,_that.title,_that.timeLabel);case _:
  return null;

}
}

}

/// @nodoc


class _ActivityEntry implements ActivityEntry {
  const _ActivityEntry({required this.type, required this.title, required this.timeLabel});
  

@override final  ActivityType type;
@override final  String title;
@override final  String timeLabel;

/// Create a copy of ActivityEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivityEntryCopyWith<_ActivityEntry> get copyWith => __$ActivityEntryCopyWithImpl<_ActivityEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivityEntry&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.timeLabel, timeLabel) || other.timeLabel == timeLabel));
}


@override
int get hashCode => Object.hash(runtimeType,type,title,timeLabel);

@override
String toString() {
  return 'ActivityEntry(type: $type, title: $title, timeLabel: $timeLabel)';
}


}

/// @nodoc
abstract mixin class _$ActivityEntryCopyWith<$Res> implements $ActivityEntryCopyWith<$Res> {
  factory _$ActivityEntryCopyWith(_ActivityEntry value, $Res Function(_ActivityEntry) _then) = __$ActivityEntryCopyWithImpl;
@override @useResult
$Res call({
 ActivityType type, String title, String timeLabel
});




}
/// @nodoc
class __$ActivityEntryCopyWithImpl<$Res>
    implements _$ActivityEntryCopyWith<$Res> {
  __$ActivityEntryCopyWithImpl(this._self, this._then);

  final _ActivityEntry _self;
  final $Res Function(_ActivityEntry) _then;

/// Create a copy of ActivityEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? title = null,Object? timeLabel = null,}) {
  return _then(_ActivityEntry(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ActivityType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,timeLabel: null == timeLabel ? _self.timeLabel : timeLabel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$DashboardOverview {

 WorkforceSummary get workforceSummary; List<HiringTrendPoint> get hiringTrend; List<FunnelStage> get recruitmentFunnel; List<BirthdayEntry> get todaysBirthdays; List<AnniversaryEntry> get workAnniversaries; List<HrActionItem> get hrActionQueue; List<DepartmentHeadcount> get departmentHeadcount; List<ActivityEntry> get liveActivity;
/// Create a copy of DashboardOverview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardOverviewCopyWith<DashboardOverview> get copyWith => _$DashboardOverviewCopyWithImpl<DashboardOverview>(this as DashboardOverview, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardOverview&&(identical(other.workforceSummary, workforceSummary) || other.workforceSummary == workforceSummary)&&const DeepCollectionEquality().equals(other.hiringTrend, hiringTrend)&&const DeepCollectionEquality().equals(other.recruitmentFunnel, recruitmentFunnel)&&const DeepCollectionEquality().equals(other.todaysBirthdays, todaysBirthdays)&&const DeepCollectionEquality().equals(other.workAnniversaries, workAnniversaries)&&const DeepCollectionEquality().equals(other.hrActionQueue, hrActionQueue)&&const DeepCollectionEquality().equals(other.departmentHeadcount, departmentHeadcount)&&const DeepCollectionEquality().equals(other.liveActivity, liveActivity));
}


@override
int get hashCode => Object.hash(runtimeType,workforceSummary,const DeepCollectionEquality().hash(hiringTrend),const DeepCollectionEquality().hash(recruitmentFunnel),const DeepCollectionEquality().hash(todaysBirthdays),const DeepCollectionEquality().hash(workAnniversaries),const DeepCollectionEquality().hash(hrActionQueue),const DeepCollectionEquality().hash(departmentHeadcount),const DeepCollectionEquality().hash(liveActivity));

@override
String toString() {
  return 'DashboardOverview(workforceSummary: $workforceSummary, hiringTrend: $hiringTrend, recruitmentFunnel: $recruitmentFunnel, todaysBirthdays: $todaysBirthdays, workAnniversaries: $workAnniversaries, hrActionQueue: $hrActionQueue, departmentHeadcount: $departmentHeadcount, liveActivity: $liveActivity)';
}


}

/// @nodoc
abstract mixin class $DashboardOverviewCopyWith<$Res>  {
  factory $DashboardOverviewCopyWith(DashboardOverview value, $Res Function(DashboardOverview) _then) = _$DashboardOverviewCopyWithImpl;
@useResult
$Res call({
 WorkforceSummary workforceSummary, List<HiringTrendPoint> hiringTrend, List<FunnelStage> recruitmentFunnel, List<BirthdayEntry> todaysBirthdays, List<AnniversaryEntry> workAnniversaries, List<HrActionItem> hrActionQueue, List<DepartmentHeadcount> departmentHeadcount, List<ActivityEntry> liveActivity
});


$WorkforceSummaryCopyWith<$Res> get workforceSummary;

}
/// @nodoc
class _$DashboardOverviewCopyWithImpl<$Res>
    implements $DashboardOverviewCopyWith<$Res> {
  _$DashboardOverviewCopyWithImpl(this._self, this._then);

  final DashboardOverview _self;
  final $Res Function(DashboardOverview) _then;

/// Create a copy of DashboardOverview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? workforceSummary = null,Object? hiringTrend = null,Object? recruitmentFunnel = null,Object? todaysBirthdays = null,Object? workAnniversaries = null,Object? hrActionQueue = null,Object? departmentHeadcount = null,Object? liveActivity = null,}) {
  return _then(_self.copyWith(
workforceSummary: null == workforceSummary ? _self.workforceSummary : workforceSummary // ignore: cast_nullable_to_non_nullable
as WorkforceSummary,hiringTrend: null == hiringTrend ? _self.hiringTrend : hiringTrend // ignore: cast_nullable_to_non_nullable
as List<HiringTrendPoint>,recruitmentFunnel: null == recruitmentFunnel ? _self.recruitmentFunnel : recruitmentFunnel // ignore: cast_nullable_to_non_nullable
as List<FunnelStage>,todaysBirthdays: null == todaysBirthdays ? _self.todaysBirthdays : todaysBirthdays // ignore: cast_nullable_to_non_nullable
as List<BirthdayEntry>,workAnniversaries: null == workAnniversaries ? _self.workAnniversaries : workAnniversaries // ignore: cast_nullable_to_non_nullable
as List<AnniversaryEntry>,hrActionQueue: null == hrActionQueue ? _self.hrActionQueue : hrActionQueue // ignore: cast_nullable_to_non_nullable
as List<HrActionItem>,departmentHeadcount: null == departmentHeadcount ? _self.departmentHeadcount : departmentHeadcount // ignore: cast_nullable_to_non_nullable
as List<DepartmentHeadcount>,liveActivity: null == liveActivity ? _self.liveActivity : liveActivity // ignore: cast_nullable_to_non_nullable
as List<ActivityEntry>,
  ));
}
/// Create a copy of DashboardOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WorkforceSummaryCopyWith<$Res> get workforceSummary {
  
  return $WorkforceSummaryCopyWith<$Res>(_self.workforceSummary, (value) {
    return _then(_self.copyWith(workforceSummary: value));
  });
}
}


/// Adds pattern-matching-related methods to [DashboardOverview].
extension DashboardOverviewPatterns on DashboardOverview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardOverview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardOverview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardOverview value)  $default,){
final _that = this;
switch (_that) {
case _DashboardOverview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardOverview value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardOverview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( WorkforceSummary workforceSummary,  List<HiringTrendPoint> hiringTrend,  List<FunnelStage> recruitmentFunnel,  List<BirthdayEntry> todaysBirthdays,  List<AnniversaryEntry> workAnniversaries,  List<HrActionItem> hrActionQueue,  List<DepartmentHeadcount> departmentHeadcount,  List<ActivityEntry> liveActivity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardOverview() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( WorkforceSummary workforceSummary,  List<HiringTrendPoint> hiringTrend,  List<FunnelStage> recruitmentFunnel,  List<BirthdayEntry> todaysBirthdays,  List<AnniversaryEntry> workAnniversaries,  List<HrActionItem> hrActionQueue,  List<DepartmentHeadcount> departmentHeadcount,  List<ActivityEntry> liveActivity)  $default,) {final _that = this;
switch (_that) {
case _DashboardOverview():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( WorkforceSummary workforceSummary,  List<HiringTrendPoint> hiringTrend,  List<FunnelStage> recruitmentFunnel,  List<BirthdayEntry> todaysBirthdays,  List<AnniversaryEntry> workAnniversaries,  List<HrActionItem> hrActionQueue,  List<DepartmentHeadcount> departmentHeadcount,  List<ActivityEntry> liveActivity)?  $default,) {final _that = this;
switch (_that) {
case _DashboardOverview() when $default != null:
return $default(_that.workforceSummary,_that.hiringTrend,_that.recruitmentFunnel,_that.todaysBirthdays,_that.workAnniversaries,_that.hrActionQueue,_that.departmentHeadcount,_that.liveActivity);case _:
  return null;

}
}

}

/// @nodoc


class _DashboardOverview implements DashboardOverview {
  const _DashboardOverview({required this.workforceSummary, required final  List<HiringTrendPoint> hiringTrend, required final  List<FunnelStage> recruitmentFunnel, required final  List<BirthdayEntry> todaysBirthdays, required final  List<AnniversaryEntry> workAnniversaries, required final  List<HrActionItem> hrActionQueue, required final  List<DepartmentHeadcount> departmentHeadcount, required final  List<ActivityEntry> liveActivity}): _hiringTrend = hiringTrend,_recruitmentFunnel = recruitmentFunnel,_todaysBirthdays = todaysBirthdays,_workAnniversaries = workAnniversaries,_hrActionQueue = hrActionQueue,_departmentHeadcount = departmentHeadcount,_liveActivity = liveActivity;
  

@override final  WorkforceSummary workforceSummary;
 final  List<HiringTrendPoint> _hiringTrend;
@override List<HiringTrendPoint> get hiringTrend {
  if (_hiringTrend is EqualUnmodifiableListView) return _hiringTrend;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hiringTrend);
}

 final  List<FunnelStage> _recruitmentFunnel;
@override List<FunnelStage> get recruitmentFunnel {
  if (_recruitmentFunnel is EqualUnmodifiableListView) return _recruitmentFunnel;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recruitmentFunnel);
}

 final  List<BirthdayEntry> _todaysBirthdays;
@override List<BirthdayEntry> get todaysBirthdays {
  if (_todaysBirthdays is EqualUnmodifiableListView) return _todaysBirthdays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_todaysBirthdays);
}

 final  List<AnniversaryEntry> _workAnniversaries;
@override List<AnniversaryEntry> get workAnniversaries {
  if (_workAnniversaries is EqualUnmodifiableListView) return _workAnniversaries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_workAnniversaries);
}

 final  List<HrActionItem> _hrActionQueue;
@override List<HrActionItem> get hrActionQueue {
  if (_hrActionQueue is EqualUnmodifiableListView) return _hrActionQueue;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hrActionQueue);
}

 final  List<DepartmentHeadcount> _departmentHeadcount;
@override List<DepartmentHeadcount> get departmentHeadcount {
  if (_departmentHeadcount is EqualUnmodifiableListView) return _departmentHeadcount;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_departmentHeadcount);
}

 final  List<ActivityEntry> _liveActivity;
@override List<ActivityEntry> get liveActivity {
  if (_liveActivity is EqualUnmodifiableListView) return _liveActivity;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_liveActivity);
}


/// Create a copy of DashboardOverview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardOverviewCopyWith<_DashboardOverview> get copyWith => __$DashboardOverviewCopyWithImpl<_DashboardOverview>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardOverview&&(identical(other.workforceSummary, workforceSummary) || other.workforceSummary == workforceSummary)&&const DeepCollectionEquality().equals(other._hiringTrend, _hiringTrend)&&const DeepCollectionEquality().equals(other._recruitmentFunnel, _recruitmentFunnel)&&const DeepCollectionEquality().equals(other._todaysBirthdays, _todaysBirthdays)&&const DeepCollectionEquality().equals(other._workAnniversaries, _workAnniversaries)&&const DeepCollectionEquality().equals(other._hrActionQueue, _hrActionQueue)&&const DeepCollectionEquality().equals(other._departmentHeadcount, _departmentHeadcount)&&const DeepCollectionEquality().equals(other._liveActivity, _liveActivity));
}


@override
int get hashCode => Object.hash(runtimeType,workforceSummary,const DeepCollectionEquality().hash(_hiringTrend),const DeepCollectionEquality().hash(_recruitmentFunnel),const DeepCollectionEquality().hash(_todaysBirthdays),const DeepCollectionEquality().hash(_workAnniversaries),const DeepCollectionEquality().hash(_hrActionQueue),const DeepCollectionEquality().hash(_departmentHeadcount),const DeepCollectionEquality().hash(_liveActivity));

@override
String toString() {
  return 'DashboardOverview(workforceSummary: $workforceSummary, hiringTrend: $hiringTrend, recruitmentFunnel: $recruitmentFunnel, todaysBirthdays: $todaysBirthdays, workAnniversaries: $workAnniversaries, hrActionQueue: $hrActionQueue, departmentHeadcount: $departmentHeadcount, liveActivity: $liveActivity)';
}


}

/// @nodoc
abstract mixin class _$DashboardOverviewCopyWith<$Res> implements $DashboardOverviewCopyWith<$Res> {
  factory _$DashboardOverviewCopyWith(_DashboardOverview value, $Res Function(_DashboardOverview) _then) = __$DashboardOverviewCopyWithImpl;
@override @useResult
$Res call({
 WorkforceSummary workforceSummary, List<HiringTrendPoint> hiringTrend, List<FunnelStage> recruitmentFunnel, List<BirthdayEntry> todaysBirthdays, List<AnniversaryEntry> workAnniversaries, List<HrActionItem> hrActionQueue, List<DepartmentHeadcount> departmentHeadcount, List<ActivityEntry> liveActivity
});


@override $WorkforceSummaryCopyWith<$Res> get workforceSummary;

}
/// @nodoc
class __$DashboardOverviewCopyWithImpl<$Res>
    implements _$DashboardOverviewCopyWith<$Res> {
  __$DashboardOverviewCopyWithImpl(this._self, this._then);

  final _DashboardOverview _self;
  final $Res Function(_DashboardOverview) _then;

/// Create a copy of DashboardOverview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? workforceSummary = null,Object? hiringTrend = null,Object? recruitmentFunnel = null,Object? todaysBirthdays = null,Object? workAnniversaries = null,Object? hrActionQueue = null,Object? departmentHeadcount = null,Object? liveActivity = null,}) {
  return _then(_DashboardOverview(
workforceSummary: null == workforceSummary ? _self.workforceSummary : workforceSummary // ignore: cast_nullable_to_non_nullable
as WorkforceSummary,hiringTrend: null == hiringTrend ? _self._hiringTrend : hiringTrend // ignore: cast_nullable_to_non_nullable
as List<HiringTrendPoint>,recruitmentFunnel: null == recruitmentFunnel ? _self._recruitmentFunnel : recruitmentFunnel // ignore: cast_nullable_to_non_nullable
as List<FunnelStage>,todaysBirthdays: null == todaysBirthdays ? _self._todaysBirthdays : todaysBirthdays // ignore: cast_nullable_to_non_nullable
as List<BirthdayEntry>,workAnniversaries: null == workAnniversaries ? _self._workAnniversaries : workAnniversaries // ignore: cast_nullable_to_non_nullable
as List<AnniversaryEntry>,hrActionQueue: null == hrActionQueue ? _self._hrActionQueue : hrActionQueue // ignore: cast_nullable_to_non_nullable
as List<HrActionItem>,departmentHeadcount: null == departmentHeadcount ? _self._departmentHeadcount : departmentHeadcount // ignore: cast_nullable_to_non_nullable
as List<DepartmentHeadcount>,liveActivity: null == liveActivity ? _self._liveActivity : liveActivity // ignore: cast_nullable_to_non_nullable
as List<ActivityEntry>,
  ));
}

/// Create a copy of DashboardOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WorkforceSummaryCopyWith<$Res> get workforceSummary {
  
  return $WorkforceSummaryCopyWith<$Res>(_self.workforceSummary, (value) {
    return _then(_self.copyWith(workforceSummary: value));
  });
}
}

// dart format on
