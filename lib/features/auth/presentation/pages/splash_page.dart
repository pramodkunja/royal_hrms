import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/auth_status_notifier.dart';
import '../../../../core/widgets/app_loader.dart';

/// Resolves the initial auth status on launch; [RouteGuard] takes over
/// navigation once [AuthStatusNotifier] leaves [AuthStatus.unknown].
class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(authStatusNotifierProvider.notifier).checkInitialStatus(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: AppLoader());
  }
}
