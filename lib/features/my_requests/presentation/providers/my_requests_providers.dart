import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_client.dart';
import '../../data/datasource/my_requests_remote_datasource.dart';
import '../../data/repositories/my_requests_repository_impl.dart';
import '../../domain/repositories/my_requests_repository.dart';

final myRequestsRemoteDataSourceProvider = Provider<MyRequestsRemoteDataSource>(
  (ref) {
    return MyRequestsRemoteDataSourceImpl(ref.watch(apiClientProvider));
  },
);

final myRequestsRepositoryProvider = Provider<MyRequestsRepository>((ref) {
  return MyRequestsRepositoryImpl(
    ref.watch(myRequestsRemoteDataSourceProvider),
  );
});
