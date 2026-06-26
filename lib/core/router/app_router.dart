import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/announcements/feature_module.dart';
import '../../features/approvals/feature_module.dart';
import '../../features/attendance/feature_module.dart';
import '../../features/audit/feature_module.dart';
import '../../features/auth/feature_module.dart';
import '../../features/branches/feature_module.dart';
import '../../features/dashboard/feature_module.dart';
import '../../features/documents/feature_module.dart';
import '../../features/employees/feature_module.dart';
import '../../features/expenses/feature_module.dart';
import '../../features/leave/feature_module.dart';
import '../../features/my_profile/feature_module.dart';
import '../../features/my_requests/feature_module.dart';
import '../../features/notifications/feature_module.dart';
import '../../features/org_chart/feature_module.dart';
import '../../features/payroll/feature_module.dart';
import '../../features/payslips/feature_module.dart';
import '../../features/recruitment/feature_module.dart';
import '../../features/referrals/feature_module.dart';
import '../../features/reports/feature_module.dart';
import '../../features/separation/feature_module.dart';
import '../../features/settings/feature_module.dart';
import '../services/auth_status_notifier.dart';
import 'route_guard.dart';
import 'route_paths.dart';

/// Notifies GoRouter to re-evaluate [RouteGuard.redirect] whenever the
/// app's auth status changes, e.g. after sign-in, sign-out, or a 401.
class _AuthRefreshListenable extends ChangeNotifier {
  _AuthRefreshListenable(Ref ref) {
    ref.listen<AuthStatus>(
      authStatusNotifierProvider,
      (_, _) => notifyListeners(),
    );
  }
}

final appRouterProvider = Provider<GoRouter>((ref) {
  final routeGuard = RouteGuard(ref);

  return GoRouter(
    initialLocation: RoutePaths.splash,
    redirect: routeGuard.redirect,
    refreshListenable: _AuthRefreshListenable(ref),
    routes: [
      GoRoute(
        path: RoutePaths.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: RoutePaths.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: RoutePaths.forgotPassword,
        builder: (context, state) => const ForgotPasswordRequestPage(),
      ),
      GoRoute(
        path: RoutePaths.verifyOtp,
        builder: (context, state) => const OtpVerificationPage(),
      ),
      GoRoute(
        path: RoutePaths.resetPassword,
        builder: (context, state) => const ResetPasswordPage(),
      ),
      GoRoute(
        path: RoutePaths.dashboard,
        builder: (context, state) => const DashboardPage(),
      ),
      GoRoute(
        path: RoutePaths.employees,
        builder: (context, state) => const EmployeesPage(),
      ),
      GoRoute(
        path: RoutePaths.attendance,
        builder: (context, state) => const AttendancePage(),
      ),
      GoRoute(
        path: RoutePaths.leave,
        builder: (context, state) => const LeavePage(),
      ),
      GoRoute(
        path: RoutePaths.payroll,
        builder: (context, state) => const PayrollPage(),
      ),
      GoRoute(
        path: RoutePaths.reports,
        builder: (context, state) => const ReportsPage(),
      ),
      GoRoute(
        path: RoutePaths.notifications,
        builder: (context, state) => const NotificationsPage(),
      ),
      GoRoute(
        path: RoutePaths.settings,
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: RoutePaths.settingsRolesPermissions,
        builder: (context, state) => const RolesPermissionsPage(),
      ),
      GoRoute(
        path: RoutePaths.smtpSettings,
        builder: (context, state) => const SmtpSettingsPage(),
      ),
      GoRoute(
        path: RoutePaths.settingsEmailTemplates,
        builder: (context, state) => const EmailTemplatesPage(),
      ),
      GoRoute(
        path: RoutePaths.settingsDepartments,
        builder: (context, state) => const DepartmentsPage(),
      ),
      GoRoute(
        path: RoutePaths.settingsCompanyInfo,
        builder: (context, state) => const CompanyInfoPage(),
      ),
      GoRoute(
        path: RoutePaths.recruitment,
        builder: (context, state) => const RecruitmentPage(),
      ),
      GoRoute(
        path: RoutePaths.expenses,
        builder: (context, state) => const ExpensesPage(),
      ),
      GoRoute(
        path: RoutePaths.referrals,
        builder: (context, state) => const ReferralsPage(),
      ),
      GoRoute(
        path: RoutePaths.announcements,
        builder: (context, state) => const AnnouncementsPage(),
      ),
      GoRoute(
        path: RoutePaths.documents,
        builder: (context, state) => const DocumentsPage(),
      ),
      GoRoute(
        path: RoutePaths.audit,
        builder: (context, state) => const AuditPage(),
      ),
      GoRoute(
        path: RoutePaths.orgChart,
        builder: (context, state) => const OrgChartPage(),
      ),
      GoRoute(
        path: RoutePaths.branches,
        builder: (context, state) => const BranchesPage(),
      ),
      GoRoute(
        path: RoutePaths.myPayslips,
        builder: (context, state) => const PayslipsPage(),
      ),
      GoRoute(
        path: RoutePaths.approvals,
        builder: (context, state) => const ApprovalsPage(),
      ),
      GoRoute(
        path: RoutePaths.separation,
        builder: (context, state) => const SeparationPage(),
      ),
      GoRoute(
        path: RoutePaths.myRequests,
        builder: (context, state) => const MyRequestsPage(),
      ),
      GoRoute(
        path: RoutePaths.myProfile,
        builder: (context, state) => const MyProfilePage(),
      ),
    ],
  );
});
