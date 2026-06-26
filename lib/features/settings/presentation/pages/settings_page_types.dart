import 'package:flutter/material.dart';

import '../../../../core/router/route_paths.dart';
import '../../../../core/theme/app_colors.dart';

enum SettingsFilterTab { all, company, modules, communication, system }

extension SettingsFilterTabLabel on SettingsFilterTab {
  String get label {
    return switch (this) {
      SettingsFilterTab.all => 'All Settings',
      SettingsFilterTab.company => 'Company',
      SettingsFilterTab.modules => 'Modules',
      SettingsFilterTab.communication => 'Communication',
      SettingsFilterTab.system => 'System',
    };
  }

  IconData get icon {
    return switch (this) {
      SettingsFilterTab.all => Icons.tune_outlined,
      SettingsFilterTab.company => Icons.business_outlined,
      SettingsFilterTab.modules => Icons.extension_outlined,
      SettingsFilterTab.communication => Icons.email_outlined,
      SettingsFilterTab.system => Icons.dns_outlined,
    };
  }
}

class SettingsTileData {
  const SettingsTileData({
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
  final Set<SettingsFilterTab> tabs;
  final String? routePath;
  final bool hasChevron;
}

const List<SettingsTileData> kAllSettingsTiles = [
  SettingsTileData(
    icon: Icons.business_outlined,
    title: 'Company Info',
    subtitle: 'Name, GST, address, registration details',
    accentColor: AppColors.primary,
    tabs: {SettingsFilterTab.all, SettingsFilterTab.company},
  ),
  SettingsTileData(
    icon: Icons.account_tree_outlined,
    title: 'Departments & Designations',
    subtitle: 'Organisation structure and job titles',
    accentColor: AppColors.emailCategoryNotification,
    tabs: {SettingsFilterTab.all, SettingsFilterTab.company},
    routePath: RoutePaths.settingsDepartments,
    hasChevron: true,
  ),
  SettingsTileData(
    icon: Icons.shield_outlined,
    title: 'Roles & Permissions',
    subtitle: 'Role-based access control for all users',
    accentColor: AppColors.emailCategoryDocument,
    tabs: {SettingsFilterTab.all, SettingsFilterTab.company},
    routePath: RoutePaths.settingsRolesPermissions,
    hasChevron: true,
  ),
  SettingsTileData(
    icon: Icons.event_note_outlined,
    title: 'Leave Policy',
    subtitle: 'Configure leave types, accruals and limits',
    accentColor: AppColors.emailCategoryWish,
    tabs: {SettingsFilterTab.all, SettingsFilterTab.company},
    hasChevron: true,
  ),
  SettingsTileData(
    icon: Icons.receipt_long_outlined,
    title: 'Payroll Rules',
    subtitle: 'Salary components, tax slabs and statutory',
    accentColor: AppColors.success,
    tabs: {SettingsFilterTab.all, SettingsFilterTab.modules},
  ),
  SettingsTileData(
    icon: Icons.access_time_outlined,
    title: 'Attendance Rules',
    subtitle: 'Shift timings, late marks and overtime',
    accentColor: AppColors.warning,
    tabs: {SettingsFilterTab.all, SettingsFilterTab.modules},
  ),
  SettingsTileData(
    icon: Icons.people_outline,
    title: 'Recruitment Config',
    subtitle: 'Interview stages, evaluation criteria',
    accentColor: AppColors.emailCategoryReminder,
    tabs: {SettingsFilterTab.all, SettingsFilterTab.modules},
  ),
  SettingsTileData(
    icon: Icons.email_outlined,
    title: 'Email Templates',
    subtitle: 'Customize all transactional emails',
    accentColor: AppColors.emailCategoryNotification,
    tabs: {SettingsFilterTab.all, SettingsFilterTab.communication},
    routePath: RoutePaths.settingsEmailTemplates,
    hasChevron: true,
  ),
  SettingsTileData(
    icon: Icons.dns_outlined,
    title: 'SMTP Settings',
    subtitle: 'Outgoing email server configuration',
    accentColor: AppColors.info,
    tabs: {SettingsFilterTab.all, SettingsFilterTab.communication},
    routePath: RoutePaths.smtpSettings,
    hasChevron: true,
  ),
  SettingsTileData(
    icon: Icons.notifications_outlined,
    title: 'Notifications',
    subtitle: 'In-app and email notification preferences',
    accentColor: AppColors.secondary,
    tabs: {SettingsFilterTab.all, SettingsFilterTab.communication},
  ),
  SettingsTileData(
    icon: Icons.history_outlined,
    title: 'Audit Log',
    subtitle: 'View all system actions and changes',
    accentColor: AppColors.primaryLight,
    tabs: {SettingsFilterTab.all, SettingsFilterTab.system},
    routePath: RoutePaths.audit,
  ),
];
