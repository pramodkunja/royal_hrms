import 'package:intl/intl.dart';

/// Centralized date/time formatting so every feature renders dates the
/// same way instead of scattering `DateFormat` patterns around the app.
class DateFormatter {
  const DateFormatter._();

  static final DateFormat _dateFormat = DateFormat('dd MMM yyyy');
  static final DateFormat _timeFormat = DateFormat('hh:mm a');
  static final DateFormat _dateTimeFormat = DateFormat('dd MMM yyyy, hh:mm a');
  static final DateFormat _isoDateFormat = DateFormat('yyyy-MM-dd');

  static String formatDate(DateTime date) => _dateFormat.format(date);

  static String formatTime(DateTime date) => _timeFormat.format(date);

  static String formatDateTime(DateTime date) => _dateTimeFormat.format(date);

  static String formatIsoDate(DateTime date) => _isoDateFormat.format(date);
}
