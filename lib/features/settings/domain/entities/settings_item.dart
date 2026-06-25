import 'package:flutter/material.dart';

import 'settings_category.dart';

class SettingsItem {
  const SettingsItem({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.category,
    this.routePath,
  });

  final String id;
  final String title;
  final String description;
  final IconData icon;
  final SettingsCategory category;
  final String? routePath;
}
