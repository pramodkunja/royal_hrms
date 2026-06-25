import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../constants/permissions.dart';
import '../services/auth_status_notifier.dart';
import '../storage/user_session_service.dart';
import 'route_paths.dart';

/// Centralizes the redirect rules GoRouter consults before entering any
/// route: public vs. protected access, and per-route permission
/// restrictions for permission-based navigation.
class RouteGuard {
  const RouteGuard(this._ref);

  final Ref _ref;

  static const List<String> publicPaths = [
    RoutePaths.splash,
    RoutePaths.login,
    RoutePaths.forgotPassword,
    RoutePaths.verifyOtp,
    RoutePaths.resetPassword,
  ];

  /// Maps a protected route to the permission(s) that grant access —
  /// the user needs at least one of the listed permissions. An entry
  /// with an empty list (or no entry at all) means any authenticated
  /// user may access the route. [AppNavDrawer] reads this same map to
  /// decide which items to show, so router enforcement and menu
  /// visibility can never drift apart.
  static const Map<String, List<String>> routePermissionAccess = {
    RoutePaths.employees: [AppPermissions.viewEmployees],
    RoutePaths.attendance: [AppPermissions.viewAttendance],
    RoutePaths.leave: [AppPermissions.viewLeave],
    RoutePaths.payroll: [AppPermissions.viewPayroll],
    RoutePaths.reports: [AppPermissions.viewReports],
    RoutePaths.settings: [AppPermissions.viewSettings],
    RoutePaths.recruitment: [AppPermissions.viewRecruitment],
    RoutePaths.expenses: [AppPermissions.viewExpenses],
    RoutePaths.referrals: [AppPermissions.viewReferrals],
    RoutePaths.announcements: [AppPermissions.viewAnnouncements],
    RoutePaths.documents: [AppPermissions.viewDocuments],
    RoutePaths.audit: [AppPermissions.viewAudit],
  };

  FutureOr<String?> redirect(BuildContext context, GoRouterState state) async {
    final authStatus = _ref.read(authStatusNotifierProvider);
    final isPublicRoute = publicPaths.contains(state.matchedLocation);

    if (authStatus == AuthStatus.unknown) {
      return null;
    }

    if (state.matchedLocation == RoutePaths.splash) {
      return authStatus == AuthStatus.authenticated
          ? RoutePaths.dashboard
          : RoutePaths.login;
    }

    if (authStatus != AuthStatus.authenticated && !isPublicRoute) {
      return RoutePaths.login;
    }

    if (authStatus == AuthStatus.authenticated &&
        state.matchedLocation == RoutePaths.login) {
      return RoutePaths.dashboard;
    }

    final requiredPermissions = routePermissionAccess[state.matchedLocation];
    if (authStatus == AuthStatus.authenticated &&
        requiredPermissions != null &&
        requiredPermissions.isNotEmpty) {
      final hasAccess = await _ref
          .read(userSessionServiceProvider)
          .hasAnyPermission(requiredPermissions);
      if (!hasAccess) {
        return RoutePaths.dashboard;
      }
    }

    return null;
  }
}
