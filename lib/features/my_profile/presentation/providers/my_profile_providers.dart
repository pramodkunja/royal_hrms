import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_client.dart';
import '../../data/datasource/my_profile_remote_datasource.dart';
import '../../data/repositories/my_profile_repository_impl.dart';
import '../../domain/repositories/my_profile_repository.dart';

final myProfileRemoteDataSourceProvider = Provider<MyProfileRemoteDataSource>((
  ref,
) {
  return MyProfileRemoteDataSourceImpl(ref.watch(apiClientProvider));
});

final myProfileRepositoryProvider = Provider<MyProfileRepository>((ref) {
  return MyProfileRepositoryImpl(ref.watch(myProfileRemoteDataSourceProvider));
});
