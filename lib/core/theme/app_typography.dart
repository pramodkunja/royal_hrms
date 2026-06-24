import 'package:flutter/material.dart';

/// Centralized typography scale shared by both the light and dark themes.
class AppTypography {
  const AppTypography._();

  static TextTheme textTheme(Color color) {
    return TextTheme(
      displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.w400, color: color),
      displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.w400, color: color),
      displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.w400, color: color),
      headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w600, color: color),
      headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: color),
      headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: color),
      titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: color),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: color),
      titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: color),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: color),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: color),
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: color),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: color),
      labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: color),
      labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: color),
    );
  }
}
