import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/app_nav_drawer.dart';
import '../widgets/settings_tab_bar.dart';
import '../widgets/settings_tile_card.dart';
import 'settings_page_types.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  SettingsFilterTab _activeTab = SettingsFilterTab.all;

  List<SettingsTileData> get _filteredTiles =>
      kAllSettingsTiles.where((t) => t.tabs.contains(_activeTab)).toList();

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
          SettingsTabBar(
            activeTab: _activeTab,
            onTabChanged: (tab) => setState(() => _activeTab = tab),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 4),
            child: _PageHeader(activeTab: _activeTab),
          ),
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
              itemBuilder: (context, index) => SettingsTileCard(
                tile: _filteredTiles[index],
                isMobile: isMobile,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PageHeader extends StatelessWidget {
  const _PageHeader({required this.activeTab});

  final SettingsFilterTab activeTab;

  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;
    final mutedColor =
        isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;

    final subtitle = switch (activeTab) {
      SettingsFilterTab.all =>
        'Configure all aspects of your Royal HRMS workspace',
      SettingsFilterTab.company =>
        'Organisation details, departments and access control',
      SettingsFilterTab.modules =>
        'Configure payroll, attendance and recruitment modules',
      SettingsFilterTab.communication =>
        'Email templates, SMTP server and notification preferences',
      SettingsFilterTab.system => 'Audit trail and system-level configuration',
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
