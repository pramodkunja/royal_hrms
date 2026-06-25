import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/router/route_paths.dart';
import '../../domain/entities/settings_category.dart';
import '../../domain/entities/settings_item.dart';

/// Provider for the currently selected settings category.
final selectedSettingsCategoryProvider = NotifierProvider<SelectedSettingsCategoryNotifier, SettingsCategory>(
  SelectedSettingsCategoryNotifier.new,
);

class SelectedSettingsCategoryNotifier extends Notifier<SettingsCategory> {
  @override
  SettingsCategory build() => SettingsCategory.all;

  void setCategory(SettingsCategory category) {
    state = category;
  }
}

/// Provider for the static list of all settings items.
final allSettingsItemsProvider = Provider<List<SettingsItem>>((ref) {
  return [
    const SettingsItem(
      id: 'company_info',
      title: 'Company Info',
      description: 'Name, GST, address, registration details',
      icon: Icons.business_outlined,
      category: SettingsCategory.company,
    ),
    const SettingsItem(
      id: 'departments',
      title: 'Departments & Designations',
      description: 'Organisation structure and job titles',
      icon: Icons.account_tree_outlined,
      category: SettingsCategory.company,
    ),
    const SettingsItem(
      id: 'roles',
      title: 'Roles & Permissions',
      description: 'Role-based access control for all users',
      icon: Icons.shield_outlined,
      category: SettingsCategory.system,
    ),
    const SettingsItem(
      id: 'leave',
      title: 'Leave Policy',
      description: 'Configure leave types, accruals and limits',
      icon: Icons.beach_access_outlined,
      category: SettingsCategory.modules,
      routePath: RoutePaths.leave,
    ),
    const SettingsItem(
      id: 'payroll',
      title: 'Payroll Rules',
      description: 'Salary components, tax slabs and statutory',
      icon: Icons.payments_outlined,
      category: SettingsCategory.modules,
      routePath: RoutePaths.payroll,
    ),
    const SettingsItem(
      id: 'attendance',
      title: 'Attendance Rules',
      description: 'Shift timings, late marks and overtime',
      icon: Icons.fingerprint_outlined,
      category: SettingsCategory.modules,
      routePath: RoutePaths.attendance,
    ),
    const SettingsItem(
      id: 'recruitment',
      title: 'Recruitment Config',
      description: 'Interview stages, evaluation criteria',
      icon: Icons.person_search_outlined,
      category: SettingsCategory.modules,
      routePath: RoutePaths.recruitment,
    ),
    const SettingsItem(
      id: 'email_templates',
      title: 'Email Templates',
      description: 'Customize all transactional emails',
      icon: Icons.email_outlined,
      category: SettingsCategory.communication,
    ),
    const SettingsItem(
      id: 'smtp_settings',
      title: 'SMTP Settings',
      description: 'Outgoing email server configuration',
      icon: Icons.dns_outlined,
      category: SettingsCategory.communication,
    ),
    const SettingsItem(
      id: 'notifications',
      title: 'Notifications',
      description: 'In-app and email notification preferences',
      icon: Icons.notifications_active_outlined,
      category: SettingsCategory.communication,
      routePath: RoutePaths.notifications,
    ),
    const SettingsItem(
      id: 'audit_log',
      title: 'Audit Log',
      description: 'View all system actions and changes',
      icon: Icons.history_outlined,
      category: SettingsCategory.system,
      routePath: RoutePaths.audit,
    ),
  ];
});

/// Derived provider that filters items by the currently selected category.
final filteredSettingsItemsProvider = Provider<List<SettingsItem>>((ref) {
  final allItems = ref.watch(allSettingsItemsProvider);
  final category = ref.watch(selectedSettingsCategoryProvider);

  if (category == SettingsCategory.all) {
    return allItems;
  }

  return allItems.where((item) => item.category == category).toList();
});
