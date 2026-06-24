enum UserRole {
  admin,
  hr,
  manager,
  employee;

  static UserRole fromValue(String? value) {
    return UserRole.values.firstWhere(
      (role) => role.name == value,
      orElse: () => UserRole.employee,
    );
  }
}
