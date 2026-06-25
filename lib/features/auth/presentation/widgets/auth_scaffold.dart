import 'package:flutter/material.dart';

import '../../../../core/widgets/app_card.dart';
import 'auth_footer.dart';
import 'auth_header.dart';
import 'auth_logo_badge.dart';

/// Shared chrome for every auth screen: centered card, logo, title and
/// subtitle, page-specific [child], and the trust footer. Keyboard is
/// dismissed on outside tap.
///
/// Pass [backgroundImagePath] to render a full-bleed photo behind the
/// card with a dark scrim for contrast — the card itself stays opaque,
/// so legibility is unaffected either way. Every auth screen (login,
/// forgot password, OTP, reset password) passes the same image so the
/// whole flow looks consistent.
class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    this.title = 'Welcome back',
    required this.subtitle,
    required this.child,
    this.backgroundImagePath,
  });

  final String title;
  final String subtitle;
  final Widget child;
  final String? backgroundImagePath;

  @override
  Widget build(BuildContext context) {
    final card = Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Center(child: AuthLogoBadge()),
                const SizedBox(height: 20),
                AuthHeader(title: title, subtitle: subtitle),
                const SizedBox(height: 24),
                child,
                const SizedBox(height: 24),
                const AuthFooter(),
              ],
            ),
          ),
        ),
      ),
    );

    final backgroundImagePath = this.backgroundImagePath;
    final body = backgroundImagePath == null
        ? SafeArea(child: card)
        : Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(backgroundImagePath, fit: BoxFit.cover),
              Container(color: Colors.black.withValues(alpha: 0.45)),
              SafeArea(child: card),
            ],
          );

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(body: body),
    );
  }
}
