// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smtp_config_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SmtpConfigRequestModel _$SmtpConfigRequestModelFromJson(
  Map<String, dynamic> json,
) => _SmtpConfigRequestModel(
  name: json['name'] as String,
  type: $enumDecode(_$SmtpTypeEnumMap, json['smtp_type']),
  host: json['host'] as String,
  port: (json['port'] as num).toInt(),
  useTls: json['use_tls'] as bool,
  senderName: json['sender_name'] as String,
  fromEmail: json['from_email'] as String,
  username: json['username'] as String,
  password: json['password'] as String?,
  bccEmail: json['bcc_email'] as String?,
  priority: $enumDecode(_$SmtpPriorityEnumMap, json['priority']),
  receiverEmail: $enumDecode(
    _$SmtpReceiverEmailEnumMap,
    json['receiver_email_type'],
  ),
);

Map<String, dynamic> _$SmtpConfigRequestModelToJson(
  _SmtpConfigRequestModel instance,
) => <String, dynamic>{
  'name': instance.name,
  'smtp_type': _$SmtpTypeEnumMap[instance.type]!,
  'host': instance.host,
  'port': instance.port,
  'use_tls': instance.useTls,
  'sender_name': instance.senderName,
  'from_email': instance.fromEmail,
  'username': instance.username,
  'password': instance.password,
  'bcc_email': instance.bccEmail,
  'priority': _$SmtpPriorityEnumMap[instance.priority]!,
  'receiver_email_type': _receiverEmailToJson(instance.receiverEmail),
};

const _$SmtpTypeEnumMap = {SmtpType.local: 'local', SmtpType.server: 'server'};

const _$SmtpPriorityEnumMap = {
  SmtpPriority.normal: 'normal',
  SmtpPriority.high: 'high',
};

const _$SmtpReceiverEmailEnumMap = {
  SmtpReceiverEmail.emailId: 'emailId',
  SmtpReceiverEmail.personalEmailId: 'personalEmailId',
};
