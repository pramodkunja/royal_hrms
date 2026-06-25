// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'smtp_config_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SmtpConfigRequestModel {

 String get name;@JsonKey(name: 'smtp_type') SmtpType get type; String get host; int get port;@JsonKey(name: 'use_tls') bool get useTls;@JsonKey(name: 'sender_name') String get senderName;@JsonKey(name: 'from_email') String get fromEmail; String get username; String? get password;@JsonKey(name: 'bcc_email') String? get bccEmail; SmtpPriority get priority;@JsonKey(name: 'receiver_email_type', toJson: _receiverEmailToJson) SmtpReceiverEmail get receiverEmail;
/// Create a copy of SmtpConfigRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SmtpConfigRequestModelCopyWith<SmtpConfigRequestModel> get copyWith => _$SmtpConfigRequestModelCopyWithImpl<SmtpConfigRequestModel>(this as SmtpConfigRequestModel, _$identity);

  /// Serializes this SmtpConfigRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SmtpConfigRequestModel&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.host, host) || other.host == host)&&(identical(other.port, port) || other.port == port)&&(identical(other.useTls, useTls) || other.useTls == useTls)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.fromEmail, fromEmail) || other.fromEmail == fromEmail)&&(identical(other.username, username) || other.username == username)&&(identical(other.password, password) || other.password == password)&&(identical(other.bccEmail, bccEmail) || other.bccEmail == bccEmail)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.receiverEmail, receiverEmail) || other.receiverEmail == receiverEmail));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,type,host,port,useTls,senderName,fromEmail,username,password,bccEmail,priority,receiverEmail);

@override
String toString() {
  return 'SmtpConfigRequestModel(name: $name, type: $type, host: $host, port: $port, useTls: $useTls, senderName: $senderName, fromEmail: $fromEmail, username: $username, password: $password, bccEmail: $bccEmail, priority: $priority, receiverEmail: $receiverEmail)';
}


}

/// @nodoc
abstract mixin class $SmtpConfigRequestModelCopyWith<$Res>  {
  factory $SmtpConfigRequestModelCopyWith(SmtpConfigRequestModel value, $Res Function(SmtpConfigRequestModel) _then) = _$SmtpConfigRequestModelCopyWithImpl;
@useResult
$Res call({
 String name,@JsonKey(name: 'smtp_type') SmtpType type, String host, int port,@JsonKey(name: 'use_tls') bool useTls,@JsonKey(name: 'sender_name') String senderName,@JsonKey(name: 'from_email') String fromEmail, String username, String? password,@JsonKey(name: 'bcc_email') String? bccEmail, SmtpPriority priority,@JsonKey(name: 'receiver_email_type', toJson: _receiverEmailToJson) SmtpReceiverEmail receiverEmail
});




}
/// @nodoc
class _$SmtpConfigRequestModelCopyWithImpl<$Res>
    implements $SmtpConfigRequestModelCopyWith<$Res> {
  _$SmtpConfigRequestModelCopyWithImpl(this._self, this._then);

  final SmtpConfigRequestModel _self;
  final $Res Function(SmtpConfigRequestModel) _then;

/// Create a copy of SmtpConfigRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? type = null,Object? host = null,Object? port = null,Object? useTls = null,Object? senderName = null,Object? fromEmail = null,Object? username = null,Object? password = freezed,Object? bccEmail = freezed,Object? priority = null,Object? receiverEmail = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SmtpType,host: null == host ? _self.host : host // ignore: cast_nullable_to_non_nullable
as String,port: null == port ? _self.port : port // ignore: cast_nullable_to_non_nullable
as int,useTls: null == useTls ? _self.useTls : useTls // ignore: cast_nullable_to_non_nullable
as bool,senderName: null == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String,fromEmail: null == fromEmail ? _self.fromEmail : fromEmail // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,bccEmail: freezed == bccEmail ? _self.bccEmail : bccEmail // ignore: cast_nullable_to_non_nullable
as String?,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as SmtpPriority,receiverEmail: null == receiverEmail ? _self.receiverEmail : receiverEmail // ignore: cast_nullable_to_non_nullable
as SmtpReceiverEmail,
  ));
}

}


/// Adds pattern-matching-related methods to [SmtpConfigRequestModel].
extension SmtpConfigRequestModelPatterns on SmtpConfigRequestModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SmtpConfigRequestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SmtpConfigRequestModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SmtpConfigRequestModel value)  $default,){
final _that = this;
switch (_that) {
case _SmtpConfigRequestModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SmtpConfigRequestModel value)?  $default,){
final _that = this;
switch (_that) {
case _SmtpConfigRequestModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name, @JsonKey(name: 'smtp_type')  SmtpType type,  String host,  int port, @JsonKey(name: 'use_tls')  bool useTls, @JsonKey(name: 'sender_name')  String senderName, @JsonKey(name: 'from_email')  String fromEmail,  String username,  String? password, @JsonKey(name: 'bcc_email')  String? bccEmail,  SmtpPriority priority, @JsonKey(name: 'receiver_email_type', toJson: _receiverEmailToJson)  SmtpReceiverEmail receiverEmail)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SmtpConfigRequestModel() when $default != null:
return $default(_that.name,_that.type,_that.host,_that.port,_that.useTls,_that.senderName,_that.fromEmail,_that.username,_that.password,_that.bccEmail,_that.priority,_that.receiverEmail);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name, @JsonKey(name: 'smtp_type')  SmtpType type,  String host,  int port, @JsonKey(name: 'use_tls')  bool useTls, @JsonKey(name: 'sender_name')  String senderName, @JsonKey(name: 'from_email')  String fromEmail,  String username,  String? password, @JsonKey(name: 'bcc_email')  String? bccEmail,  SmtpPriority priority, @JsonKey(name: 'receiver_email_type', toJson: _receiverEmailToJson)  SmtpReceiverEmail receiverEmail)  $default,) {final _that = this;
switch (_that) {
case _SmtpConfigRequestModel():
return $default(_that.name,_that.type,_that.host,_that.port,_that.useTls,_that.senderName,_that.fromEmail,_that.username,_that.password,_that.bccEmail,_that.priority,_that.receiverEmail);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name, @JsonKey(name: 'smtp_type')  SmtpType type,  String host,  int port, @JsonKey(name: 'use_tls')  bool useTls, @JsonKey(name: 'sender_name')  String senderName, @JsonKey(name: 'from_email')  String fromEmail,  String username,  String? password, @JsonKey(name: 'bcc_email')  String? bccEmail,  SmtpPriority priority, @JsonKey(name: 'receiver_email_type', toJson: _receiverEmailToJson)  SmtpReceiverEmail receiverEmail)?  $default,) {final _that = this;
switch (_that) {
case _SmtpConfigRequestModel() when $default != null:
return $default(_that.name,_that.type,_that.host,_that.port,_that.useTls,_that.senderName,_that.fromEmail,_that.username,_that.password,_that.bccEmail,_that.priority,_that.receiverEmail);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SmtpConfigRequestModel extends SmtpConfigRequestModel {
  const _SmtpConfigRequestModel({required this.name, @JsonKey(name: 'smtp_type') required this.type, required this.host, required this.port, @JsonKey(name: 'use_tls') required this.useTls, @JsonKey(name: 'sender_name') required this.senderName, @JsonKey(name: 'from_email') required this.fromEmail, required this.username, this.password, @JsonKey(name: 'bcc_email') this.bccEmail, required this.priority, @JsonKey(name: 'receiver_email_type', toJson: _receiverEmailToJson) required this.receiverEmail}): super._();
  factory _SmtpConfigRequestModel.fromJson(Map<String, dynamic> json) => _$SmtpConfigRequestModelFromJson(json);

@override final  String name;
@override@JsonKey(name: 'smtp_type') final  SmtpType type;
@override final  String host;
@override final  int port;
@override@JsonKey(name: 'use_tls') final  bool useTls;
@override@JsonKey(name: 'sender_name') final  String senderName;
@override@JsonKey(name: 'from_email') final  String fromEmail;
@override final  String username;
@override final  String? password;
@override@JsonKey(name: 'bcc_email') final  String? bccEmail;
@override final  SmtpPriority priority;
@override@JsonKey(name: 'receiver_email_type', toJson: _receiverEmailToJson) final  SmtpReceiverEmail receiverEmail;

/// Create a copy of SmtpConfigRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SmtpConfigRequestModelCopyWith<_SmtpConfigRequestModel> get copyWith => __$SmtpConfigRequestModelCopyWithImpl<_SmtpConfigRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SmtpConfigRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SmtpConfigRequestModel&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.host, host) || other.host == host)&&(identical(other.port, port) || other.port == port)&&(identical(other.useTls, useTls) || other.useTls == useTls)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.fromEmail, fromEmail) || other.fromEmail == fromEmail)&&(identical(other.username, username) || other.username == username)&&(identical(other.password, password) || other.password == password)&&(identical(other.bccEmail, bccEmail) || other.bccEmail == bccEmail)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.receiverEmail, receiverEmail) || other.receiverEmail == receiverEmail));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,type,host,port,useTls,senderName,fromEmail,username,password,bccEmail,priority,receiverEmail);

@override
String toString() {
  return 'SmtpConfigRequestModel(name: $name, type: $type, host: $host, port: $port, useTls: $useTls, senderName: $senderName, fromEmail: $fromEmail, username: $username, password: $password, bccEmail: $bccEmail, priority: $priority, receiverEmail: $receiverEmail)';
}


}

/// @nodoc
abstract mixin class _$SmtpConfigRequestModelCopyWith<$Res> implements $SmtpConfigRequestModelCopyWith<$Res> {
  factory _$SmtpConfigRequestModelCopyWith(_SmtpConfigRequestModel value, $Res Function(_SmtpConfigRequestModel) _then) = __$SmtpConfigRequestModelCopyWithImpl;
@override @useResult
$Res call({
 String name,@JsonKey(name: 'smtp_type') SmtpType type, String host, int port,@JsonKey(name: 'use_tls') bool useTls,@JsonKey(name: 'sender_name') String senderName,@JsonKey(name: 'from_email') String fromEmail, String username, String? password,@JsonKey(name: 'bcc_email') String? bccEmail, SmtpPriority priority,@JsonKey(name: 'receiver_email_type', toJson: _receiverEmailToJson) SmtpReceiverEmail receiverEmail
});




}
/// @nodoc
class __$SmtpConfigRequestModelCopyWithImpl<$Res>
    implements _$SmtpConfigRequestModelCopyWith<$Res> {
  __$SmtpConfigRequestModelCopyWithImpl(this._self, this._then);

  final _SmtpConfigRequestModel _self;
  final $Res Function(_SmtpConfigRequestModel) _then;

/// Create a copy of SmtpConfigRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? type = null,Object? host = null,Object? port = null,Object? useTls = null,Object? senderName = null,Object? fromEmail = null,Object? username = null,Object? password = freezed,Object? bccEmail = freezed,Object? priority = null,Object? receiverEmail = null,}) {
  return _then(_SmtpConfigRequestModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SmtpType,host: null == host ? _self.host : host // ignore: cast_nullable_to_non_nullable
as String,port: null == port ? _self.port : port // ignore: cast_nullable_to_non_nullable
as int,useTls: null == useTls ? _self.useTls : useTls // ignore: cast_nullable_to_non_nullable
as bool,senderName: null == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String,fromEmail: null == fromEmail ? _self.fromEmail : fromEmail // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,bccEmail: freezed == bccEmail ? _self.bccEmail : bccEmail // ignore: cast_nullable_to_non_nullable
as String?,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as SmtpPriority,receiverEmail: null == receiverEmail ? _self.receiverEmail : receiverEmail // ignore: cast_nullable_to_non_nullable
as SmtpReceiverEmail,
  ));
}


}

// dart format on
