import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/theme/app_colors.dart';
import 'permission_matrix_data.dart';

class RolesListSection extends StatelessWidget {
  const RolesListSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = MediaQuery.sizeOf(context).width < 700;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final surfaceBg = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final headerBg = isDark ? AppColors.darkFieldFill : const Color(0xFFF8FAFC);

    return Container(
      decoration: BoxDecoration(
        color: surfaceBg,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          _TitleBar(isDark: isDark, borderColor: borderColor),
          if (!isMobile) _TableHeader(bg: headerBg, borderColor: borderColor, isDark: isDark),
          ...kRolesList.asMap().entries.map((e) => isMobile
              ? _MobileRoleCard(item: e.value, borderColor: borderColor, isDark: isDark, isLast: e.key == kRolesList.length - 1)
              : _DesktopRoleRow(item: e.value, borderColor: borderColor, isDark: isDark, isLast: e.key == kRolesList.length - 1)),
        ],
      ),
    );
  }
}

class _TitleBar extends StatelessWidget {
  const _TitleBar({required this.isDark, required this.borderColor});
  final bool isDark;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: borderColor))),
      child: Row(
        children: [
          Icon(Icons.shield_outlined, size: 16, color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted),
          const SizedBox(width: 8),
          Text('All Roles', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface)),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(10)),
            child: Text('${kRolesList.length} roles', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.primary)),
          ),
        ],
      ),
    );
  }
}

class _TableHeader extends StatelessWidget {
  const _TableHeader({required this.bg, required this.borderColor, required this.isDark});
  final Color bg, borderColor;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final s = GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 0.5, color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted);
    return Container(
      color: bg,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: borderColor))),
      child: Row(children: [
        Expanded(flex: 3, child: Text('ROLE NAME', style: s)),
        Expanded(flex: 3, child: Text('SLUG', style: s)),
        Expanded(flex: 2, child: Text('PERMISSIONS', style: s)),
        Expanded(flex: 2, child: Text('USERS', style: s)),
        SizedBox(width: 72, child: Text('ACTIONS', style: s, textAlign: TextAlign.end)),
      ]),
    );
  }
}

class _DesktopRoleRow extends StatelessWidget {
  const _DesktopRoleRow({required this.item, required this.borderColor, required this.isDark, required this.isLast});
  final RoleItem item;
  final Color borderColor;
  final bool isDark, isLast;

  @override
  Widget build(BuildContext context) {
    final onSurface = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final mutedColor = isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;
    final slugBg = isDark ? AppColors.darkFieldFill : const Color(0xFFF1F5F9);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: isLast ? null : BoxDecoration(border: Border(bottom: BorderSide(color: borderColor))),
      child: Row(children: [
        Expanded(flex: 3, child: Text(item.name, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: onSurface))),
        Expanded(flex: 3, child: Align(alignment: Alignment.centerLeft, child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
          decoration: BoxDecoration(color: slugBg, borderRadius: BorderRadius.circular(4)),
          child: Text(item.slug, style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w500, color: mutedColor)),
        ))),
        Expanded(flex: 2, child: Text('${item.permCount} permissions', style: GoogleFonts.poppins(fontSize: 12, color: mutedColor))),
        Expanded(flex: 2, child: Align(alignment: Alignment.centerLeft, child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(color: item.badgeColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
          child: Text('${item.userCount} ${item.userCount == 1 ? 'user' : 'users'}', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: item.badgeColor)),
        ))),
        SizedBox(width: 72, child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Icon(Icons.edit_outlined, size: 17, color: mutedColor),
          const SizedBox(width: 12),
          Icon(Icons.toggle_on_rounded, size: 22, color: AppColors.success),
        ])),
      ]),
    );
  }
}

class _MobileRoleCard extends StatelessWidget {
  const _MobileRoleCard({required this.item, required this.borderColor, required this.isDark, required this.isLast});
  final RoleItem item;
  final Color borderColor;
  final bool isDark, isLast;

  @override
  Widget build(BuildContext context) {
    final onSurface = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final mutedColor = isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;
    final slugBg = isDark ? AppColors.darkFieldFill : const Color(0xFFF1F5F9);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: isLast ? null : BoxDecoration(border: Border(bottom: BorderSide(color: borderColor))),
      child: Row(children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(item.name, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: onSurface)),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
            decoration: BoxDecoration(color: slugBg, borderRadius: BorderRadius.circular(4)),
            child: Text(item.slug, style: GoogleFonts.poppins(fontSize: 10, color: mutedColor)),
          ),
        ])),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: item.badgeColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
            child: Text('${item.userCount} ${item.userCount == 1 ? 'user' : 'users'}', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: item.badgeColor)),
          ),
          const SizedBox(height: 4),
          Text('${item.permCount} permissions', style: GoogleFonts.poppins(fontSize: 11, color: mutedColor)),
        ]),
      ]),
    );
  }
}
