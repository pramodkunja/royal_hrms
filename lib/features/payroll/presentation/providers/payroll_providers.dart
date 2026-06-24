import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_client.dart';
import '../../data/datasource/payroll_remote_datasource.dart';
import '../../data/repositories/payroll_repository_impl.dart';
import '../../domain/repositories/payroll_repository.dart';

final payrollRemoteDataSourceProvider = Provider<PayrollRemoteDataSource>((ref) {
  return PayrollRemoteDataSourceImpl(ref.watch(apiClientProvider));
});

final payrollRepositoryProvider = Provider<PayrollRepository>((ref) {
  return PayrollRepositoryImpl(ref.watch(payrollRemoteDataSourceProvider));
});
