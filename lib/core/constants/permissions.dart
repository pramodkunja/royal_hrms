/// Permission codes as returned by the backend (`user.permissions`), in
/// its `module.action` format. Only codes this app actually checks
/// against are listed here — not the full catalog the backend exposes.
class AppPermissions {
  const AppPermissions._();

  static const String viewEmployees = 'employees.view';
  static const String viewAttendance = 'attendance.view';
  static const String viewLeave = 'leave.view';
  static const String viewPayroll = 'payroll.view';
  static const String viewReports = 'reports.view';
  static const String viewSettings = 'settings.view';
  static const String viewRecruitment = 'recruitment.view';
  static const String viewExpenses = 'expenses.view';
  static const String viewReferrals = 'referrals.view';
  static const String viewAnnouncements = 'announcements.view';
  static const String viewDocuments = 'documents.view';
  static const String viewAudit = 'audit.view';
}
