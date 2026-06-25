import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user.freezed.dart';

@freezed
abstract class AuthUser with _$AuthUser {
  const factory AuthUser({
    required String id,
    required String name,
    required String email,
    required String role,
    required String roleDisplay,
    @Default(<String>[]) List<String> permissions,
  }) = _AuthUser;
}
