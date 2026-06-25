import 'package:flutter/material.dart';

import '../../../../core/utils/extensions.dart';

/// App mark shown above the header on every auth screen.
class AuthLogoBadge extends StatelessWidget {
  const AuthLogoBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Text('👑', style: TextStyle(fontSize: 30)),
    );
  }
}
