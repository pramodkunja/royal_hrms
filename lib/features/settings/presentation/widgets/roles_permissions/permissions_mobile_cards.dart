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
    return Column(
      children: kPermissionMatrix
          .map((row) => _FeatureCard(row: row, isDark: isDark))
          .toList(),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({required this.row, required this.isDark});

  final PermissionRow row;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final cardBg = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 13, 16, 10),
            child: Text(
              row.feature,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface,
              ),
            ),
          ),
          Divider(height: 1, color: borderColor),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
            child: Column(
              children: [
                for (int i = 0; i < kRoles.length; i += 2)
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: i + 2 < kRoles.length ? 8 : 0,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: _RolePill(
                            role: kRoles[i],
                            value: row.values[i],
                            isDark: isDark,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: i + 1 < kRoles.length
                              ? _RolePill(
                                  role: kRoles[i + 1],
                                  value: row.values[i + 1],
                                  isDark: isDark,
                                )
                              : const SizedBox(),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RolePill extends StatelessWidget {
  const _RolePill({required this.role, required this.value, required this.isDark});

  final String role, value;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final mutedColor = isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        PermissionCell(value: value, isDark: isDark),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            role,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: mutedColor,
            ),
          ),
        ),
      ],
    );
  }
}
