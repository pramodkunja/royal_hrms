// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smtp_config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SmtpConfigModel _$SmtpConfigModelFromJson(Map<String, dynamic> json) =>
    _SmtpConfigModel(
      id: _idFromJson(json['id']),
      name: _stringFromJson(json['name']),
      type: _smtpTypeFromJson(json['smtp_type']),
      host: _stringFromJson(json['host']),
      port: _intFromJson(json['port']),
      useTls: _boolFromJson(json['use_tls']),
      senderName: _stringFromJson(json['sender_name']),
      fromEmail: _stringFromJson(json['from_email']),
      username: _stringFromJson(json['username']),
      bccEmail: json['bcc_email'] as String?,
      priority: _smtpPriorityFromJson(json['priority']),
      receiverEmail: _receiverEmailFromJson(json['receiver_email_type']),
      isActive: _boolFromJson(json['is_active']),
      updatedAt: _dateTimeFromJson(json['updated_at']),
    );

Map<String, dynamic> _$SmtpConfigModelToJson(_SmtpConfigModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'smtp_type': _$SmtpTypeEnumMap[instance.type]!,
      'host': instance.host,
      'port': instance.port,
      'use_tls': instance.useTls,
      'sender_name': instance.senderName,
      'from_email': instance.fromEmail,
      'username': instance.username,
      'bcc_email': instance.bccEmail,
      'priority': _$SmtpPriorityEnumMap[instance.priority]!,
      'receiver_email_type': _receiverEmailToJson(instance.receiverEmail),
      'is_active': instance.isActive,
      'updated_at': instance.updatedAt.toIso8601String(),
    };

const _$SmtpTypeEnumMap = {SmtpType.local: 'local', SmtpType.server: 'server'};

const _$SmtpPriorityEnumMap = {
  SmtpPriority.normal: 'normal',
  SmtpPriority.high: 'high',
};
