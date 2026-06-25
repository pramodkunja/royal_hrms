import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_constants.dart';
import '../router/route_guard.dart';
import '../router/route_paths.dart';
import '../storage/models/user_session_model.dart';
import '../storage/user_session_service.dart';
import '../utils/extensions.dart';

class _MenuItem {
  const _MenuItem({
    required this.icon,
    required this.label,
    required this.path,
  });

  final IconData icon;
  final String label;
  final String path;
}

class _MenuSection {
  const _MenuSection(this.title, this.items);

  final String title;
  final List<_MenuItem> items;
}

const List<_MenuSection> _sections = [
  _MenuSection('Main', [
    _MenuItem(
      icon: Icons.dashboard_outlined,
      label: 'Dashboard',
      path: RoutePaths.dashboard,
    ),
    _MenuItem(
      icon: Icons.campaign_outlined,
      label: 'Announcements',
      path: RoutePaths.announcements,
    ),
  ]),
  _MenuSection('Workforce', [
    _MenuItem(
      icon: Icons.badge_outlined,
      label: 'Employees',
      path: RoutePaths.employees,
    ),
    _MenuItem(
      icon: Icons.account_tree_outlined,
      label: 'Org Chart',
      path: RoutePaths.orgChart,
    ),
    _MenuItem(
      icon: Icons.apartment_outlined,
      label: 'Branches',
      path: RoutePaths.branches,
    ),
  ]),
  _MenuSection('Time & Pay', [
    _MenuItem(
      icon: Icons.access_time_outlined,
      label: 'Attendance',
      path: RoutePaths.attendance,
    ),
    _MenuItem(
      icon: Icons.payments_outlined,
      label: 'Payroll',
      path: RoutePaths.payroll,
    ),
    _MenuItem(
      icon: Icons.receipt_outlined,
      label: 'My Payslips',
      path: RoutePaths.myPayslips,
    ),
    _MenuItem(
      icon: Icons.beach_access_outlined,
      label: 'Leave Management',
      path: RoutePaths.leave,
    ),
    _MenuItem(
      icon: Icons.account_balance_wallet_outlined,
      label: 'Expenses',
      path: RoutePaths.expenses,
    ),
  ]),
  _MenuSection('HR Ops', [
    _MenuItem(
      icon: Icons.task_alt_outlined,
      label: 'Approvals',
      path: RoutePaths.approvals,
    ),
    _MenuItem(
      icon: Icons.logout_outlined,
      label: 'Separation & FnF',
      path: RoutePaths.separation,
    ),
    _MenuItem(
      icon: Icons.folder_outlined,
      label: 'Document Center',
      path: RoutePaths.documents,
    ),
  ]),
  _MenuSection('My', [
    _MenuItem(
      icon: Icons.inbox_outlined,
      label: 'My Requests',
      path: RoutePaths.myRequests,
    ),
    _MenuItem(
      icon: Icons.account_circle_outlined,
      label: 'My Profile',
      path: RoutePaths.myProfile,
    ),
  ]),
  _MenuSection('System', [
    _MenuItem(
      icon: Icons.bar_chart_outlined,
      label: 'Reports',
      path: RoutePaths.reports,
    ),
    _MenuItem(
      icon: Icons.shield_outlined,
      label: 'Audit Log',
      path: RoutePaths.audit,
    ),
    _MenuItem(
      icon: Icons.settings_outlined,
      label: 'Settings',
      path: RoutePaths.settings,
    ),
  ]),
];

/// Primary navigation drawer shared by every protected screen, opened
/// from the hamburger icon in each feature's app bar. Items are
/// filtered by [RouteGuard.routePermissionAccess] — the same map the
/// router uses to guard routes — so the menu and the guard can never
/// disagree.
class AppNavDrawer extends ConsumerWidget {
  const AppNavDrawer({super.key});

  List<_MenuItem> _visibleItems(
    List<_MenuItem> items,
    Set<String> permissions,
  ) {
    return items.where((item) {
      final required = RouteGuard.routePermissionAccess[item.path];
      if (required == null || required.isEmpty) return true;
      return required.any(permissions.contains);
    }).toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPath = GoRouterState.of(context).matchedLocation;
    final session = ref.watch(currentUserSessionProvider).value;
    final permissions = session?.permissions.toSet() ?? const <String>{};

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const _DrawerTopBar(),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(bottom: 8),
                children: [
                  for (final section in _sections)
                    ..._buildSection(
                      context,
                      section,
                      currentPath,
                      permissions,
                    ),
                ],
              ),
            ),
            const Divider(height: 1),
            _DrawerFooter(session: session),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildSection(
    BuildContext context,
    _MenuSection section,
    String currentPath,
    Set<String> permissions,
  ) {
    final visibleItems = _visibleItems(section.items, permissions);
    if (visibleItems.isEmpty) return const [];

    return [
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Text(
          section.title.toUpperCase(),
          style: context.textTheme.labelSmall?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
            letterSpacing: 0.6,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      for (final item in visibleItems)
        ListTile(
          leading: Icon(item.icon),
          title: Text(item.label),
          selected: currentPath == item.path,
          onTap: () {
            Navigator.of(context).pop();
            if (currentPath != item.path) {
              context.go(item.path);
            }
          },
        ),
    ];
  }
}

class _DrawerTopBar extends StatelessWidget {
  const _DrawerTopBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              AppConstants.appName,
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.menu_open),
            tooltip: 'Close menu',
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}

class _DrawerFooter extends StatelessWidget {
  const _DrawerFooter({required this.session});

  final UserSessionModel? session;

  @override
  Widget build(BuildContext context) {
    final session = this.session;
    if (session == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            session.roleDisplay,
            style: context.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            session.role,
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
