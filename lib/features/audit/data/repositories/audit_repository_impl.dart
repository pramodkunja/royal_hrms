import '../../domain/repositories/audit_repository.dart';
import '../datasource/audit_remote_datasource.dart';

class AuditRepositoryImpl implements AuditRepository {
  AuditRepositoryImpl(this._remoteDataSource);

  final AuditRemoteDataSource _remoteDataSource;

  AuditRemoteDataSource get remoteDataSource => _remoteDataSource;
}
