import '../../domain/repositories/payslips_repository.dart';
import '../datasource/payslips_remote_datasource.dart';

class PayslipsRepositoryImpl implements PayslipsRepository {
  PayslipsRepositoryImpl(this._remoteDataSource);

  final PayslipsRemoteDataSource _remoteDataSource;

  PayslipsRemoteDataSource get remoteDataSource => _remoteDataSource;
}
