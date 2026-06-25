import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/extensions.dart';
import '../../domain/entities/dashboard_overview.dart';

/// Large gradient hero card greeting the signed-in user and surfacing
/// the four headline workforce stats.
class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key, required this.summary});

  final WorkforceSummary summary;

  String get _greetingPrefix {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    final payrollLabel =
        '${DateFormat('MMMM').format(DateTime.now()).toUpperCase()} PAYROLL';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primaryDark, AppColors.primary],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$_greetingPrefix, ${summary.greetingName} 👋',
            style: context.textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${summary.dateLabel} · ${summary.candidatesInPipeline} candidates in pipeline, '
            '${summary.birthdaysToday} birthdays today',
            style: context.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.85),
            ),
          ),
          const SizedBox(height: 28),
          Row(
            children: [
              Expanded(
                child: _Stat(
                  value: '${summary.totalWorkforce}',
                  label: 'TOTAL WORKFORCE',
                ),
              ),
              Expanded(
                child: _Stat(
                  value: '${summary.pendingActions}',
                  label: 'PENDING ACTIONS',
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Row(
            children: [
              Expanded(
                child: _Stat(
                  value: '${summary.activeInterviews}',
                  label: 'ACTIVE INTERVIEWS',
                ),
              ),
              Expanded(
                child: _Stat(
                  value: summary.payrollAmountLabel,
                  label: payrollLabel,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: context.textTheme.headlineMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: context.textTheme.labelSmall?.copyWith(
            color: Colors.white.withValues(alpha: 0.7),
            letterSpacing: 0.6,
          ),
        ),
      ],
    );
  }
}
