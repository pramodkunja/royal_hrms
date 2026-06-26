import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/theme/app_colors.dart';
import 'permission_matrix_data.dart';

class PermissionCell extends StatelessWidget {
  const PermissionCell({super.key, required this.value, this.isDark = false});

  final String value;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    if (value == kPermFull) {
      return Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: AppColors.success.withValues(alpha: 0.13),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.check_rounded, size: 14, color: AppColors.success),
      );
    }

    if (value == kPermNone) {
      return Text(
        '—',
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
        ),
      );
    }

    // Text badge (Team only, Self only, All, Own, etc.)
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.22)),
      ),
      child: Text(
        value,
        style: GoogleFonts.poppins(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
