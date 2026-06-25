import '../../domain/repositories/recruitment_repository.dart';
import '../datasource/recruitment_remote_datasource.dart';

class RecruitmentRepositoryImpl implements RecruitmentRepository {
  RecruitmentRepositoryImpl(this._remoteDataSource);

  final RecruitmentRemoteDataSource _remoteDataSource;

  RecruitmentRemoteDataSource get remoteDataSource => _remoteDataSource;
}
