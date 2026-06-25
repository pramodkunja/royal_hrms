import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/password_reset_challenge.dart';

part 'password_reset_challenge_model.freezed.dart';
part 'password_reset_challenge_model.g.dart';

@freezed
abstract class PasswordResetChallengeModel with _$PasswordResetChallengeModel {
  const PasswordResetChallengeModel._();

  const factory PasswordResetChallengeModel({
    required String email,
    @JsonKey(name: 'reset_token') required String resetToken,
  }) = _PasswordResetChallengeModel;

  factory PasswordResetChallengeModel.fromJson(Map<String, dynamic> json) =>
      _$PasswordResetChallengeModelFromJson(json);

  PasswordResetChallenge toEntity() =>
      PasswordResetChallenge(email: email, resetToken: resetToken);
}
