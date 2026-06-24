import '../../domain/repositories/settings_repository.dart';
import '../datasource/settings_remote_datasource.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl(this._remoteDataSource);

  final SettingsRemoteDataSource _remoteDataSource;

  SettingsRemoteDataSource get remoteDataSource => _remoteDataSource;
}
