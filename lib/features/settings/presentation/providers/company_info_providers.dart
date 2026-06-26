import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/company_info.dart';
import '../../domain/repositories/settings_repository.dart';
import 'settings_providers.dart';

class CompanyInfoNotifier extends AsyncNotifier<CompanyInfo> {
  SettingsRepository get _repo => ref.read(settingsRepositoryProvider);

  @override
  Future<CompanyInfo> build() {
    return _repo.getCompanyInfo().catchError((_) => const CompanyInfo());
  }

  Future<bool> save(CompanyInfo info, {Uint8List? logoBytes}) async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(
      () => _repo.updateCompanyInfo(info, logoBytes: logoBytes),
    );
    state = result.hasValue ? result : AsyncData(info);
    return result.hasValue;
  }
}

final companyInfoProvider =
    AsyncNotifierProvider<CompanyInfoNotifier, CompanyInfo>(
  CompanyInfoNotifier.new,
);
