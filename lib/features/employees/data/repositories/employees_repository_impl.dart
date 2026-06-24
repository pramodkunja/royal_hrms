import '../../domain/repositories/employees_repository.dart';
import '../datasource/employees_remote_datasource.dart';

class EmployeesRepositoryImpl implements EmployeesRepository {
  EmployeesRepositoryImpl(this._remoteDataSource);

  final EmployeesRemoteDataSource _remoteDataSource;

  EmployeesRemoteDataSource get remoteDataSource => _remoteDataSource;
}
