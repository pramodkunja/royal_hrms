import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/theme/app_colors.dart';
import 'permission_cell.dart';
import 'permission_matrix_data.dart';

class PermissionsMobileCards extends StatelessWidget {
  const PermissionsMobileCards({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final surfaceBg = isDark ? AppColors.darkSurface : AppColors.lightSurface;

    return Container(
      decoration: BoxDecoration(
        color: surfaceBg,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          _SectionHeader(isDark: isDark, borderColor: borderColor),
          ...kPermissionMatrix.asMap().entries.map((e) => _ModuleCard(
            row: e.value,
            borderColor: borderColor,
            isDark: isDark,
            isLast: e.key == kPermissionMatrix.length - 1,
          )),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.isDark, required this.borderColor});
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
        Text('${kPermissionMatrix.length} modules', style: GoogleFonts.poppins(fontSize: 11, color: mutedColor)),
      ]),
    );
  }
}

class _ModuleCard extends StatelessWidget {
  const _ModuleCard({required this.row, required this.borderColor, required this.isDark, required this.isLast});
  final MatrixRow row;
  final Color borderColor;
  final bool isDark, isLast;

  @override
  Widget build(BuildContext context) {
    final onSurface = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final mutedColor = isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;
    final altBg = isDark ? const Color(0xFF1E2438) : const Color(0xFFF8FAFC);

    return Container(
      decoration: isLast ? null : BoxDecoration(border: Border(bottom: BorderSide(color: borderColor))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Module header
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Row(children: [
            Icon(row.icon, size: 15, color: mutedColor),
            const SizedBox(width: 8),
            Text(row.module, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w700, color: onSurface)),
          ]),
        ),
        // Role rows
        ...List.generate(kRolesList.length, (i) => Container(
          color: i.isOdd ? altBg : null,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
          child: Row(children: [
            SizedBox(
              width: 96,
              child: Text(
                kRolesList[i].name,
                style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w500, color: mutedColor),
              ),
            ),
            const SizedBox(width: 12),
            PermissionCell(value: row.values[i], isDark: isDark),
          ]),
        )),
        const SizedBox(height: 4),
      ]),
    );
  }
}
