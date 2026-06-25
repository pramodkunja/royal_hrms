import '../../domain/repositories/documents_repository.dart';
import '../datasource/documents_remote_datasource.dart';

class DocumentsRepositoryImpl implements DocumentsRepository {
  DocumentsRepositoryImpl(this._remoteDataSource);

  final DocumentsRemoteDataSource _remoteDataSource;

  DocumentsRemoteDataSource get remoteDataSource => _remoteDataSource;
}
