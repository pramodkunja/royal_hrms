import 'package:flutter/material.dart';

/// Generic elevated, rounded surface (styling sourced entirely from
/// `CardThemeData` in core/theme/app_theme.dart) for any feature that
/// needs to present content as a floating card rather than a bare page.
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(28),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(padding: padding, child: child),
    );
  }
}
