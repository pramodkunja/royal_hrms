import 'package:flutter/material.dart';

/// Centralized color palette. All UI should reference these constants
/// rather than hard-coding colors, so the palette can evolve from one
/// place as the design system matures.
class AppColors {
  const AppColors._();

  static const Color primary = Color(0xFF2F4B7C);
  static const Color primaryLight = Color(0xFF5B7CAE);
  static const Color primaryDark = Color(0xFF1E3358);

  static const Color secondary = Color(0xFFFFB300);
  static const Color secondaryLight = Color(0xFFFFE54C);
  static const Color secondaryDark = Color(0xFFC68400);

  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFF9A825);
  static const Color error = Color(0xFFC62828);
  static const Color info = Color(0xFF0277BD);

  static const Color lightBackground = Color(0xFFF4F6FB);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightFieldFill = Color(0xFFEEF1F8);
  static const Color lightOnSurface = Color(0xFF1A2233);
  static const Color lightTextMuted = Color(0xFF5B6478);
  static const Color lightBorder = Color(0xFFDCE1ED);

  static const Color darkBackground = Color(0xFF10131C);
  static const Color darkSurface = Color(0xFF1B2030);
  static const Color darkFieldFill = Color(0xFF242A3C);
  static const Color darkOnSurface = Color(0xFFE7EAF2);
  static const Color darkTextMuted = Color(0xFFA4ACC2);
  static const Color darkBorder = Color(0xFF333B52);

  static const Color emailCategoryDocument = Color(0xFF1A5276);
  static const Color emailCategoryNotification = Color(0xFF167B70);
  static const Color emailCategoryReminder = Color(0xFFBF7A20);
  static const Color emailCategoryWish = Color(0xFF2D7A42);

  /// Background fill for {VARIABLE} badges in the email template live preview.
  static const Color emailVarBadgeFill = Color(0xFFFFF3E0);
}
