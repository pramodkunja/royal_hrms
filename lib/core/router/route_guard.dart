import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../constants/enums.dart';
import '../services/auth_status_notifier.dart';
import '../storage/user_session_service.dart';
import 'route_paths.dart';

/// Centralizes the redirect rules GoRouter consults before entering any
/// route: public vs. protected access, and (once populated) per-route
/// role restrictions for role-based navigation.
class RouteGuard {
  const RouteGuard(this._ref);

  final Ref _ref;

  static const List<String> publicPaths = [RoutePaths.splash, RoutePaths.login];

  /// Maps a protected route to the roles allowed to access it. An entry
  /// with an empty list (or no entry at all) means any authenticated
  /// user may access the route.
  static const Map<String, List<UserRole>> routeRoleAccess = {};

  FutureOr<String?> redirect(BuildContext context, GoRouterState state) async {
    final authStatus = _ref.read(authStatusNotifierProvider);
    final isPublicRoute = publicPaths.contains(state.matchedLocation);

    if (authStatus == AuthStatus.unknown) {
      return null;
    }

    if (authStatus != AuthStatus.authenticated && !isPublicRoute) {
      return RoutePaths.login;
    }

    if (authStatus == AuthStatus.authenticated && state.matchedLocation == RoutePaths.login) {
      return RoutePaths.dashboard;
    }

    final allowedRoles = routeRoleAccess[state.matchedLocation];
    if (authStatus == AuthStatus.authenticated && allowedRoles != null && allowedRoles.isNotEmpty) {
      final currentRole = await _ref.read(userSessionServiceProvider).getUserRole();
      if (currentRole == null || !allowedRoles.contains(currentRole)) {
        return RoutePaths.dashboard;
      }
    }

    return null;
  }
}
