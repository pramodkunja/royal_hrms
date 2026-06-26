import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/theme/app_colors.dart';
import 'permission_cell.dart';
import 'permission_matrix_data.dart';

class PermissionsDesktopTable extends StatelessWidget {
  const PermissionsDesktopTable({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final headerBg = isDark ? AppColors.darkFieldFill : const Color(0xFFF0F3FA);
    final surfaceBg = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final altBg = isDark ? const Color(0xFF1E2438) : const Color(0xFFF9FAFE);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          _TableHeader(bg: headerBg, borderColor: borderColor, isDark: isDark),
          ...kPermissionMatrix.asMap().entries.map((e) => _TableRow(
            row: e.value,
            bg: e.key.isEven ? surfaceBg : altBg,
            borderColor: borderColor,
            isDark: isDark,
            isLast: e.key == kPermissionMatrix.length - 1,
          )),
        ],
      ),
    );
  }
}

class _TableHeader extends StatelessWidget {
  const _TableHeader({
    required this.bg,
    required this.borderColor,
    required this.isDark,
  });

  final Color bg, borderColor;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final style = GoogleFonts.poppins(
      fontSize: 11,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.6,
      color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
    );
    return Container(
      color: bg,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: borderColor)),
      ),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text('MODULE / FEATURE', style: style)),
          ...kRoles.map(
            (r) => Expanded(
              flex: 2,
              child: Center(
                child: Text(r.toUpperCase(), style: style, textAlign: TextAlign.center),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TableRow extends StatelessWidget {
  const _TableRow({
    required this.row,
    required this.bg,
    required this.borderColor,
    required this.isDark,
    required this.isLast,
  });

  final PermissionRow row;
  final Color bg, borderColor;
  final bool isDark, isLast;

  @override
  Widget build(BuildContext context) {
    final featureStyle = GoogleFonts.poppins(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface,
    );
    return Container(
      color: bg,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: isLast
          ? null
          : BoxDecoration(border: Border(bottom: BorderSide(color: borderColor))),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text(row.feature, style: featureStyle)),
          ...row.values.map(
            (v) => Expanded(
              flex: 2,
              child: Center(child: PermissionCell(value: v, isDark: isDark)),
            ),
          ),
        ],
      ),
    );
  }
}
