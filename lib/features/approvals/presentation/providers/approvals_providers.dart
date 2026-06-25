import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_client.dart';
import '../../data/datasource/approvals_remote_datasource.dart';
import '../../data/repositories/approvals_repository_impl.dart';
import '../../domain/repositories/approvals_repository.dart';

final approvalsRemoteDataSourceProvider = Provider<ApprovalsRemoteDataSource>((
  ref,
) {
  return ApprovalsRemoteDataSourceImpl(ref.watch(apiClientProvider));
});

final approvalsRepositoryProvider = Provider<ApprovalsRepository>((ref) {
  return ApprovalsRepositoryImpl(ref.watch(approvalsRemoteDataSourceProvider));
});
