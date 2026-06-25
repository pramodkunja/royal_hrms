import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_client.dart';
import '../../data/datasource/documents_remote_datasource.dart';
import '../../data/repositories/documents_repository_impl.dart';
import '../../domain/repositories/documents_repository.dart';

final documentsRemoteDataSourceProvider = Provider<DocumentsRemoteDataSource>((
  ref,
) {
  return DocumentsRemoteDataSourceImpl(ref.watch(apiClientProvider));
});

final documentsRepositoryProvider = Provider<DocumentsRepository>((ref) {
  return DocumentsRepositoryImpl(ref.watch(documentsRemoteDataSourceProvider));
});
