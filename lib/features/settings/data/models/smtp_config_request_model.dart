import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/smtp_config.dart';

part 'smtp_config_request_model.freezed.dart';
part 'smtp_config_request_model.g.dart';

String _receiverEmailToJson(SmtpReceiverEmail v) =>
    v == SmtpReceiverEmail.personalEmailId ? 'personal_email_id' : 'email_id';

@freezed
abstract class SmtpConfigRequestModel with _$SmtpConfigRequestModel {
  const SmtpConfigRequestModel._();

  const factory SmtpConfigRequestModel({
    required String name,
    @JsonKey(name: 'smtp_type') required SmtpType type,
    required String host,
    required int port,
    @JsonKey(name: 'use_tls') required bool useTls,
    @JsonKey(name: 'sender_name') required String senderName,
    @JsonKey(name: 'from_email') required String fromEmail,
    required String username,
    String? password,
    @JsonKey(name: 'bcc_email') String? bccEmail,
    required SmtpPriority priority,
    @JsonKey(name: 'receiver_email_type', toJson: _receiverEmailToJson)
    required SmtpReceiverEmail receiverEmail,
  }) = _SmtpConfigRequestModel;

  factory SmtpConfigRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SmtpConfigRequestModelFromJson(json);
}
