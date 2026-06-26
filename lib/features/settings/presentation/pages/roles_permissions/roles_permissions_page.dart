import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/extensions.dart';
import '../../widgets/roles_permissions/permissions_desktop_table.dart';
import '../../widgets/roles_permissions/permissions_mobile_cards.dart';

class RolesPermissionsPage extends StatelessWidget {
  const RolesPermissionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;
    final isMobile = context.screenSize.width < 600;
    final scaffoldBg = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final surfaceBg = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final mutedColor = isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: isMobile
          ? AppBar(
              backgroundColor: surfaceBg,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_rounded),
                onPressed: () => context.pop(),
              ),
              title: Text(
                'Roles & Permissions',
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            )
          : null,
      body: ListView(
        children: [
          if (!isMobile)
            _DesktopBreadcrumb(
              surfaceBg: surfaceBg,
              borderColor: borderColor,
              isDark: isDark,
            ),
          Padding(
            padding: EdgeInsets.fromLTRB(isMobile ? 16 : 24, 24, isMobile ? 16 : 24, 12),
            child: _SectionHeader(isDark: isDark, mutedColor: mutedColor),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(isMobile ? 16 : 24, 4, isMobile ? 16 : 24, 36),
            child: isMobile
                ? const PermissionsMobileCards()
                : const PermissionsDesktopTable(),
          ),
        ],
      ),
    );
  }
}

class _DesktopBreadcrumb extends StatelessWidget {
  const _DesktopBreadcrumb({
    required this.surfaceBg,
    required this.borderColor,
    required this.isDark,
  });

  final Color surfaceBg, borderColor;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final mutedColor = isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;
    final onSurface = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;

    return Container(
      color: surfaceBg,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: borderColor)),
      ),
      child: Row(
        children: [
          TextButton.icon(
            onPressed: () => context.pop(),
            icon: Icon(Icons.arrow_back_rounded, size: 15, color: AppColors.primary),
            label: Text(
              'Back to Settings',
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
            ),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            ),
          ),
          const SizedBox(width: 6),
          Icon(Icons.chevron_right_rounded, size: 18, color: mutedColor),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: AppColors.emailCategoryDocument.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.shield_outlined,
              size: 15,
              color: AppColors.emailCategoryDocument,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'Users & Permissions',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.isDark, required this.mutedColor});

  final bool isDark;
  final Color mutedColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Users & Permissions',
          style: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 4),
        Text(
          'Control what each role can access across all modules',
          style: context.textTheme.bodySmall?.copyWith(color: mutedColor),
        ),
      ],
    );
  }
}
