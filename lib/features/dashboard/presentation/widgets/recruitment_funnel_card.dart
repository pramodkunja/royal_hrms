import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/app_card.dart';
import '../../domain/entities/dashboard_overview.dart';
import 'dashboard_section_header.dart';

/// Tapered funnel showing each recruitment stage, from interviews
/// scheduled down to onboarded.
class RecruitmentFunnelCard extends StatelessWidget {
  const RecruitmentFunnelCard({
    super.key,
    required this.month,
    required this.stages,
    this.onViewAll,
  });

  final String month;
  final List<FunnelStage> stages;
  final VoidCallback? onViewAll;

  static const List<Color> _stageColors = [
    AppColors.primaryDark,
    AppColors.primary,
    AppColors.primaryLight,
    Color(0xFFAFC2E0),
    AppColors.success,
  ];

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DashboardSectionHeader(
            icon: Icons.filter_alt_outlined,
            title: 'Recruitment Funnel — $month',
            trailing: onViewAll == null
                ? null
                : OutlinedButton(
                    onPressed: onViewAll,
                    child: const Text('View all'),
                  ),
          ),
          const SizedBox(height: 18),
          for (var i = 0; i < stages.length; i++) ...[
            _FunnelBar(
              label: stages[i].label,
              count: stages[i].count,
              widthFraction: 1 - (i * 0.14),
              color: _stageColors[i % _stageColors.length],
            ),
            if (i != stages.length - 1) const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class _FunnelBar extends StatelessWidget {
  const _FunnelBar({
    required this.label,
    required this.count,
    required this.widthFraction,
    required this.color,
  });

  final String label;
  final int count;
  final double widthFraction;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: FractionallySizedBox(
        widthFactor: widthFraction.clamp(0.4, 1.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                '$count',
                style: context.textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
