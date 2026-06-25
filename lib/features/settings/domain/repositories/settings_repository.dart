import '../entities/smtp_config.dart';

abstract class SettingsRepository {
  Future<List<SmtpConfig>> getSmtpConfigs();
  Future<SmtpConfig> createSmtpConfig(Map<String, dynamic> data);
  Future<SmtpConfig> updateSmtpConfig(String id, Map<String, dynamic> data);
  Future<void> deleteSmtpConfig(String id);
  Future<void> setSmtpConfigActive(String id);
  Future<void> testSmtpConfig(String id);
}
