enum SettingsCategory {
  all('All Settings'),
  company('Company'),
  modules('Modules'),
  communication('Communication'),
  system('System');

  const SettingsCategory(this.displayName);
  final String displayName;
}
