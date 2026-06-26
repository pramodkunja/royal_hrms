/// Static permission matrix — no Flutter dependency needed.
const String kPermFull = 'full'; // green checkmark
const String kPermNone = 'none'; // gray dash

const List<String> kRoles = ['HR Admin', 'System Admin', 'Manager', 'Employee'];

class PermissionRow {
  const PermissionRow({
    required this.feature,
    required this.hrAdmin,
    required this.sysAdmin,
    required this.manager,
    required this.employee,
  });

  final String feature;
  final String hrAdmin;
  final String sysAdmin;
  final String manager;
  final String employee;

  List<String> get values => [hrAdmin, sysAdmin, manager, employee];
}

const List<PermissionRow> kPermissionMatrix = [
  PermissionRow(
    feature: 'View All Employees',
    hrAdmin: kPermFull, sysAdmin: kPermFull,
    manager: 'Team only', employee: 'Self only',
  ),
  PermissionRow(
    feature: 'Edit Employee Records',
    hrAdmin: kPermFull, sysAdmin: kPermFull,
    manager: kPermNone, employee: kPermNone,
  ),
  PermissionRow(
    feature: 'Interview Management',
    hrAdmin: kPermFull, sysAdmin: kPermNone,
    manager: 'View only', employee: kPermNone,
  ),
  PermissionRow(
    feature: 'Run Payroll',
    hrAdmin: kPermFull, sysAdmin: kPermFull,
    manager: kPermNone, employee: kPermNone,
  ),
  PermissionRow(
    feature: 'View Payslips',
    hrAdmin: 'All', sysAdmin: 'All',
    manager: 'Team', employee: 'Own',
  ),
  PermissionRow(
    feature: 'Approve Leave',
    hrAdmin: kPermFull, sysAdmin: kPermFull,
    manager: 'Team', employee: kPermNone,
  ),
  PermissionRow(
    feature: 'Import Attendance',
    hrAdmin: kPermFull, sysAdmin: kPermFull,
    manager: kPermNone, employee: kPermNone,
  ),
  PermissionRow(
    feature: 'Initiate Separation',
    hrAdmin: kPermFull, sysAdmin: kPermFull,
    manager: kPermNone, employee: 'Self',
  ),
  PermissionRow(
    feature: 'Manage Settings',
    hrAdmin: kPermFull, sysAdmin: kPermFull,
    manager: kPermNone, employee: kPermNone,
  ),
  PermissionRow(
    feature: 'Email Templates',
    hrAdmin: kPermFull, sysAdmin: kPermFull,
    manager: kPermNone, employee: kPermNone,
  ),
];
