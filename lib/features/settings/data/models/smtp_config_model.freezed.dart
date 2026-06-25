// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'smtp_config_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SmtpConfigModel {

@JsonKey(fromJson: _idFromJson) String get id;@JsonKey(fromJson: _stringFromJson) String get name;@JsonKey(name: 'smtp_type', fromJson: _smtpTypeFromJson) SmtpType get type;@JsonKey(fromJson: _stringFromJson) String get host;@JsonKey(fromJson: _intFromJson) int get port;@JsonKey(name: 'use_tls', fromJson: _boolFromJson) bool get useTls;@JsonKey(name: 'sender_name', fromJson: _stringFromJson) String get senderName;@JsonKey(name: 'from_email', fromJson: _stringFromJson) String get fromEmail;@JsonKey(fromJson: _stringFromJson) String get username;@JsonKey(name: 'bcc_email') String? get bccEmail;@JsonKey(fromJson: _smtpPriorityFromJson) SmtpPriority get priority;@JsonKey(name: 'receiver_email_type', fromJson: _receiverEmailFromJson, toJson: _receiverEmailToJson) SmtpReceiverEmail get receiverEmail;@JsonKey(name: 'is_active', fromJson: _boolFromJson) bool get isActive;@JsonKey(name: 'updated_at', fromJson: _dateTimeFromJson) DateTime get updatedAt;
/// Create a copy of SmtpConfigModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SmtpConfigModelCopyWith<SmtpConfigModel> get copyWith => _$SmtpConfigModelCopyWithImpl<SmtpConfigModel>(this as SmtpConfigModel, _$identity);

  /// Serializes this SmtpConfigModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SmtpConfigModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.host, host) || other.host == host)&&(identical(other.port, port) || other.port == port)&&(identical(other.useTls, useTls) || other.useTls == useTls)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.fromEmail, fromEmail) || other.fromEmail == fromEmail)&&(identical(other.username, username) || other.username == username)&&(identical(other.bccEmail, bccEmail) || other.bccEmail == bccEmail)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.receiverEmail, receiverEmail) || other.receiverEmail == receiverEmail)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,host,port,useTls,senderName,fromEmail,username,bccEmail,priority,receiverEmail,isActive,updatedAt);

@override
String toString() {
  return 'SmtpConfigModel(id: $id, name: $name, type: $type, host: $host, port: $port, useTls: $useTls, senderName: $senderName, fromEmail: $fromEmail, username: $username, bccEmail: $bccEmail, priority: $priority, receiverEmail: $receiverEmail, isActive: $isActive, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $SmtpConfigModelCopyWith<$Res>  {
  factory $SmtpConfigModelCopyWith(SmtpConfigModel value, $Res Function(SmtpConfigModel) _then) = _$SmtpConfigModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: _idFromJson) String id,@JsonKey(fromJson: _stringFromJson) String name,@JsonKey(name: 'smtp_type', fromJson: _smtpTypeFromJson) SmtpType type,@JsonKey(fromJson: _stringFromJson) String host,@JsonKey(fromJson: _intFromJson) int port,@JsonKey(name: 'use_tls', fromJson: _boolFromJson) bool useTls,@JsonKey(name: 'sender_name', fromJson: _stringFromJson) String senderName,@JsonKey(name: 'from_email', fromJson: _stringFromJson) String fromEmail,@JsonKey(fromJson: _stringFromJson) String username,@JsonKey(name: 'bcc_email') String? bccEmail,@JsonKey(fromJson: _smtpPriorityFromJson) SmtpPriority priority,@JsonKey(name: 'receiver_email_type', fromJson: _receiverEmailFromJson, toJson: _receiverEmailToJson) SmtpReceiverEmail receiverEmail,@JsonKey(name: 'is_active', fromJson: _boolFromJson) bool isActive,@JsonKey(name: 'updated_at', fromJson: _dateTimeFromJson) DateTime updatedAt
});




}
/// @nodoc
class _$SmtpConfigModelCopyWithImpl<$Res>
    implements $SmtpConfigModelCopyWith<$Res> {
  _$SmtpConfigModelCopyWithImpl(this._self, this._then);

  final SmtpConfigModel _self;
  final $Res Function(SmtpConfigModel) _then;

/// Create a copy of SmtpConfigModel
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


/// Adds pattern-matching-related methods to [SmtpConfigModel].
extension SmtpConfigModelPatterns on SmtpConfigModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SmtpConfigModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SmtpConfigModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SmtpConfigModel value)  $default,){
final _that = this;
switch (_that) {
case _SmtpConfigModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SmtpConfigModel value)?  $default,){
final _that = this;
switch (_that) {
case _SmtpConfigModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _idFromJson)  String id, @JsonKey(fromJson: _stringFromJson)  String name, @JsonKey(name: 'smtp_type', fromJson: _smtpTypeFromJson)  SmtpType type, @JsonKey(fromJson: _stringFromJson)  String host, @JsonKey(fromJson: _intFromJson)  int port, @JsonKey(name: 'use_tls', fromJson: _boolFromJson)  bool useTls, @JsonKey(name: 'sender_name', fromJson: _stringFromJson)  String senderName, @JsonKey(name: 'from_email', fromJson: _stringFromJson)  String fromEmail, @JsonKey(fromJson: _stringFromJson)  String username, @JsonKey(name: 'bcc_email')  String? bccEmail, @JsonKey(fromJson: _smtpPriorityFromJson)  SmtpPriority priority, @JsonKey(name: 'receiver_email_type', fromJson: _receiverEmailFromJson, toJson: _receiverEmailToJson)  SmtpReceiverEmail receiverEmail, @JsonKey(name: 'is_active', fromJson: _boolFromJson)  bool isActive, @JsonKey(name: 'updated_at', fromJson: _dateTimeFromJson)  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SmtpConfigModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _idFromJson)  String id, @JsonKey(fromJson: _stringFromJson)  String name, @JsonKey(name: 'smtp_type', fromJson: _smtpTypeFromJson)  SmtpType type, @JsonKey(fromJson: _stringFromJson)  String host, @JsonKey(fromJson: _intFromJson)  int port, @JsonKey(name: 'use_tls', fromJson: _boolFromJson)  bool useTls, @JsonKey(name: 'sender_name', fromJson: _stringFromJson)  String senderName, @JsonKey(name: 'from_email', fromJson: _stringFromJson)  String fromEmail, @JsonKey(fromJson: _stringFromJson)  String username, @JsonKey(name: 'bcc_email')  String? bccEmail, @JsonKey(fromJson: _smtpPriorityFromJson)  SmtpPriority priority, @JsonKey(name: 'receiver_email_type', fromJson: _receiverEmailFromJson, toJson: _receiverEmailToJson)  SmtpReceiverEmail receiverEmail, @JsonKey(name: 'is_active', fromJson: _boolFromJson)  bool isActive, @JsonKey(name: 'updated_at', fromJson: _dateTimeFromJson)  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _SmtpConfigModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(fromJson: _idFromJson)  String id, @JsonKey(fromJson: _stringFromJson)  String name, @JsonKey(name: 'smtp_type', fromJson: _smtpTypeFromJson)  SmtpType type, @JsonKey(fromJson: _stringFromJson)  String host, @JsonKey(fromJson: _intFromJson)  int port, @JsonKey(name: 'use_tls', fromJson: _boolFromJson)  bool useTls, @JsonKey(name: 'sender_name', fromJson: _stringFromJson)  String senderName, @JsonKey(name: 'from_email', fromJson: _stringFromJson)  String fromEmail, @JsonKey(fromJson: _stringFromJson)  String username, @JsonKey(name: 'bcc_email')  String? bccEmail, @JsonKey(fromJson: _smtpPriorityFromJson)  SmtpPriority priority, @JsonKey(name: 'receiver_email_type', fromJson: _receiverEmailFromJson, toJson: _receiverEmailToJson)  SmtpReceiverEmail receiverEmail, @JsonKey(name: 'is_active', fromJson: _boolFromJson)  bool isActive, @JsonKey(name: 'updated_at', fromJson: _dateTimeFromJson)  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _SmtpConfigModel() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.host,_that.port,_that.useTls,_that.senderName,_that.fromEmail,_that.username,_that.bccEmail,_that.priority,_that.receiverEmail,_that.isActive,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SmtpConfigModel extends SmtpConfigModel {
  const _SmtpConfigModel({@JsonKey(fromJson: _idFromJson) required this.id, @JsonKey(fromJson: _stringFromJson) required this.name, @JsonKey(name: 'smtp_type', fromJson: _smtpTypeFromJson) required this.type, @JsonKey(fromJson: _stringFromJson) required this.host, @JsonKey(fromJson: _intFromJson) required this.port, @JsonKey(name: 'use_tls', fromJson: _boolFromJson) required this.useTls, @JsonKey(name: 'sender_name', fromJson: _stringFromJson) required this.senderName, @JsonKey(name: 'from_email', fromJson: _stringFromJson) required this.fromEmail, @JsonKey(fromJson: _stringFromJson) required this.username, @JsonKey(name: 'bcc_email') this.bccEmail, @JsonKey(fromJson: _smtpPriorityFromJson) required this.priority, @JsonKey(name: 'receiver_email_type', fromJson: _receiverEmailFromJson, toJson: _receiverEmailToJson) required this.receiverEmail, @JsonKey(name: 'is_active', fromJson: _boolFromJson) required this.isActive, @JsonKey(name: 'updated_at', fromJson: _dateTimeFromJson) required this.updatedAt}): super._();
  factory _SmtpConfigModel.fromJson(Map<String, dynamic> json) => _$SmtpConfigModelFromJson(json);

@override@JsonKey(fromJson: _idFromJson) final  String id;
@override@JsonKey(fromJson: _stringFromJson) final  String name;
@override@JsonKey(name: 'smtp_type', fromJson: _smtpTypeFromJson) final  SmtpType type;
@override@JsonKey(fromJson: _stringFromJson) final  String host;
@override@JsonKey(fromJson: _intFromJson) final  int port;
@override@JsonKey(name: 'use_tls', fromJson: _boolFromJson) final  bool useTls;
@override@JsonKey(name: 'sender_name', fromJson: _stringFromJson) final  String senderName;
@override@JsonKey(name: 'from_email', fromJson: _stringFromJson) final  String fromEmail;
@override@JsonKey(fromJson: _stringFromJson) final  String username;
@override@JsonKey(name: 'bcc_email') final  String? bccEmail;
@override@JsonKey(fromJson: _smtpPriorityFromJson) final  SmtpPriority priority;
@override@JsonKey(name: 'receiver_email_type', fromJson: _receiverEmailFromJson, toJson: _receiverEmailToJson) final  SmtpReceiverEmail receiverEmail;
@override@JsonKey(name: 'is_active', fromJson: _boolFromJson) final  bool isActive;
@override@JsonKey(name: 'updated_at', fromJson: _dateTimeFromJson) final  DateTime updatedAt;

/// Create a copy of SmtpConfigModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SmtpConfigModelCopyWith<_SmtpConfigModel> get copyWith => __$SmtpConfigModelCopyWithImpl<_SmtpConfigModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SmtpConfigModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SmtpConfigModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.host, host) || other.host == host)&&(identical(other.port, port) || other.port == port)&&(identical(other.useTls, useTls) || other.useTls == useTls)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.fromEmail, fromEmail) || other.fromEmail == fromEmail)&&(identical(other.username, username) || other.username == username)&&(identical(other.bccEmail, bccEmail) || other.bccEmail == bccEmail)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.receiverEmail, receiverEmail) || other.receiverEmail == receiverEmail)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,host,port,useTls,senderName,fromEmail,username,bccEmail,priority,receiverEmail,isActive,updatedAt);

@override
String toString() {
  return 'SmtpConfigModel(id: $id, name: $name, type: $type, host: $host, port: $port, useTls: $useTls, senderName: $senderName, fromEmail: $fromEmail, username: $username, bccEmail: $bccEmail, priority: $priority, receiverEmail: $receiverEmail, isActive: $isActive, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$SmtpConfigModelCopyWith<$Res> implements $SmtpConfigModelCopyWith<$Res> {
  factory _$SmtpConfigModelCopyWith(_SmtpConfigModel value, $Res Function(_SmtpConfigModel) _then) = __$SmtpConfigModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: _idFromJson) String id,@JsonKey(fromJson: _stringFromJson) String name,@JsonKey(name: 'smtp_type', fromJson: _smtpTypeFromJson) SmtpType type,@JsonKey(fromJson: _stringFromJson) String host,@JsonKey(fromJson: _intFromJson) int port,@JsonKey(name: 'use_tls', fromJson: _boolFromJson) bool useTls,@JsonKey(name: 'sender_name', fromJson: _stringFromJson) String senderName,@JsonKey(name: 'from_email', fromJson: _stringFromJson) String fromEmail,@JsonKey(fromJson: _stringFromJson) String username,@JsonKey(name: 'bcc_email') String? bccEmail,@JsonKey(fromJson: _smtpPriorityFromJson) SmtpPriority priority,@JsonKey(name: 'receiver_email_type', fromJson: _receiverEmailFromJson, toJson: _receiverEmailToJson) SmtpReceiverEmail receiverEmail,@JsonKey(name: 'is_active', fromJson: _boolFromJson) bool isActive,@JsonKey(name: 'updated_at', fromJson: _dateTimeFromJson) DateTime updatedAt
});




}
/// @nodoc
class __$SmtpConfigModelCopyWithImpl<$Res>
    implements _$SmtpConfigModelCopyWith<$Res> {
  __$SmtpConfigModelCopyWithImpl(this._self, this._then);

  final _SmtpConfigModel _self;
  final $Res Function(_SmtpConfigModel) _then;

/// Create a copy of SmtpConfigModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? type = null,Object? host = null,Object? port = null,Object? useTls = null,Object? senderName = null,Object? fromEmail = null,Object? username = null,Object? bccEmail = freezed,Object? priority = null,Object? receiverEmail = null,Object? isActive = null,Object? updatedAt = null,}) {
  return _then(_SmtpConfigModel(
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
