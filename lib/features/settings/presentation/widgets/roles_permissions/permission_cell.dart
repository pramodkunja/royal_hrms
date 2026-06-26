import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/theme/app_colors.dart';

class PermissionCell extends StatelessWidget {
  const PermissionCell({super.key, required this.value, this.isDark = false});
  final String value;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    if (value == '—') {
      return Text(
        '—',
        style: GoogleFonts.poppins(
          fontSize: 15,
          color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
        ),
      );
    }
    if (value.startsWith('Full')) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFF16A34A).withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF16A34A).withValues(alpha: 0.3)),
        ),
        child: Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF16A34A),
          ),
        ),
      );
    }
    // Comma-separated action chips
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: value.split(',').map((a) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
        ),
        child: Text(
          a.trim(),
          style: GoogleFonts.poppins(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: AppColors.primary,
          ),
        ),
      )).toList(),
    );
  }
}
