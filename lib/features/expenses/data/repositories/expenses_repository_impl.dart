import '../../domain/repositories/expenses_repository.dart';
import '../datasource/expenses_remote_datasource.dart';

class ExpensesRepositoryImpl implements ExpensesRepository {
  ExpensesRepositoryImpl(this._remoteDataSource);

  final ExpensesRemoteDataSource _remoteDataSource;

  ExpensesRemoteDataSource get remoteDataSource => _remoteDataSource;
}
