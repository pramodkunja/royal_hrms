// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'smtp_form_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SmtpFormState {

 SmtpFormStatus get status; Failure? get failure;
/// Create a copy of SmtpFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SmtpFormStateCopyWith<SmtpFormState> get copyWith => _$SmtpFormStateCopyWithImpl<SmtpFormState>(this as SmtpFormState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SmtpFormState&&(identical(other.status, status) || other.status == status)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,status,failure);

@override
String toString() {
  return 'SmtpFormState(status: $status, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $SmtpFormStateCopyWith<$Res>  {
  factory $SmtpFormStateCopyWith(SmtpFormState value, $Res Function(SmtpFormState) _then) = _$SmtpFormStateCopyWithImpl;
@useResult
$Res call({
 SmtpFormStatus status, Failure? failure
});


$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$SmtpFormStateCopyWithImpl<$Res>
    implements $SmtpFormStateCopyWith<$Res> {
  _$SmtpFormStateCopyWithImpl(this._self, this._then);

  final SmtpFormState _self;
  final $Res Function(SmtpFormState) _then;

/// Create a copy of SmtpFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? failure = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SmtpFormStatus,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of SmtpFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get failure {
    if (_self.failure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.failure!, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}


/// Adds pattern-matching-related methods to [SmtpFormState].
extension SmtpFormStatePatterns on SmtpFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SmtpFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SmtpFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SmtpFormState value)  $default,){
final _that = this;
switch (_that) {
case _SmtpFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SmtpFormState value)?  $default,){
final _that = this;
switch (_that) {
case _SmtpFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SmtpFormStatus status,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SmtpFormState() when $default != null:
return $default(_that.status,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SmtpFormStatus status,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _SmtpFormState():
return $default(_that.status,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SmtpFormStatus status,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _SmtpFormState() when $default != null:
return $default(_that.status,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _SmtpFormState implements SmtpFormState {
  const _SmtpFormState({this.status = SmtpFormStatus.initial, this.failure});
  

@override@JsonKey() final  SmtpFormStatus status;
@override final  Failure? failure;

/// Create a copy of SmtpFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SmtpFormStateCopyWith<_SmtpFormState> get copyWith => __$SmtpFormStateCopyWithImpl<_SmtpFormState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SmtpFormState&&(identical(other.status, status) || other.status == status)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,status,failure);

@override
String toString() {
  return 'SmtpFormState(status: $status, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$SmtpFormStateCopyWith<$Res> implements $SmtpFormStateCopyWith<$Res> {
  factory _$SmtpFormStateCopyWith(_SmtpFormState value, $Res Function(_SmtpFormState) _then) = __$SmtpFormStateCopyWithImpl;
@override @useResult
$Res call({
 SmtpFormStatus status, Failure? failure
});


@override $FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$SmtpFormStateCopyWithImpl<$Res>
    implements _$SmtpFormStateCopyWith<$Res> {
  __$SmtpFormStateCopyWithImpl(this._self, this._then);

  final _SmtpFormState _self;
  final $Res Function(_SmtpFormState) _then;

/// Create a copy of SmtpFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? failure = freezed,}) {
  return _then(_SmtpFormState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SmtpFormStatus,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of SmtpFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get failure {
    if (_self.failure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.failure!, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

// dart format on
