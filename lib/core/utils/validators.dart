/// Generic, feature-agnostic form field validators returning a
/// human-readable error message, or `null` when the value is valid.
class Validators {
  const Validators._();

  static final RegExp _emailPattern = RegExp(
    r'^[\w\.\-]+@([\w\-]+\.)+[\w\-]{2,}$',
  );

  static String? required(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    if (!_emailPattern.hasMatch(value.trim())) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? minLength(
    String? value,
    int length, {
    String fieldName = 'This field',
  }) {
    if (value == null || value.length < length) {
      return '$fieldName must be at least $length characters';
    }
    return null;
  }

  static String? otp(String? value, {int length = 6}) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter the $length-digit code';
    }
    if (!RegExp('^\\d{$length}\$').hasMatch(value.trim())) {
      return 'Enter a valid $length-digit code';
    }
    return null;
  }

  static String? confirmPassword(String? value, String original) {
    if (value == null || value.isEmpty) return 'Please confirm your password';
    if (value != original) return 'Passwords do not match';
    return null;
  }

  static final RegExp _upperPattern = RegExp(r'[A-Z]');
  static final RegExp _lowerPattern = RegExp(r'[a-z]');
  static final RegExp _digitPattern = RegExp(r'\d');
  static final RegExp _specialPattern = RegExp(
    r'[!@#$%^&*(),.?":{}|<>_\-+=\[\]~`]',
  );

  /// Enforces the backend's password policy: 8+ characters, with at
  /// least one uppercase letter, lowercase letter, digit, and symbol.
  static String? strongPassword(
    String? value, {
    String fieldName = 'Password',
  }) {
    if (value == null || value.isEmpty) return '$fieldName is required';
    if (value.length < 8) return '$fieldName must be at least 8 characters';
    final hasUpper = _upperPattern.hasMatch(value);
    final hasLower = _lowerPattern.hasMatch(value);
    final hasDigit = _digitPattern.hasMatch(value);
    final hasSpecial = _specialPattern.hasMatch(value);
    if (!hasUpper || !hasLower || !hasDigit || !hasSpecial) {
      return '$fieldName must include an uppercase letter, lowercase letter, number, and symbol';
    }
    return null;
  }
}
