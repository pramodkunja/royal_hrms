import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/smtp_config.dart';
import 'settings_providers.dart';
import 'smtp_form_state.dart';

// ---------------------------------------------------------------------------
// List provider — FutureProvider keeps it consistent with the project pattern
// and avoids AsyncNotifier rebuild races in Riverpod 3.x.
// Invalidated by SmtpFormNotifier after every mutating operation.
// ---------------------------------------------------------------------------

final smtpConfigsProvider = FutureProvider<List<SmtpConfig>>((ref) async {
  return ref.read(settingsRepositoryProvider).getSmtpConfigs();
});

// ---------------------------------------------------------------------------
// Form notifier — handles create / update / delete / setActive / test
// ---------------------------------------------------------------------------

class SmtpFormNotifier extends Notifier<SmtpFormState> {
  @override
  SmtpFormState build() => const SmtpFormState();

  Future<void> createSmtpConfig(Map<String, dynamic> data) async {
    state = const SmtpFormState(status: SmtpFormStatus.submitting);
    try {
      await ref.read(settingsRepositoryProvider).createSmtpConfig(data);
      ref.invalidate(smtpConfigsProvider);
      state = const SmtpFormState(status: SmtpFormStatus.success);
    } on AppException catch (e) {
      state = SmtpFormState(
        status: SmtpFormStatus.failure,
        failure: Failure.fromException(e),
      );
    } catch (e) {
      state = SmtpFormState(
        status: SmtpFormStatus.failure,
        failure: Failure.unknown(e.toString()),
      );
    }
  }

  Future<void> updateSmtpConfig(String id, Map<String, dynamic> data) async {
    state = const SmtpFormState(status: SmtpFormStatus.submitting);
    try {
      await ref.read(settingsRepositoryProvider).updateSmtpConfig(id, data);
      ref.invalidate(smtpConfigsProvider);
      state = const SmtpFormState(status: SmtpFormStatus.success);
    } on AppException catch (e) {
      state = SmtpFormState(
        status: SmtpFormStatus.failure,
        failure: Failure.fromException(e),
      );
    } catch (e) {
      state = SmtpFormState(
        status: SmtpFormStatus.failure,
        failure: Failure.unknown(e.toString()),
      );
    }
  }

  Future<void> deleteSmtpConfig(String id) async {
    state = const SmtpFormState(status: SmtpFormStatus.submitting);
    try {
      await ref.read(settingsRepositoryProvider).deleteSmtpConfig(id);
      ref.invalidate(smtpConfigsProvider);
      state = const SmtpFormState(status: SmtpFormStatus.success);
    } on AppException catch (e) {
      state = SmtpFormState(
        status: SmtpFormStatus.failure,
        failure: Failure.fromException(e),
      );
    } catch (e) {
      state = SmtpFormState(
        status: SmtpFormStatus.failure,
        failure: Failure.unknown(e.toString()),
      );
    }
  }

  Future<void> setSmtpConfigActive(String id) async {
    state = const SmtpFormState(status: SmtpFormStatus.submitting);
    try {
      await ref.read(settingsRepositoryProvider).setSmtpConfigActive(id);
      ref.invalidate(smtpConfigsProvider);
      state = const SmtpFormState(status: SmtpFormStatus.success);
    } on AppException catch (e) {
      state = SmtpFormState(
        status: SmtpFormStatus.failure,
        failure: Failure.fromException(e),
      );
    } catch (e) {
      state = SmtpFormState(
        status: SmtpFormStatus.failure,
        failure: Failure.unknown(e.toString()),
      );
    }
  }

  Future<void> testSmtpConfig(String id) async {
    state = const SmtpFormState(status: SmtpFormStatus.submitting);
    try {
      await ref.read(settingsRepositoryProvider).testSmtpConfig(id);
      state = const SmtpFormState(status: SmtpFormStatus.success);
    } on AppException catch (e) {
      state = SmtpFormState(
        status: SmtpFormStatus.failure,
        failure: Failure.fromException(e),
      );
    } catch (e) {
      state = SmtpFormState(
        status: SmtpFormStatus.failure,
        failure: Failure.unknown(e.toString()),
      );
    }
  }

  void reset() => state = const SmtpFormState();
}

final smtpFormNotifierProvider =
    NotifierProvider<SmtpFormNotifier, SmtpFormState>(SmtpFormNotifier.new);
