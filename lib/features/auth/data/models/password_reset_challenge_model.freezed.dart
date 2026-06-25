// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'password_reset_challenge_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PasswordResetChallengeModel {

 String get email;@JsonKey(name: 'reset_token') String get resetToken;
/// Create a copy of PasswordResetChallengeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PasswordResetChallengeModelCopyWith<PasswordResetChallengeModel> get copyWith => _$PasswordResetChallengeModelCopyWithImpl<PasswordResetChallengeModel>(this as PasswordResetChallengeModel, _$identity);

  /// Serializes this PasswordResetChallengeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PasswordResetChallengeModel&&(identical(other.email, email) || other.email == email)&&(identical(other.resetToken, resetToken) || other.resetToken == resetToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,resetToken);

@override
String toString() {
  return 'PasswordResetChallengeModel(email: $email, resetToken: $resetToken)';
}


}

/// @nodoc
abstract mixin class $PasswordResetChallengeModelCopyWith<$Res>  {
  factory $PasswordResetChallengeModelCopyWith(PasswordResetChallengeModel value, $Res Function(PasswordResetChallengeModel) _then) = _$PasswordResetChallengeModelCopyWithImpl;
@useResult
$Res call({
 String email,@JsonKey(name: 'reset_token') String resetToken
});




}
/// @nodoc
class _$PasswordResetChallengeModelCopyWithImpl<$Res>
    implements $PasswordResetChallengeModelCopyWith<$Res> {
  _$PasswordResetChallengeModelCopyWithImpl(this._self, this._then);

  final PasswordResetChallengeModel _self;
  final $Res Function(PasswordResetChallengeModel) _then;

/// Create a copy of PasswordResetChallengeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? resetToken = null,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,resetToken: null == resetToken ? _self.resetToken : resetToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PasswordResetChallengeModel].
extension PasswordResetChallengeModelPatterns on PasswordResetChallengeModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PasswordResetChallengeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PasswordResetChallengeModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PasswordResetChallengeModel value)  $default,){
final _that = this;
switch (_that) {
case _PasswordResetChallengeModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PasswordResetChallengeModel value)?  $default,){
final _that = this;
switch (_that) {
case _PasswordResetChallengeModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email, @JsonKey(name: 'reset_token')  String resetToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PasswordResetChallengeModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email, @JsonKey(name: 'reset_token')  String resetToken)  $default,) {final _that = this;
switch (_that) {
case _PasswordResetChallengeModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email, @JsonKey(name: 'reset_token')  String resetToken)?  $default,) {final _that = this;
switch (_that) {
case _PasswordResetChallengeModel() when $default != null:
return $default(_that.email,_that.resetToken);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PasswordResetChallengeModel extends PasswordResetChallengeModel {
  const _PasswordResetChallengeModel({required this.email, @JsonKey(name: 'reset_token') required this.resetToken}): super._();
  factory _PasswordResetChallengeModel.fromJson(Map<String, dynamic> json) => _$PasswordResetChallengeModelFromJson(json);

@override final  String email;
@override@JsonKey(name: 'reset_token') final  String resetToken;

/// Create a copy of PasswordResetChallengeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PasswordResetChallengeModelCopyWith<_PasswordResetChallengeModel> get copyWith => __$PasswordResetChallengeModelCopyWithImpl<_PasswordResetChallengeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PasswordResetChallengeModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PasswordResetChallengeModel&&(identical(other.email, email) || other.email == email)&&(identical(other.resetToken, resetToken) || other.resetToken == resetToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,resetToken);

@override
String toString() {
  return 'PasswordResetChallengeModel(email: $email, resetToken: $resetToken)';
}


}

/// @nodoc
abstract mixin class _$PasswordResetChallengeModelCopyWith<$Res> implements $PasswordResetChallengeModelCopyWith<$Res> {
  factory _$PasswordResetChallengeModelCopyWith(_PasswordResetChallengeModel value, $Res Function(_PasswordResetChallengeModel) _then) = __$PasswordResetChallengeModelCopyWithImpl;
@override @useResult
$Res call({
 String email,@JsonKey(name: 'reset_token') String resetToken
});




}
/// @nodoc
class __$PasswordResetChallengeModelCopyWithImpl<$Res>
    implements _$PasswordResetChallengeModelCopyWith<$Res> {
  __$PasswordResetChallengeModelCopyWithImpl(this._self, this._then);

  final _PasswordResetChallengeModel _self;
  final $Res Function(_PasswordResetChallengeModel) _then;

/// Create a copy of PasswordResetChallengeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? resetToken = null,}) {
  return _then(_PasswordResetChallengeModel(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,resetToken: null == resetToken ? _self.resetToken : resetToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
