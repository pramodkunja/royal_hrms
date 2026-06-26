import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../../../../services/auth_storage.dart';
import '../models/auth_user_model.dart';
import '../models/password_reset_challenge_model.dart';
import '../../../../shared/models/api_response.dart';

abstract class AuthRemoteDataSource {
  Future<AuthUserModel> login({
    required String email,
    required String password,
  });

  Future<void> requestPasswordResetOtp({required String email});

  Future<PasswordResetChallengeModel> verifyPasswordResetOtp({
    required String email,
    required String otp,
  });

  Future<void> resetPassword({
    required String resetToken,
    required String newPassword,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<AuthUserModel> login({
    required String email,
    required String password,
  }) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      ApiConstants.loginEndpoint,
      data: {'email': email, 'password': password},
    );
    final body = response.data!;
    // ignore: avoid_print
    print('LOGIN RESPONSE BODY: $body');

    // Unwrap envelope {"status":"success","data":{"user":{...}}}
    final data =
        body['data'] is Map ? body['data'] as Map<String, dynamic> : body;

    final accessToken = data['access'] as String? ?? '';
    final refreshToken = data['refresh'] as String? ?? '';
    if (accessToken.isNotEmpty && refreshToken.isNotEmpty) {
      await saveTokens(accessToken, refreshToken);
    }

    final userMap =
        data['user'] is Map ? data['user'] as Map<String, dynamic> : data;

    return AuthUserModel.fromJson(_sanitizeUser(userMap));
  }

  /// Normalises the user payload so all required String fields are
  /// non-null even if the backend omits or nullifies optional ones.
  Map<String, dynamic> _sanitizeUser(Map<String, dynamic> json) {
    return {
      'id': (json['id'] ?? '').toString(),
      'full_name':
          (json['full_name'] ?? json['name'] ?? '').toString(),
      'email': (json['email'] ?? '').toString(),
      'role': (json['role'] ?? '').toString(),
      'role_display':
          (json['role_display'] ?? json['role'] ?? '').toString(),
      'permissions': json['permissions'] is List
          ? (json['permissions'] as List).whereType<String>().toList()
          : <String>[],
    };
  }

  @override
  Future<void> requestPasswordResetOtp({required String email}) async {
    await _apiClient.post<Map<String, dynamic>>(
      ApiConstants.forgotPasswordEndpoint,
      data: {'email': email},
    );
  }

  @override
  Future<PasswordResetChallengeModel> verifyPasswordResetOtp({
    required String email,
    required String otp,
  }) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      ApiConstants.verifyResetOtpEndpoint,
      data: {'email': email, 'otp': otp},
    );
    final envelope = ApiResponse<PasswordResetChallengeModel>.fromJson(
      response.data!,
      (json) =>
          PasswordResetChallengeModel.fromJson(json! as Map<String, dynamic>),
    );
    return envelope.data!;
  }

  @override
  Future<void> resetPassword({
    required String resetToken,
    required String newPassword,
  }) async {
    await _apiClient.post<Map<String, dynamic>>(
      ApiConstants.resetPasswordEndpoint,
      data: {
        'reset_token': resetToken,
        'new_password': newPassword,
        'confirm_password': newPassword,
      },
    );
  }
}
