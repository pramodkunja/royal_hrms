import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_client.dart';
import '../../data/datasource/leave_remote_datasource.dart';
import '../../data/repositories/leave_repository_impl.dart';
import '../../domain/repositories/leave_repository.dart';

final leaveRemoteDataSourceProvider = Provider<LeaveRemoteDataSource>((ref) {
  return LeaveRemoteDataSourceImpl(ref.watch(apiClientProvider));
});

final leaveRepositoryProvider = Provider<LeaveRepository>((ref) {
  return LeaveRepositoryImpl(ref.watch(leaveRemoteDataSourceProvider));
});
