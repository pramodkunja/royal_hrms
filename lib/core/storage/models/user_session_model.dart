import 'package:freezed_annotation/freezed_annotation.dart';

import '../../constants/enums.dart';

part 'user_session_model.freezed.dart';
part 'user_session_model.g.dart';

@freezed
abstract class UserSessionModel with _$UserSessionModel {
  const factory UserSessionModel({
    required String userId,
    required String name,
    required String email,
    required UserRole role,
  }) = _UserSessionModel;

  factory UserSessionModel.fromJson(Map<String, dynamic> json) =>
      _$UserSessionModelFromJson(json);
}
