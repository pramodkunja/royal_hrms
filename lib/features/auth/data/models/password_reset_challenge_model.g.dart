// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_reset_challenge_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PasswordResetChallengeModel _$PasswordResetChallengeModelFromJson(
  Map<String, dynamic> json,
) => _PasswordResetChallengeModel(
  email: json['email'] as String,
  resetToken: json['reset_token'] as String,
);

Map<String, dynamic> _$PasswordResetChallengeModelToJson(
  _PasswordResetChallengeModel instance,
) => <String, dynamic>{
  'email': instance.email,
  'reset_token': instance.resetToken,
};
