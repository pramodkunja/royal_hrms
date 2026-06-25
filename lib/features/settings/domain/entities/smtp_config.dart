import 'package:freezed_annotation/freezed_annotation.dart';

part 'smtp_config.freezed.dart';

enum SmtpType { local, server }

enum SmtpPriority { normal, high }

enum SmtpReceiverEmail { emailId, personalEmailId }

@freezed
abstract class SmtpConfig with _$SmtpConfig {
  const factory SmtpConfig({
    required String id,
    required String name,
    required SmtpType type,
    required String host,
    required int port,
    required bool useTls,
    required String senderName,
    required String fromEmail,
    required String username,
    String? bccEmail,
    required SmtpPriority priority,
    required SmtpReceiverEmail receiverEmail,
    required bool isActive,
    required DateTime updatedAt,
  }) = _SmtpConfig;
}
