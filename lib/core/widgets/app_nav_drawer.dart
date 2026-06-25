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
  _MenuSection('Overview', [
    _MenuItem(
      icon: Icons.dashboard_outlined,
      label: 'Dashboard',
      path: RoutePaths.dashboard,
    ),
  ]),
  _MenuSection('Workforce', [
    _MenuItem(
      icon: Icons.groups_outlined,
      label: 'Employees',
      path: RoutePaths.employees,
    ),
    _MenuItem(
      icon: Icons.fingerprint,
      label: 'Attendance',
      path: RoutePaths.attendance,
    ),
    _MenuItem(
      icon: Icons.beach_access_outlined,
      label: 'Leave',
      path: RoutePaths.leave,
    ),
    _MenuItem(
      icon: Icons.person_search_outlined,
      label: 'Recruitment',
      path: RoutePaths.recruitment,
    ),
  ]),
  _MenuSection('Finance', [
    _MenuItem(
      icon: Icons.payments_outlined,
      label: 'Payroll',
      path: RoutePaths.payroll,
    ),
    _MenuItem(
      icon: Icons.receipt_long_outlined,
      label: 'Expenses',
      path: RoutePaths.expenses,
    ),
  ]),
  _MenuSection('Engagement', [
    _MenuItem(
      icon: Icons.campaign_outlined,
      label: 'Announcements',
      path: RoutePaths.announcements,
    ),
    _MenuItem(
      icon: Icons.share_outlined,
      label: 'Referrals',
      path: RoutePaths.referrals,
    ),
  ]),
  _MenuSection('Insights', [
    _MenuItem(
      icon: Icons.bar_chart_outlined,
      label: 'Reports',
      path: RoutePaths.reports,
    ),
    _MenuItem(
      icon: Icons.fact_check_outlined,
      label: 'Audit Log',
      path: RoutePaths.audit,
    ),
  ]),
  _MenuSection('General', [
    _MenuItem(
      icon: Icons.folder_outlined,
      label: 'Documents',
      path: RoutePaths.documents,
    ),
    _MenuItem(
      icon: Icons.notifications_outlined,
      label: 'Notifications',
      path: RoutePaths.notifications,
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
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _DrawerHeader(session: session),
            for (final section in _sections)
              ..._buildSection(context, section, currentPath, permissions),
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

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({required this.session});

  final UserSessionModel? session;

  static String _initialsOf(String name) {
    final parts = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final session = this.session;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      color: context.colorScheme.primary,
      child: session == null
          ? Text(
              AppConstants.appName,
              style: context.textTheme.titleLarge?.copyWith(
                color: Colors.white,
              ),
            )
          : Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white.withValues(alpha: 0.2),
                  child: Text(
                    _initialsOf(session.name),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        session.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        session.email,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: Colors.white.withValues(alpha: 0.85),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          session.roleDisplay,
                          style: context.textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
