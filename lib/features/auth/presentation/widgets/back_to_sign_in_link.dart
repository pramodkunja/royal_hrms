import 'package:flutter/material.dart';

/// "← Back to sign in" link shown at the top of every forgot-password
/// step, always returning to the login screen (not just one step back).
class BackToSignInLink extends StatelessWidget {
  const BackToSignInLink({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.arrow_back, size: 16),
        label: const Text('Back to sign in'),
      ),
    );
  }
}
