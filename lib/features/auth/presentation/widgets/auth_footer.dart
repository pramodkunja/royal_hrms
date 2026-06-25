import 'package:flutter/material.dart';

import '../../../../core/utils/extensions.dart';

/// Trust/compliance copy shown at the bottom of every auth screen.
class AuthFooter extends StatelessWidget {
  const AuthFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Protected by Royal HRMS · Enterprise SSO available',
      textAlign: TextAlign.center,
      style: context.textTheme.bodySmall?.copyWith(
        color: context.colorScheme.onSurfaceVariant,
      ),
    );
  }
}
