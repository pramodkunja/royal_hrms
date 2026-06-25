import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_client.dart';
import '../../data/datasource/branches_remote_datasource.dart';
import '../../data/repositories/branches_repository_impl.dart';
import '../../domain/repositories/branches_repository.dart';

final branchesRemoteDataSourceProvider = Provider<BranchesRemoteDataSource>((
  ref,
) {
  return BranchesRemoteDataSourceImpl(ref.watch(apiClientProvider));
});

final branchesRepositoryProvider = Provider<BranchesRepository>((ref) {
  return BranchesRepositoryImpl(ref.watch(branchesRemoteDataSourceProvider));
});
