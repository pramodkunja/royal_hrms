import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_session_model.freezed.dart';
part 'user_session_model.g.dart';

@freezed
abstract class UserSessionModel with _$UserSessionModel {
  const factory UserSessionModel({
    required String userId,
    required String name,
    required String email,
    required String role,
    required String roleDisplay,
    @Default(<String>[]) List<String> permissions,
  }) = _UserSessionModel;

  factory UserSessionModel.fromJson(Map<String, dynamic> json) =>
      _$UserSessionModelFromJson(json);
}
