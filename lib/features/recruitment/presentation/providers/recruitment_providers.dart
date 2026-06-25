import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_client.dart';
import '../../data/datasource/recruitment_remote_datasource.dart';
import '../../data/repositories/recruitment_repository_impl.dart';
import '../../domain/repositories/recruitment_repository.dart';

final recruitmentRemoteDataSourceProvider =
    Provider<RecruitmentRemoteDataSource>((ref) {
      return RecruitmentRemoteDataSourceImpl(ref.watch(apiClientProvider));
    });

final recruitmentRepositoryProvider = Provider<RecruitmentRepository>((ref) {
  return RecruitmentRepositoryImpl(
    ref.watch(recruitmentRemoteDataSourceProvider),
  );
});
