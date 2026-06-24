import 'package:flutter/material.dart';

/// Centralized color palette. All UI should reference these constants
/// rather than hard-coding colors, so the palette can evolve from one
/// place as the design system matures.
class AppColors {
  const AppColors._();

  static const Color primary = Color(0xFF1B5E20);
  static const Color primaryLight = Color(0xFF4C8C4A);
  static const Color primaryDark = Color(0xFF003300);

  static const Color secondary = Color(0xFFFFB300);
  static const Color secondaryLight = Color(0xFFFFE54C);
  static const Color secondaryDark = Color(0xFFC68400);

  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFF9A825);
  static const Color error = Color(0xFFC62828);
  static const Color info = Color(0xFF0277BD);

  static const Color lightBackground = Color(0xFFF7F8FA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightOnSurface = Color(0xFF1A1C1E);
  static const Color lightBorder = Color(0xFFE0E2E5);

  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkOnSurface = Color(0xFFE3E3E3);
  static const Color darkBorder = Color(0xFF333333);
}
