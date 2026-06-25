import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/smtp_config.dart';

part 'smtp_config_model.freezed.dart';
part 'smtp_config_model.g.dart';

// Null-safe converters — Django can return null for blank-allowed fields or
// when an expected field is missing from the response schema.

String _idFromJson(dynamic v) => v?.toString() ?? '';
String _stringFromJson(dynamic v) => v?.toString() ?? '';

int _intFromJson(dynamic v) {
  if (v is num) return v.toInt();
  return int.tryParse(v?.toString() ?? '') ?? 0;
}

bool _boolFromJson(dynamic v) => v == true || v?.toString() == 'true';

DateTime _dateTimeFromJson(dynamic v) {
  if (v == null) return DateTime.now();
  try {
    return DateTime.parse(v.toString());
  } catch (_) {
    return DateTime.now();
  }
}

SmtpType _smtpTypeFromJson(dynamic v) => SmtpType.values.firstWhere(
      (e) => e.name == v?.toString(),
      orElse: () => SmtpType.local,
    );

SmtpPriority _smtpPriorityFromJson(dynamic v) => SmtpPriority.values.firstWhere(
      (e) => e.name == v?.toString(),
      orElse: () => SmtpPriority.normal,
    );

SmtpReceiverEmail _receiverEmailFromJson(dynamic v) =>
    v?.toString() == 'personal_email_id'
        ? SmtpReceiverEmail.personalEmailId
        : SmtpReceiverEmail.emailId;

String _receiverEmailToJson(SmtpReceiverEmail v) =>
    v == SmtpReceiverEmail.personalEmailId ? 'personal_email_id' : 'email_id';

@freezed
abstract class SmtpConfigModel with _$SmtpConfigModel {
  const SmtpConfigModel._();

  const factory SmtpConfigModel({
    @JsonKey(fromJson: _idFromJson) required String id,
    @JsonKey(fromJson: _stringFromJson) required String name,
    @JsonKey(name: 'smtp_type', fromJson: _smtpTypeFromJson) required SmtpType type,
    @JsonKey(fromJson: _stringFromJson) required String host,
    @JsonKey(fromJson: _intFromJson) required int port,
    @JsonKey(name: 'use_tls', fromJson: _boolFromJson) required bool useTls,
    @JsonKey(name: 'sender_name', fromJson: _stringFromJson)
    required String senderName,
    @JsonKey(name: 'from_email', fromJson: _stringFromJson)
    required String fromEmail,
    @JsonKey(fromJson: _stringFromJson) required String username,
    @JsonKey(name: 'bcc_email') String? bccEmail,
    @JsonKey(fromJson: _smtpPriorityFromJson) required SmtpPriority priority,
    @JsonKey(
      name: 'receiver_email_type',
      fromJson: _receiverEmailFromJson,
      toJson: _receiverEmailToJson,
    )
    required SmtpReceiverEmail receiverEmail,
    @JsonKey(name: 'is_active', fromJson: _boolFromJson) required bool isActive,
    @JsonKey(name: 'updated_at', fromJson: _dateTimeFromJson)
    required DateTime updatedAt,
  }) = _SmtpConfigModel;

  factory SmtpConfigModel.fromJson(Map<String, dynamic> json) =>
      _$SmtpConfigModelFromJson(json);

  SmtpConfig toEntity() => SmtpConfig(
        id: id,
        name: name,
        type: type,
        host: host,
        port: port,
        useTls: useTls,
        senderName: senderName,
        fromEmail: fromEmail,
        username: username,
        bccEmail: bccEmail,
        priority: priority,
        receiverEmail: receiverEmail,
        isActive: isActive,
        updatedAt: updatedAt,
      );
}
