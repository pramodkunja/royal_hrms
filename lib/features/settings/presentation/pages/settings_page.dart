import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_paths.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/app_nav_drawer.dart';

// ---------------------------------------------------------------------------
// Tab model
// ---------------------------------------------------------------------------

enum _SettingsTab { all, company, modules, communication, system }

extension _SettingsTabLabel on _SettingsTab {
  String get label {
    return switch (this) {
      _SettingsTab.all => 'All Settings',
      _SettingsTab.company => 'Company',
      _SettingsTab.modules => 'Modules',
      _SettingsTab.communication => 'Communication',
      _SettingsTab.system => 'System',
    };
  }
}

// ---------------------------------------------------------------------------
// Settings tile model
// ---------------------------------------------------------------------------

class _SettingsTile {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accentColor,
    required this.tabs,
    this.routePath,
    this.hasChevron = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color accentColor;
  final Set<_SettingsTab> tabs;
  final String? routePath;
  final bool hasChevron;
}

// ---------------------------------------------------------------------------
// Tile definitions
// ---------------------------------------------------------------------------

final List<_SettingsTile> _allTiles = [
  _SettingsTile(
    icon: Icons.business_outlined,
    title: 'Company Info',
    subtitle: 'Name, GST, address, registration details',
    accentColor: AppColors.primary,
    tabs: {_SettingsTab.all, _SettingsTab.company},
  ),
  _SettingsTile(
    icon: Icons.account_tree_outlined,
    title: 'Departments & Designations',
    subtitle: 'Organisation structure and job titles',
    accentColor: AppColors.emailCategoryNotification,
    tabs: {_SettingsTab.all, _SettingsTab.company},
    routePath: RoutePaths.settingsDepartments,
    hasChevron: true,
  ),
  _SettingsTile(
    icon: Icons.shield_outlined,
    title: 'Roles & Permissions',
    subtitle: 'Role-based access control for all users',
    accentColor: AppColors.emailCategoryDocument,
    tabs: {_SettingsTab.all, _SettingsTab.company},
  ),
  _SettingsTile(
    icon: Icons.event_note_outlined,
    title: 'Leave Policy',
    subtitle: 'Configure leave types, accruals and limits',
    accentColor: AppColors.emailCategoryWish,
    tabs: {_SettingsTab.all, _SettingsTab.company},
    hasChevron: true,
  ),
  _SettingsTile(
    icon: Icons.receipt_long_outlined,
    title: 'Payroll Rules',
    subtitle: 'Salary components, tax slabs and statutory',
    accentColor: AppColors.success,
    tabs: {_SettingsTab.all, _SettingsTab.modules},
  ),
  _SettingsTile(
    icon: Icons.access_time_outlined,
    title: 'Attendance Rules',
    subtitle: 'Shift timings, late marks and overtime',
    accentColor: AppColors.warning,
    tabs: {_SettingsTab.all, _SettingsTab.modules},
  ),
  _SettingsTile(
    icon: Icons.people_outline,
    title: 'Recruitment Config',
    subtitle: 'Interview stages, evaluation criteria',
    accentColor: AppColors.emailCategoryReminder,
    tabs: {_SettingsTab.all, _SettingsTab.modules},
  ),
  _SettingsTile(
    icon: Icons.email_outlined,
    title: 'Email Templates',
    subtitle: 'Customize all transactional emails',
    accentColor: AppColors.emailCategoryNotification,
    tabs: {_SettingsTab.all, _SettingsTab.communication},
    routePath: RoutePaths.settingsEmailTemplates,
    hasChevron: true,
  ),
  _SettingsTile(
    icon: Icons.dns_outlined,
    title: 'SMTP Settings',
    subtitle: 'Outgoing email server configuration',
    accentColor: AppColors.info,
    tabs: {_SettingsTab.all, _SettingsTab.communication},
    hasChevron: true,
  ),
  _SettingsTile(
    icon: Icons.notifications_outlined,
    title: 'Notifications',
    subtitle: 'In-app and email notification preferences',
    accentColor: AppColors.secondary,
    tabs: {_SettingsTab.all, _SettingsTab.communication},
  ),
  _SettingsTile(
    icon: Icons.history_outlined,
    title: 'Audit Log',
    subtitle: 'View all system actions and changes',
    accentColor: AppColors.primaryLight,
    tabs: {_SettingsTab.all, _SettingsTab.system},
    routePath: RoutePaths.audit,
  ),
];

// ---------------------------------------------------------------------------
// Settings Page
// ---------------------------------------------------------------------------

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  _SettingsTab _activeTab = _SettingsTab.all;

  List<_SettingsTile> get _filteredTiles =>
      _allTiles.where((t) => t.tabs.contains(_activeTab)).toList();

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenSize.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 960;
    final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 4);

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(ctx).openDrawer(),
          ),
        ),
        title: const Text('Settings'),
      ),
      drawer: const AppNavDrawer(),
      body: ListView(
        children: [
          // ── Tab bar ──────────────────────────────────────────────────────
          _SettingsTabBar(
            activeTab: _activeTab,
            onTabChanged: (tab) => setState(() => _activeTab = tab),
          ),
          // ── Page header ──────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 4),
            child: _PageHeader(activeTab: _activeTab),
          ),
          // ── Grid of setting tiles ────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: isMobile ? 4.5 : (isTablet ? 2.8 : 2.0),
              ),
              itemCount: _filteredTiles.length,
              itemBuilder: (context, index) {
                return _SettingsTileCard(
                  tile: _filteredTiles[index],
                  isMobile: isMobile,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab bar
// ---------------------------------------------------------------------------

class _SettingsTabBar extends StatelessWidget {
  const _SettingsTabBar({
    required this.activeTab,
    required this.onTabChanged,
  });

  final _SettingsTab activeTab;
  final ValueChanged<_SettingsTab> onTabChanged;

  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;
    final bgColor = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(bottom: BorderSide(color: borderColor)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: _SettingsTab.values.map((tab) {
            final isActive = tab == activeTab;
            return _TabItem(
              label: tab.label,
              isActive: isActive,
              onTap: () => onTabChanged(tab),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;
    const activeColor = AppColors.primary;
    final mutedColor =
        isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 14),
        margin: const EdgeInsets.only(right: 24),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? activeColor : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          label,
          style: context.textTheme.labelMedium?.copyWith(
            color: isActive ? activeColor : mutedColor,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Page header
// ---------------------------------------------------------------------------

class _PageHeader extends StatelessWidget {
  const _PageHeader({required this.activeTab});

  final _SettingsTab activeTab;

  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;
    final mutedColor =
        isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;

    final subtitle = switch (activeTab) {
      _SettingsTab.all =>
        'Configure all aspects of your Royal HRMS workspace',
      _SettingsTab.company =>
        'Organisation details, departments and access control',
      _SettingsTab.modules =>
        'Configure payroll, attendance and recruitment modules',
      _SettingsTab.communication =>
        'Email templates, SMTP server and notification preferences',
      _SettingsTab.system => 'Audit trail and system-level configuration',
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          activeTab.label,
          style: context.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: context.textTheme.bodySmall?.copyWith(color: mutedColor),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Single setting tile card
// ---------------------------------------------------------------------------

class _SettingsTileCard extends StatelessWidget {
  const _SettingsTileCard({required this.tile, required this.isMobile});

  final _SettingsTile tile;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;
    final surfaceColor =
        isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final mutedColor =
        isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;
    final isNavigable = tile.routePath != null;

    return InkWell(
      onTap: isNavigable ? () => context.push(tile.routePath!) : null,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor),
        ),
        child: isMobile
            ? _MobileTileContent(
                tile: tile,
                mutedColor: mutedColor,
              )
            : _DesktopTileContent(
                tile: tile,
                mutedColor: mutedColor,
              ),
      ),
    );
  }
}

class _DesktopTileContent extends StatelessWidget {
  const _DesktopTileContent({
    required this.tile,
    required this.mutedColor,
  });

  final _SettingsTile tile;
  final Color mutedColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: tile.accentColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(tile.icon, size: 20, color: tile.accentColor),
            ),
            const Spacer(),
            if (tile.hasChevron)
              Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: mutedColor,
              ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          tile.title,
          style: context.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 2),
        Text(
          tile.subtitle,
          style: context.textTheme.bodySmall?.copyWith(
            color: mutedColor,
            height: 1.3,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _MobileTileContent extends StatelessWidget {
  const _MobileTileContent({
    required this.tile,
    required this.mutedColor,
  });

  final _SettingsTile tile;
  final Color mutedColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: tile.accentColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(tile.icon, size: 20, color: tile.accentColor),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                tile.title,
                style: context.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                tile.subtitle,
                style: context.textTheme.bodySmall?.copyWith(
                  color: mutedColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        if (tile.hasChevron) ...[
          const SizedBox(width: 8),
          Icon(
            Icons.arrow_forward_ios,
            size: 14,
            color: mutedColor,
          ),
        ],
      ],
    );
  }
}
