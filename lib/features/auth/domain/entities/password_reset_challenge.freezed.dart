// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'password_reset_challenge.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PasswordResetChallenge {

 String get email; String get resetToken;
/// Create a copy of PasswordResetChallenge
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PasswordResetChallengeCopyWith<PasswordResetChallenge> get copyWith => _$PasswordResetChallengeCopyWithImpl<PasswordResetChallenge>(this as PasswordResetChallenge, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PasswordResetChallenge&&(identical(other.email, email) || other.email == email)&&(identical(other.resetToken, resetToken) || other.resetToken == resetToken));
}


@override
int get hashCode => Object.hash(runtimeType,email,resetToken);

@override
String toString() {
  return 'PasswordResetChallenge(email: $email, resetToken: $resetToken)';
}


}

/// @nodoc
abstract mixin class $PasswordResetChallengeCopyWith<$Res>  {
  factory $PasswordResetChallengeCopyWith(PasswordResetChallenge value, $Res Function(PasswordResetChallenge) _then) = _$PasswordResetChallengeCopyWithImpl;
@useResult
$Res call({
 String email, String resetToken
});




}
/// @nodoc
class _$PasswordResetChallengeCopyWithImpl<$Res>
    implements $PasswordResetChallengeCopyWith<$Res> {
  _$PasswordResetChallengeCopyWithImpl(this._self, this._then);

  final PasswordResetChallenge _self;
  final $Res Function(PasswordResetChallenge) _then;

/// Create a copy of PasswordResetChallenge
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? resetToken = null,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,resetToken: null == resetToken ? _self.resetToken : resetToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PasswordResetChallenge].
extension PasswordResetChallengePatterns on PasswordResetChallenge {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PasswordResetChallenge value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PasswordResetChallenge() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PasswordResetChallenge value)  $default,){
final _that = this;
switch (_that) {
case _PasswordResetChallenge():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PasswordResetChallenge value)?  $default,){
final _that = this;
switch (_that) {
case _PasswordResetChallenge() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String resetToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PasswordResetChallenge() when $default != null:
return $default(_that.email,_that.resetToken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  String resetToken)  $default,) {final _that = this;
switch (_that) {
case _PasswordResetChallenge():
return $default(_that.email,_that.resetToken);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  String resetToken)?  $default,) {final _that = this;
switch (_that) {
case _PasswordResetChallenge() when $default != null:
return $default(_that.email,_that.resetToken);case _:
  return null;

}
}

}

/// @nodoc


class _PasswordResetChallenge implements PasswordResetChallenge {
  const _PasswordResetChallenge({required this.email, required this.resetToken});
  

@override final  String email;
@override final  String resetToken;

/// Create a copy of PasswordResetChallenge
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PasswordResetChallengeCopyWith<_PasswordResetChallenge> get copyWith => __$PasswordResetChallengeCopyWithImpl<_PasswordResetChallenge>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PasswordResetChallenge&&(identical(other.email, email) || other.email == email)&&(identical(other.resetToken, resetToken) || other.resetToken == resetToken));
}


@override
int get hashCode => Object.hash(runtimeType,email,resetToken);

@override
String toString() {
  return 'PasswordResetChallenge(email: $email, resetToken: $resetToken)';
}


}

/// @nodoc
abstract mixin class _$PasswordResetChallengeCopyWith<$Res> implements $PasswordResetChallengeCopyWith<$Res> {
  factory _$PasswordResetChallengeCopyWith(_PasswordResetChallenge value, $Res Function(_PasswordResetChallenge) _then) = __$PasswordResetChallengeCopyWithImpl;
@override @useResult
$Res call({
 String email, String resetToken
});




}
/// @nodoc
class __$PasswordResetChallengeCopyWithImpl<$Res>
    implements _$PasswordResetChallengeCopyWith<$Res> {
  __$PasswordResetChallengeCopyWithImpl(this._self, this._then);

  final _PasswordResetChallenge _self;
  final $Res Function(_PasswordResetChallenge) _then;

/// Create a copy of PasswordResetChallenge
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? resetToken = null,}) {
  return _then(_PasswordResetChallenge(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,resetToken: null == resetToken ? _self.resetToken : resetToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
