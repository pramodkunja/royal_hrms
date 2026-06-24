import '../../domain/repositories/notifications_repository.dart';
import '../datasource/notifications_remote_datasource.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  NotificationsRepositoryImpl(this._remoteDataSource);

  final NotificationsRemoteDataSource _remoteDataSource;

  NotificationsRemoteDataSource get remoteDataSource => _remoteDataSource;
}
