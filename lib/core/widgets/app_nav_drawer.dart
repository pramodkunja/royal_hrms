import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_constants.dart';
import '../router/route_guard.dart';
import '../storage/models/user_session_model.dart';
import '../storage/user_session_service.dart';
import '../utils/extensions.dart';
import 'app_nav_drawer_data.dart';

/// Primary navigation drawer shared by every protected screen. Items are
/// filtered by [RouteGuard.routePermissionAccess] so the menu and guard agree.
class AppNavDrawer extends ConsumerWidget {
  const AppNavDrawer({super.key});

  List<NavMenuItem> _visibleItems(
    List<NavMenuItem> items,
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
                  for (final section in navSections)
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
    NavMenuSection section,
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
