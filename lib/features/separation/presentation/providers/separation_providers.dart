import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_client.dart';
import '../../data/datasource/separation_remote_datasource.dart';
import '../../data/repositories/separation_repository_impl.dart';
import '../../domain/repositories/separation_repository.dart';

final separationRemoteDataSourceProvider = Provider<SeparationRemoteDataSource>(
  (ref) {
    return SeparationRemoteDataSourceImpl(ref.watch(apiClientProvider));
  },
);

final separationRepositoryProvider = Provider<SeparationRepository>((ref) {
  return SeparationRepositoryImpl(
    ref.watch(separationRemoteDataSourceProvider),
  );
});
