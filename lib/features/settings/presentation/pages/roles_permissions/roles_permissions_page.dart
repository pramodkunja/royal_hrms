import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../widgets/roles_permissions/add_role_dialog.dart';
import '../../widgets/roles_permissions/permissions_desktop_table.dart';
import '../../widgets/roles_permissions/roles_list_table.dart';

class RolesPermissionsPage extends StatelessWidget {
  const RolesPermissionsPage({super.key});

  void _openAddRole(BuildContext context) =>
      showDialog(context: context, builder: (_) => const AddRoleDialog());

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenW = MediaQuery.sizeOf(context).width;
    final isMobile = screenW < 700;
    final scaffoldBg = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final surfaceBg = isDark ? AppColors.darkSurface : AppColors.lightSurface;

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
              title: Text('Roles & Permissions',
                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
              actions: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: FilledButton.icon(
                      onPressed: () => _openAddRole(context),
                      icon: const Icon(Icons.add_rounded, size: 16),
                      label: Text('Add Role',
                          style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : null,
      body: ListView(
        padding: EdgeInsets.fromLTRB(
            isMobile ? 16 : 28, isMobile ? 16 : 0, isMobile ? 16 : 28, 32),
        children: [
          if (!isMobile) _DesktopPageHeader(isDark: isDark, onAddRole: () => _openAddRole(context)),
          const SizedBox(height: 20),
          const RolesListSection(),
          const SizedBox(height: 20),
          if (isMobile)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(width: screenW < 500 ? 640 : screenW - 32, child: const PermissionsDesktopTable()),
            )
          else
            const PermissionsDesktopTable(),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _DesktopPageHeader extends StatelessWidget {
  const _DesktopPageHeader({required this.isDark, required this.onAddRole});
  final bool isDark;
  final VoidCallback onAddRole;

  @override
  Widget build(BuildContext context) {
    final onSurface = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final mutedColor = isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    return Padding(
      padding: const EdgeInsets.only(top: 28, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left: title + subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Roles & Permissions',
                    style: GoogleFonts.poppins(
                        fontSize: 22, fontWeight: FontWeight.w700, color: onSurface)),
                const SizedBox(height: 4),
                Text('Control what each role can access across all modules',
                    style: GoogleFonts.poppins(fontSize: 13, color: mutedColor)),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Right: Back + Add Role
          OutlinedButton.icon(
            onPressed: () => context.pop(),
            icon: Icon(Icons.arrow_back_rounded, size: 14, color: onSurface),
            label: Text('Back',
                style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500, color: onSurface)),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: borderColor),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            ),
          ),
          const SizedBox(width: 10),
          FilledButton.icon(
            onPressed: onAddRole,
            icon: const Icon(Icons.add_rounded, size: 18),
            label: Text('Add Role',
                style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600)),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            ),
          ),
        ],
      ),
    );
  }
}
