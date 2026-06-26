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
    final surfaceBg = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final headerBg = isDark ? AppColors.darkFieldFill : const Color(0xFFF8FAFC);
    final altBg = isDark ? const Color(0xFF1E2438) : const Color(0xFFF9FAFE);

    return Container(
      decoration: BoxDecoration(
        color: surfaceBg,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          _SectionTitle(isDark: isDark, borderColor: borderColor),
          _MatrixHeader(bg: headerBg, borderColor: borderColor, isDark: isDark),
          ...kPermissionMatrix.asMap().entries.map((e) => _MatrixRow(
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

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.isDark, required this.borderColor});
  final bool isDark;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    final onSurface = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final mutedColor = isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: borderColor))),
      child: Row(children: [
        Icon(Icons.grid_on_outlined, size: 16, color: mutedColor),
        const SizedBox(width: 8),
        Text('Permission Matrix', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: onSurface)),
        const Spacer(),
        Text(
          '${kPermissionMatrix.length} modules · ${kRolesList.length} roles',
          style: GoogleFonts.poppins(fontSize: 11, color: mutedColor),
        ),
      ]),
    );
  }
}

class _MatrixHeader extends StatelessWidget {
  const _MatrixHeader({required this.bg, required this.borderColor, required this.isDark});
  final Color bg, borderColor;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final mutedColor = isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;
    final onSurface = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    return Container(
      color: bg,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: borderColor))),
      child: Row(children: [
        Expanded(
          flex: 3,
          child: Text('MODULE', style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 0.5, color: mutedColor)),
        ),
        ...kRolesList.map((r) => Expanded(
          flex: 2,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(r.name.toUpperCase(), style: GoogleFonts.poppins(fontSize: 9, fontWeight: FontWeight.w700, letterSpacing: 0.4, color: onSurface)),
            Text('${r.permCount} perms', style: GoogleFonts.poppins(fontSize: 9, color: mutedColor)),
          ]),
        )),
      ]),
    );
  }
}

class _MatrixRow extends StatelessWidget {
  const _MatrixRow({required this.row, required this.bg, required this.borderColor, required this.isDark, required this.isLast});
  final MatrixRow row;
  final Color bg, borderColor;
  final bool isDark, isLast;

  @override
  Widget build(BuildContext context) {
    final onSurface = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final mutedColor = isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;
    return Container(
      color: bg,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: isLast ? null : BoxDecoration(border: Border(bottom: BorderSide(color: borderColor))),
      child: Row(children: [
        Expanded(
          flex: 3,
          child: Row(children: [
            Icon(row.icon, size: 14, color: mutedColor),
            const SizedBox(width: 8),
            Expanded(child: Text(row.module, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: onSurface))),
          ]),
        ),
        ...row.values.map((v) => Expanded(
          flex: 2,
          child: PermissionCell(value: v, isDark: isDark),
        )),
      ]),
    );
  }
}
