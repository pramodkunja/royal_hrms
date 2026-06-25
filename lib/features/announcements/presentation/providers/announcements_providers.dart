import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_client.dart';
import '../../data/datasource/announcements_remote_datasource.dart';
import '../../data/repositories/announcements_repository_impl.dart';
import '../../domain/repositories/announcements_repository.dart';

final announcementsRemoteDataSourceProvider =
    Provider<AnnouncementsRemoteDataSource>((ref) {
      return AnnouncementsRemoteDataSourceImpl(ref.watch(apiClientProvider));
    });

final announcementsRepositoryProvider = Provider<AnnouncementsRepository>((
  ref,
) {
  return AnnouncementsRepositoryImpl(
    ref.watch(announcementsRemoteDataSourceProvider),
  );
});
