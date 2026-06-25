import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_client.dart';
import '../../data/datasource/org_chart_remote_datasource.dart';
import '../../data/repositories/org_chart_repository_impl.dart';
import '../../domain/repositories/org_chart_repository.dart';

final orgChartRemoteDataSourceProvider = Provider<OrgChartRemoteDataSource>((
  ref,
) {
  return OrgChartRemoteDataSourceImpl(ref.watch(apiClientProvider));
});

final orgChartRepositoryProvider = Provider<OrgChartRepository>((ref) {
  return OrgChartRepositoryImpl(ref.watch(orgChartRemoteDataSourceProvider));
});
