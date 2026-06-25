import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/errors/failures.dart';

part 'smtp_form_state.freezed.dart';

enum SmtpFormStatus { initial, submitting, success, failure }

@freezed
abstract class SmtpFormState with _$SmtpFormState {
  const factory SmtpFormState({
    @Default(SmtpFormStatus.initial) SmtpFormStatus status,
    Failure? failure,
  }) = _SmtpFormState;
}
