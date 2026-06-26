import 'package:flutter/material.dart';

import '../router/route_paths.dart';

class NavMenuItem {
  const NavMenuItem({
    required this.icon,
    required this.label,
    required this.path,
  });

  final IconData icon;
  final String label;
  final String path;
}

class NavMenuSection {
  const NavMenuSection(this.title, this.items);

  final String title;
  final List<NavMenuItem> items;
}

const List<NavMenuSection> navSections = [
  NavMenuSection('Main', [
    NavMenuItem(
      icon: Icons.dashboard_outlined,
      label: 'Dashboard',
      path: RoutePaths.dashboard,
    ),
    NavMenuItem(
      icon: Icons.campaign_outlined,
      label: 'Announcements',
      path: RoutePaths.announcements,
    ),
  ]),
  NavMenuSection('Workforce', [
    NavMenuItem(
      icon: Icons.badge_outlined,
      label: 'Employees',
      path: RoutePaths.employees,
    ),
    NavMenuItem(
      icon: Icons.account_tree_outlined,
      label: 'Org Chart',
      path: RoutePaths.orgChart,
    ),
    NavMenuItem(
      icon: Icons.apartment_outlined,
      label: 'Branches',
      path: RoutePaths.branches,
    ),
  ]),
  NavMenuSection('Time & Pay', [
    NavMenuItem(
      icon: Icons.access_time_outlined,
      label: 'Attendance',
      path: RoutePaths.attendance,
    ),
    NavMenuItem(
      icon: Icons.payments_outlined,
      label: 'Payroll',
      path: RoutePaths.payroll,
    ),
    NavMenuItem(
      icon: Icons.receipt_outlined,
      label: 'My Payslips',
      path: RoutePaths.myPayslips,
    ),
    NavMenuItem(
      icon: Icons.beach_access_outlined,
      label: 'Leave Management',
      path: RoutePaths.leave,
    ),
    NavMenuItem(
      icon: Icons.account_balance_wallet_outlined,
      label: 'Expenses',
      path: RoutePaths.expenses,
    ),
  ]),
  NavMenuSection('HR Ops', [
    NavMenuItem(
      icon: Icons.task_alt_outlined,
      label: 'Approvals',
      path: RoutePaths.approvals,
    ),
    NavMenuItem(
      icon: Icons.logout_outlined,
      label: 'Separation & FnF',
      path: RoutePaths.separation,
    ),
    NavMenuItem(
      icon: Icons.folder_outlined,
      label: 'Document Center',
      path: RoutePaths.documents,
    ),
  ]),
  NavMenuSection('My', [
    NavMenuItem(
      icon: Icons.inbox_outlined,
      label: 'My Requests',
      path: RoutePaths.myRequests,
    ),
    NavMenuItem(
      icon: Icons.account_circle_outlined,
      label: 'My Profile',
      path: RoutePaths.myProfile,
    ),
  ]),
  NavMenuSection('System', [
    NavMenuItem(
      icon: Icons.bar_chart_outlined,
      label: 'Reports',
      path: RoutePaths.reports,
    ),
    NavMenuItem(
      icon: Icons.shield_outlined,
      label: 'Audit Log',
      path: RoutePaths.audit,
    ),
    NavMenuItem(
      icon: Icons.settings_outlined,
      label: 'Settings',
      path: RoutePaths.settings,
    ),
  ]),
];
