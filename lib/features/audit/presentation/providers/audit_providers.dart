import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_client.dart';
import '../../data/datasource/audit_remote_datasource.dart';
import '../../data/repositories/audit_repository_impl.dart';
import '../../domain/repositories/audit_repository.dart';

final auditRemoteDataSourceProvider = Provider<AuditRemoteDataSource>((ref) {
  return AuditRemoteDataSourceImpl(ref.watch(apiClientProvider));
});

final auditRepositoryProvider = Provider<AuditRepository>((ref) {
  return AuditRepositoryImpl(ref.watch(auditRemoteDataSourceProvider));
});
