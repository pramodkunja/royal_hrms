import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_client.dart';
import '../../data/datasource/expenses_remote_datasource.dart';
import '../../data/repositories/expenses_repository_impl.dart';
import '../../domain/repositories/expenses_repository.dart';

final expensesRemoteDataSourceProvider = Provider<ExpensesRemoteDataSource>((
  ref,
) {
  return ExpensesRemoteDataSourceImpl(ref.watch(apiClientProvider));
});

final expensesRepositoryProvider = Provider<ExpensesRepository>((ref) {
  return ExpensesRepositoryImpl(ref.watch(expensesRemoteDataSourceProvider));
});
