import '../../domain/repositories/referrals_repository.dart';
import '../datasource/referrals_remote_datasource.dart';

class ReferralsRepositoryImpl implements ReferralsRepository {
  ReferralsRepositoryImpl(this._remoteDataSource);

  final ReferralsRemoteDataSource _remoteDataSource;

  ReferralsRemoteDataSource get remoteDataSource => _remoteDataSource;
}
