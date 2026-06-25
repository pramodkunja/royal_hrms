import 'package:flutter/material.dart';

/// Categorical data-visualization palette, distinct from [AppColors]
/// (brand/semantic UI colors). Charts pick colors from here so every
/// chart in the app stays visually consistent.
class AppChartColors {
  const AppChartColors._();

  static const Color hires = Color(0xFF7B93C4);
  static const Color exits = Color(0xFFE9A4A8);

  static const List<Color> categorical = [
    Color(0xFF6E8FC2),
    Color(0xFFE4C158),
    Color(0xFF8FCBA0),
    Color(0xFF4FB3B0),
    Color(0xFFB79AD9),
  ];
}
