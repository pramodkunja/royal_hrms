import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/auth_user.dart';

part 'auth_user_model.freezed.dart';
part 'auth_user_model.g.dart';

@freezed
abstract class AuthUserModel with _$AuthUserModel {
  const AuthUserModel._();

  const factory AuthUserModel({
    required String id,
    @JsonKey(name: 'full_name') required String name,
    required String email,
    required String role,
    @JsonKey(name: 'role_display') required String roleDisplay,
    @Default(<String>[]) List<String> permissions,
  }) = _AuthUserModel;

  factory AuthUserModel.fromJson(Map<String, dynamic> json) =>
      _$AuthUserModelFromJson(json);

  AuthUser toEntity() => AuthUser(
    id: id,
    name: name,
    email: email,
    role: role,
    roleDisplay: roleDisplay,
    permissions: permissions,
  );
}
