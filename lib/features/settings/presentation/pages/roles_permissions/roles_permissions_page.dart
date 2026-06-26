import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../widgets/roles_permissions/add_role_dialog.dart';
import '../../widgets/roles_permissions/permissions_desktop_table.dart';
import '../../widgets/roles_permissions/permissions_mobile_cards.dart';
import '../../widgets/roles_permissions/roles_list_table.dart';

class RolesPermissionsPage extends StatelessWidget {
  const RolesPermissionsPage({super.key});

  void _openAddRole(BuildContext context) {
    showDialog(context: context, builder: (_) => const AddRoleDialog());
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = MediaQuery.sizeOf(context).width < 700;
    final scaffoldBg = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final surfaceBg = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;

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
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: FilledButton.icon(
                    onPressed: () => _openAddRole(context),
                    icon: const Icon(Icons.add_rounded, size: 16),
                    label: Text('Add Role', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                ),
              ],
            )
          : null,
      body: ListView(
        padding: EdgeInsets.fromLTRB(isMobile ? 16 : 24, 0, isMobile ? 16 : 24, 32),
        children: [
          if (!isMobile) _DesktopHeader(surfaceBg: surfaceBg, borderColor: borderColor, isDark: isDark, onAddRole: () => _openAddRole(context)),
          const SizedBox(height: 20),
          const RolesListSection(),
          const SizedBox(height: 20),
          if (isMobile) const PermissionsMobileCards() else const PermissionsDesktopTable(),
        ],
      ),
    );
  }
}

class _DesktopHeader extends StatelessWidget {
  const _DesktopHeader({
    required this.surfaceBg,
    required this.borderColor,
    required this.isDark,
    required this.onAddRole,
  });

  final Color surfaceBg, borderColor;
  final bool isDark;
  final VoidCallback onAddRole;

  @override
  Widget build(BuildContext context) {
    final mutedColor = isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;
    final onSurface = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;

    return Padding(
      padding: const EdgeInsets.only(top: 28, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  TextButton.icon(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.arrow_back_rounded, size: 14, color: AppColors.primary),
                    label: Text('Back', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.primary)),
                    style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4), visualDensity: VisualDensity.compact),
                  ),
                ]),
                const SizedBox(height: 6),
                Text(
                  'Roles & Permissions',
                  style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w700, color: onSurface),
                ),
                const SizedBox(height: 4),
                Text(
                  'Control what each role can access across all modules',
                  style: GoogleFonts.poppins(fontSize: 13, color: mutedColor),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Padding(
            padding: const EdgeInsets.only(top: 28),
            child: FilledButton.icon(
              onPressed: onAddRole,
              icon: const Icon(Icons.add_rounded, size: 18),
              label: Text('Add Role', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600)),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
