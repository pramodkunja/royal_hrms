import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../../../../shared/models/api_response.dart';
import '../models/login_response_model.dart';
import '../models/password_reset_challenge_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login({
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
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      ApiConstants.loginEndpoint,
      data: {'email': email, 'password': password},
    );
    final envelope = ApiResponse<LoginResponseModel>.fromJson(
      response.data!,
      (json) => LoginResponseModel.fromJson(json! as Map<String, dynamic>),
    );
    return envelope.data!;
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
