import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_client.dart';
import '../../data/datasource/referrals_remote_datasource.dart';
import '../../data/repositories/referrals_repository_impl.dart';
import '../../domain/repositories/referrals_repository.dart';

final referralsRemoteDataSourceProvider = Provider<ReferralsRemoteDataSource>((
  ref,
) {
  return ReferralsRemoteDataSourceImpl(ref.watch(apiClientProvider));
});

final referralsRepositoryProvider = Provider<ReferralsRepository>((ref) {
  return ReferralsRepositoryImpl(ref.watch(referralsRemoteDataSourceProvider));
});
