import 'package:freezed_annotation/freezed_annotation.dart';

part 'password_reset_challenge.freezed.dart';

/// Issued after a one-time code is verified; authorizes the subsequent
/// call to actually change the password without re-sending the code.
@freezed
abstract class PasswordResetChallenge with _$PasswordResetChallenge {
  const factory PasswordResetChallenge({
    required String email,
    required String resetToken,
  }) = _PasswordResetChallenge;
}
