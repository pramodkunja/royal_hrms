import 'package:flutter/material.dart';

class RoleItem {
  const RoleItem({
    required this.name,
    required this.slug,
    required this.permCount,
    required this.userCount,
    required this.badgeColor,
  });
  final String name, slug;
  final int permCount, userCount;
  final Color badgeColor;
}

const kRolesList = [
  RoleItem(name: 'HR Admin', slug: 'hr_admin', permCount: 50, userCount: 1, badgeColor: Color(0xFF16A34A)),
  RoleItem(name: 'System Admin', slug: 'system_admin', permCount: 50, userCount: 1, badgeColor: Color(0xFF2563EB)),
  RoleItem(name: 'Manager', slug: 'manager', permCount: 20, userCount: 1, badgeColor: Color(0xFFD97706)),
  RoleItem(name: 'Employee', slug: 'employee', permCount: 10, userCount: 1, badgeColor: Color(0xFF7C3AED)),
  RoleItem(name: 'Candidate', slug: 'candidate', permCount: 2, userCount: 0, badgeColor: Color(0xFF6B7280)),
];

class ModulePerm {
  const ModulePerm({required this.module, required this.icon, required this.actions});
  final String module;
  final IconData icon;
  final List<String> actions;
}

const kModulePerms = [
  ModulePerm(module: 'Announcements', icon: Icons.campaign_outlined, actions: ['Create', 'Delete', 'Edit', 'View']),
  ModulePerm(module: 'Attendance', icon: Icons.schedule_outlined, actions: ['Create', 'Delete', 'Edit', 'Export', 'View']),
  ModulePerm(module: 'Audit', icon: Icons.fact_check_outlined, actions: ['View']),
  ModulePerm(module: 'Branches', icon: Icons.account_tree_outlined, actions: ['Create', 'Delete', 'Edit', 'View']),
  ModulePerm(module: 'Documents', icon: Icons.folder_outlined, actions: ['Create', 'Delete', 'Edit', 'View']),
  ModulePerm(module: 'Employees', icon: Icons.people_outlined, actions: ['Approve', 'Create', 'Delete', 'Edit', 'Export', 'View']),
  ModulePerm(module: 'Expenses', icon: Icons.receipt_long_outlined, actions: ['Approve', 'Create', 'Delete', 'Edit', 'View']),
  ModulePerm(module: 'Leave', icon: Icons.beach_access_outlined, actions: ['Approve', 'Create', 'Delete', 'Edit', 'View']),
  ModulePerm(module: 'Payroll', icon: Icons.payments_outlined, actions: ['Create', 'Delete', 'Edit', 'Export', 'View']),
  ModulePerm(module: 'Recruitment', icon: Icons.work_outline, actions: ['Approve', 'Create', 'Delete', 'Edit', 'View']),
  ModulePerm(module: 'Referrals', icon: Icons.share_outlined, actions: ['Create', 'View']),
  ModulePerm(module: 'Reports', icon: Icons.analytics_outlined, actions: ['Export', 'View']),
  ModulePerm(module: 'Settings', icon: Icons.settings_outlined, actions: ['Edit', 'View']),
];

// Cell values: 'Full (N)' = green badge | '—' = dash | 'a,b,c' = action chips
class MatrixRow {
  const MatrixRow({
    required this.module,
    required this.icon,
    required this.hrAdmin,
    required this.sysAdmin,
    required this.manager,
    required this.employee,
    required this.candidate,
  });
  final String module;
  final IconData icon;
  final String hrAdmin, sysAdmin, manager, employee, candidate;
  List<String> get values => [hrAdmin, sysAdmin, manager, employee, candidate];
}

const kPermNone = '—';

const kPermissionMatrix = [
  MatrixRow(module: 'Announcements', icon: Icons.campaign_outlined, hrAdmin: 'Full (4)', sysAdmin: 'Full (4)', manager: 'view', employee: '—', candidate: 'view'),
  MatrixRow(module: 'Attendance', icon: Icons.schedule_outlined, hrAdmin: 'Full (5)', sysAdmin: 'Full (5)', manager: 'create,edit,export,view', employee: 'view,create', candidate: '—'),
  MatrixRow(module: 'Audit', icon: Icons.fact_check_outlined, hrAdmin: 'Full (1)', sysAdmin: 'Full (1)', manager: '—', employee: '—', candidate: '—'),
  MatrixRow(module: 'Branches', icon: Icons.account_tree_outlined, hrAdmin: 'Full (4)', sysAdmin: 'Full (4)', manager: '—', employee: '—', candidate: '—'),
  MatrixRow(module: 'Documents', icon: Icons.folder_outlined, hrAdmin: 'Full (4)', sysAdmin: 'Full (4)', manager: 'view', employee: 'view', candidate: 'view'),
  MatrixRow(module: 'Employees', icon: Icons.people_outlined, hrAdmin: 'Full (6)', sysAdmin: 'Full (6)', manager: 'view', employee: '—', candidate: '—'),
  MatrixRow(module: 'Expenses', icon: Icons.receipt_long_outlined, hrAdmin: 'Full (5)', sysAdmin: 'Full (5)', manager: 'Full (5)', employee: 'view,create', candidate: '—'),
  MatrixRow(module: 'Leave', icon: Icons.beach_access_outlined, hrAdmin: 'Full (5)', sysAdmin: 'Full (5)', manager: 'Full (5)', employee: 'view,create', candidate: '—'),
  MatrixRow(module: 'Payroll', icon: Icons.payments_outlined, hrAdmin: 'Full (5)', sysAdmin: 'Full (5)', manager: 'view', employee: 'view', candidate: '—'),
  MatrixRow(module: 'Recruitment', icon: Icons.work_outline, hrAdmin: 'Full (5)', sysAdmin: 'Full (5)', manager: '—', employee: '—', candidate: '—'),
  MatrixRow(module: 'Referrals', icon: Icons.share_outlined, hrAdmin: 'Full (2)', sysAdmin: 'Full (2)', manager: 'Full (2)', employee: 'Full (2)', candidate: '—'),
  MatrixRow(module: 'Reports', icon: Icons.analytics_outlined, hrAdmin: 'Full (2)', sysAdmin: 'Full (2)', manager: '—', employee: '—', candidate: '—'),
  MatrixRow(module: 'Settings', icon: Icons.settings_outlined, hrAdmin: 'Full (2)', sysAdmin: 'Full (2)', manager: '—', employee: '—', candidate: '—'),
];
