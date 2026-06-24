/// Generic, feature-agnostic form field validators returning a
/// human-readable error message, or `null` when the value is valid.
class Validators {
  const Validators._();

  static final RegExp _emailPattern = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[\w\-]{2,}$');

  static String? required(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    if (!_emailPattern.hasMatch(value.trim())) return 'Enter a valid email address';
    return null;
  }

  static String? minLength(String? value, int length, {String fieldName = 'This field'}) {
    if (value == null || value.length < length) {
      return '$fieldName must be at least $length characters';
    }
    return null;
  }
}
