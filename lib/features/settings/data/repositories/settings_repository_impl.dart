import '../../domain/entities/smtp_config.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasource/settings_remote_datasource.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl(this._remoteDataSource);

  final SettingsRemoteDataSource _remoteDataSource;

  @override
  Future<List<SmtpConfig>> getSmtpConfigs() async {
    final models = await _remoteDataSource.getSmtpConfigs();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<SmtpConfig> createSmtpConfig(Map<String, dynamic> data) async {
    final model = await _remoteDataSource.createSmtpConfig(data);
    return model.toEntity();
  }

  @override
  Future<SmtpConfig> updateSmtpConfig(
    String id,
    Map<String, dynamic> data,
  ) async {
    final model = await _remoteDataSource.updateSmtpConfig(id, data);
    return model.toEntity();
  }

  @override
  Future<void> deleteSmtpConfig(String id) =>
      _remoteDataSource.deleteSmtpConfig(id);

  @override
  Future<void> setSmtpConfigActive(String id) =>
      _remoteDataSource.setSmtpConfigActive(id);

  @override
  Future<void> testSmtpConfig(String id) =>
      _remoteDataSource.testSmtpConfig(id);
}
