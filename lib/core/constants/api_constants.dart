class ApiConstants {
  const ApiConstants._();

  static const String baseUrl = 'http://192.168.0.149:7000/api';

  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

  static const String authorizationHeader = 'Authorization';
  static const String contentTypeHeader = 'Content-Type';
  static const String bearerPrefix = 'Bearer';
  static const String applicationJson = 'application/json';

  static const String loginEndpoint = '/login/';
  static const String logoutEndpoint = '/logout/';
  static const String forgotPasswordEndpoint = '/forgot-password/';
  static const String verifyResetOtpEndpoint = '/verify-otp/';
  static const String resetPasswordEndpoint = '/reset-password/';

  /// Not yet provided by the backend — the auth interceptor's refresh
  /// flow is wired but will fail safely (forcing logout) until this is
  /// updated to the real path.
  static const String refreshTokenEndpoint = '/token/refresh/';
}
