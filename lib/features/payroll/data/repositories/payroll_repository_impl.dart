import '../../domain/repositories/payroll_repository.dart';
import '../datasource/payroll_remote_datasource.dart';

class PayrollRepositoryImpl implements PayrollRepository {
  PayrollRepositoryImpl(this._remoteDataSource);

  final PayrollRemoteDataSource _remoteDataSource;

  PayrollRemoteDataSource get remoteDataSource => _remoteDataSource;
}
