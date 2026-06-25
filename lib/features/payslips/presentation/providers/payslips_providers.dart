import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_client.dart';
import '../../data/datasource/payslips_remote_datasource.dart';
import '../../data/repositories/payslips_repository_impl.dart';
import '../../domain/repositories/payslips_repository.dart';

final payslipsRemoteDataSourceProvider = Provider<PayslipsRemoteDataSource>((
  ref,
) {
  return PayslipsRemoteDataSourceImpl(ref.watch(apiClientProvider));
});

final payslipsRepositoryProvider = Provider<PayslipsRepository>((ref) {
  return PayslipsRepositoryImpl(ref.watch(payslipsRemoteDataSourceProvider));
});
