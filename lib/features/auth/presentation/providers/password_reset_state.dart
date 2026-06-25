import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/errors/failures.dart';

part 'password_reset_state.freezed.dart';

enum PasswordResetPhase { idle, submitting, failure }

@freezed
abstract class PasswordResetState with _$PasswordResetState {
  const factory PasswordResetState({
    @Default(PasswordResetPhase.idle) PasswordResetPhase phase,
    String? email,
    String? resetToken,
    @Default(false) bool isComplete,
    Failure? failure,
  }) = _PasswordResetState;
}
