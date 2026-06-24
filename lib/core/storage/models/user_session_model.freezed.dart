// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_session_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserSessionModel {

 String get userId; String get name; String get email; UserRole get role;
/// Create a copy of UserSessionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserSessionModelCopyWith<UserSessionModel> get copyWith => _$UserSessionModelCopyWithImpl<UserSessionModel>(this as UserSessionModel, _$identity);

  /// Serializes this UserSessionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSessionModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.role, role) || other.role == role));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,name,email,role);

@override
String toString() {
  return 'UserSessionModel(userId: $userId, name: $name, email: $email, role: $role)';
}


}

/// @nodoc
abstract mixin class $UserSessionModelCopyWith<$Res>  {
  factory $UserSessionModelCopyWith(UserSessionModel value, $Res Function(UserSessionModel) _then) = _$UserSessionModelCopyWithImpl;
@useResult
$Res call({
 String userId, String name, String email, UserRole role
});




}
/// @nodoc
class _$UserSessionModelCopyWithImpl<$Res>
    implements $UserSessionModelCopyWith<$Res> {
  _$UserSessionModelCopyWithImpl(this._self, this._then);

  final UserSessionModel _self;
  final $Res Function(UserSessionModel) _then;

/// Create a copy of UserSessionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? name = null,Object? email = null,Object? role = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserRole,
  ));
}

}


/// Adds pattern-matching-related methods to [UserSessionModel].
extension UserSessionModelPatterns on UserSessionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserSessionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserSessionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserSessionModel value)  $default,){
final _that = this;
switch (_that) {
case _UserSessionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserSessionModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserSessionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String name,  String email,  UserRole role)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserSessionModel() when $default != null:
return $default(_that.userId,_that.name,_that.email,_that.role);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String name,  String email,  UserRole role)  $default,) {final _that = this;
switch (_that) {
case _UserSessionModel():
return $default(_that.userId,_that.name,_that.email,_that.role);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String name,  String email,  UserRole role)?  $default,) {final _that = this;
switch (_that) {
case _UserSessionModel() when $default != null:
return $default(_that.userId,_that.name,_that.email,_that.role);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserSessionModel implements UserSessionModel {
  const _UserSessionModel({required this.userId, required this.name, required this.email, required this.role});
  factory _UserSessionModel.fromJson(Map<String, dynamic> json) => _$UserSessionModelFromJson(json);

@override final  String userId;
@override final  String name;
@override final  String email;
@override final  UserRole role;

/// Create a copy of UserSessionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserSessionModelCopyWith<_UserSessionModel> get copyWith => __$UserSessionModelCopyWithImpl<_UserSessionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserSessionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserSessionModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.role, role) || other.role == role));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,name,email,role);

@override
String toString() {
  return 'UserSessionModel(userId: $userId, name: $name, email: $email, role: $role)';
}


}

/// @nodoc
abstract mixin class _$UserSessionModelCopyWith<$Res> implements $UserSessionModelCopyWith<$Res> {
  factory _$UserSessionModelCopyWith(_UserSessionModel value, $Res Function(_UserSessionModel) _then) = __$UserSessionModelCopyWithImpl;
@override @useResult
$Res call({
 String userId, String name, String email, UserRole role
});




}
/// @nodoc
class __$UserSessionModelCopyWithImpl<$Res>
    implements _$UserSessionModelCopyWith<$Res> {
  __$UserSessionModelCopyWithImpl(this._self, this._then);

  final _UserSessionModel _self;
  final $Res Function(_UserSessionModel) _then;

/// Create a copy of UserSessionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? name = null,Object? email = null,Object? role = null,}) {
  return _then(_UserSessionModel(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserRole,
  ));
}


}

// dart format on
