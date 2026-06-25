import '../../domain/repositories/announcements_repository.dart';
import '../datasource/announcements_remote_datasource.dart';

class AnnouncementsRepositoryImpl implements AnnouncementsRepository {
  AnnouncementsRepositoryImpl(this._remoteDataSource);

  final AnnouncementsRemoteDataSource _remoteDataSource;

  AnnouncementsRemoteDataSource get remoteDataSource => _remoteDataSource;
}
