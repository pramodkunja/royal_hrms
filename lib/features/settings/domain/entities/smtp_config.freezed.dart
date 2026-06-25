// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'smtp_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SmtpConfig {

 String get id; String get name; SmtpType get type; String get host; int get port; bool get useTls; String get senderName; String get fromEmail; String get username; String? get bccEmail; SmtpPriority get priority; SmtpReceiverEmail get receiverEmail; bool get isActive; DateTime get updatedAt;
/// Create a copy of SmtpConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SmtpConfigCopyWith<SmtpConfig> get copyWith => _$SmtpConfigCopyWithImpl<SmtpConfig>(this as SmtpConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SmtpConfig&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.host, host) || other.host == host)&&(identical(other.port, port) || other.port == port)&&(identical(other.useTls, useTls) || other.useTls == useTls)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.fromEmail, fromEmail) || other.fromEmail == fromEmail)&&(identical(other.username, username) || other.username == username)&&(identical(other.bccEmail, bccEmail) || other.bccEmail == bccEmail)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.receiverEmail, receiverEmail) || other.receiverEmail == receiverEmail)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,type,host,port,useTls,senderName,fromEmail,username,bccEmail,priority,receiverEmail,isActive,updatedAt);

@override
String toString() {
  return 'SmtpConfig(id: $id, name: $name, type: $type, host: $host, port: $port, useTls: $useTls, senderName: $senderName, fromEmail: $fromEmail, username: $username, bccEmail: $bccEmail, priority: $priority, receiverEmail: $receiverEmail, isActive: $isActive, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $SmtpConfigCopyWith<$Res>  {
  factory $SmtpConfigCopyWith(SmtpConfig value, $Res Function(SmtpConfig) _then) = _$SmtpConfigCopyWithImpl;
@useResult
$Res call({
 String id, String name, SmtpType type, String host, int port, bool useTls, String senderName, String fromEmail, String username, String? bccEmail, SmtpPriority priority, SmtpReceiverEmail receiverEmail, bool isActive, DateTime updatedAt
});




}
/// @nodoc
class _$SmtpConfigCopyWithImpl<$Res>
    implements $SmtpConfigCopyWith<$Res> {
  _$SmtpConfigCopyWithImpl(this._self, this._then);

  final SmtpConfig _self;
  final $Res Function(SmtpConfig) _then;

/// Create a copy of SmtpConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? type = null,Object? host = null,Object? port = null,Object? useTls = null,Object? senderName = null,Object? fromEmail = null,Object? username = null,Object? bccEmail = freezed,Object? priority = null,Object? receiverEmail = null,Object? isActive = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SmtpType,host: null == host ? _self.host : host // ignore: cast_nullable_to_non_nullable
as String,port: null == port ? _self.port : port // ignore: cast_nullable_to_non_nullable
as int,useTls: null == useTls ? _self.useTls : useTls // ignore: cast_nullable_to_non_nullable
as bool,senderName: null == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String,fromEmail: null == fromEmail ? _self.fromEmail : fromEmail // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,bccEmail: freezed == bccEmail ? _self.bccEmail : bccEmail // ignore: cast_nullable_to_non_nullable
as String?,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as SmtpPriority,receiverEmail: null == receiverEmail ? _self.receiverEmail : receiverEmail // ignore: cast_nullable_to_non_nullable
as SmtpReceiverEmail,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [SmtpConfig].
extension SmtpConfigPatterns on SmtpConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SmtpConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SmtpConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SmtpConfig value)  $default,){
final _that = this;
switch (_that) {
case _SmtpConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SmtpConfig value)?  $default,){
final _that = this;
switch (_that) {
case _SmtpConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  SmtpType type,  String host,  int port,  bool useTls,  String senderName,  String fromEmail,  String username,  String? bccEmail,  SmtpPriority priority,  SmtpReceiverEmail receiverEmail,  bool isActive,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SmtpConfig() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.host,_that.port,_that.useTls,_that.senderName,_that.fromEmail,_that.username,_that.bccEmail,_that.priority,_that.receiverEmail,_that.isActive,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  SmtpType type,  String host,  int port,  bool useTls,  String senderName,  String fromEmail,  String username,  String? bccEmail,  SmtpPriority priority,  SmtpReceiverEmail receiverEmail,  bool isActive,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _SmtpConfig():
return $default(_that.id,_that.name,_that.type,_that.host,_that.port,_that.useTls,_that.senderName,_that.fromEmail,_that.username,_that.bccEmail,_that.priority,_that.receiverEmail,_that.isActive,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  SmtpType type,  String host,  int port,  bool useTls,  String senderName,  String fromEmail,  String username,  String? bccEmail,  SmtpPriority priority,  SmtpReceiverEmail receiverEmail,  bool isActive,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _SmtpConfig() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.host,_that.port,_that.useTls,_that.senderName,_that.fromEmail,_that.username,_that.bccEmail,_that.priority,_that.receiverEmail,_that.isActive,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _SmtpConfig implements SmtpConfig {
  const _SmtpConfig({required this.id, required this.name, required this.type, required this.host, required this.port, required this.useTls, required this.senderName, required this.fromEmail, required this.username, this.bccEmail, required this.priority, required this.receiverEmail, required this.isActive, required this.updatedAt});
  

@override final  String id;
@override final  String name;
@override final  SmtpType type;
@override final  String host;
@override final  int port;
@override final  bool useTls;
@override final  String senderName;
@override final  String fromEmail;
@override final  String username;
@override final  String? bccEmail;
@override final  SmtpPriority priority;
@override final  SmtpReceiverEmail receiverEmail;
@override final  bool isActive;
@override final  DateTime updatedAt;

/// Create a copy of SmtpConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SmtpConfigCopyWith<_SmtpConfig> get copyWith => __$SmtpConfigCopyWithImpl<_SmtpConfig>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SmtpConfig&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.host, host) || other.host == host)&&(identical(other.port, port) || other.port == port)&&(identical(other.useTls, useTls) || other.useTls == useTls)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.fromEmail, fromEmail) || other.fromEmail == fromEmail)&&(identical(other.username, username) || other.username == username)&&(identical(other.bccEmail, bccEmail) || other.bccEmail == bccEmail)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.receiverEmail, receiverEmail) || other.receiverEmail == receiverEmail)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,type,host,port,useTls,senderName,fromEmail,username,bccEmail,priority,receiverEmail,isActive,updatedAt);

@override
String toString() {
  return 'SmtpConfig(id: $id, name: $name, type: $type, host: $host, port: $port, useTls: $useTls, senderName: $senderName, fromEmail: $fromEmail, username: $username, bccEmail: $bccEmail, priority: $priority, receiverEmail: $receiverEmail, isActive: $isActive, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$SmtpConfigCopyWith<$Res> implements $SmtpConfigCopyWith<$Res> {
  factory _$SmtpConfigCopyWith(_SmtpConfig value, $Res Function(_SmtpConfig) _then) = __$SmtpConfigCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, SmtpType type, String host, int port, bool useTls, String senderName, String fromEmail, String username, String? bccEmail, SmtpPriority priority, SmtpReceiverEmail receiverEmail, bool isActive, DateTime updatedAt
});




}
/// @nodoc
class __$SmtpConfigCopyWithImpl<$Res>
    implements _$SmtpConfigCopyWith<$Res> {
  __$SmtpConfigCopyWithImpl(this._self, this._then);

  final _SmtpConfig _self;
  final $Res Function(_SmtpConfig) _then;

/// Create a copy of SmtpConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? type = null,Object? host = null,Object? port = null,Object? useTls = null,Object? senderName = null,Object? fromEmail = null,Object? username = null,Object? bccEmail = freezed,Object? priority = null,Object? receiverEmail = null,Object? isActive = null,Object? updatedAt = null,}) {
  return _then(_SmtpConfig(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SmtpType,host: null == host ? _self.host : host // ignore: cast_nullable_to_non_nullable
as String,port: null == port ? _self.port : port // ignore: cast_nullable_to_non_nullable
as int,useTls: null == useTls ? _self.useTls : useTls // ignore: cast_nullable_to_non_nullable
as bool,senderName: null == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String,fromEmail: null == fromEmail ? _self.fromEmail : fromEmail // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,bccEmail: freezed == bccEmail ? _self.bccEmail : bccEmail // ignore: cast_nullable_to_non_nullable
as String?,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as SmtpPriority,receiverEmail: null == receiverEmail ? _self.receiverEmail : receiverEmail // ignore: cast_nullable_to_non_nullable
as SmtpReceiverEmail,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
