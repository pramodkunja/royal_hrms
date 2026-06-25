import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_client.dart';
import '../../data/datasource/employees_remote_datasource.dart';
import '../../data/repositories/employees_repository_impl.dart';
import '../../domain/repositories/employees_repository.dart';

final employeesRemoteDataSourceProvider = Provider<EmployeesRemoteDataSource>((
  ref,
) {
  return EmployeesRemoteDataSourceImpl(ref.watch(apiClientProvider));
});

final employeesRepositoryProvider = Provider<EmployeesRepository>((ref) {
  return EmployeesRepositoryImpl(ref.watch(employeesRemoteDataSourceProvider));
});
