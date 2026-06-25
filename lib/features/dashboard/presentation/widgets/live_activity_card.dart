import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/app_card.dart';
import '../../domain/entities/dashboard_overview.dart';
import 'dashboard_section_header.dart';

class _ActivityVisual {
  const _ActivityVisual(this.icon, this.color);

  final IconData icon;
  final Color color;
}

const Map<ActivityType, _ActivityVisual> _visuals = {
  ActivityType.onboarded: _ActivityVisual(
    Icons.person_add_alt_1_outlined,
    AppColors.success,
  ),
  ActivityType.emailSent: _ActivityVisual(Icons.mail_outline, AppColors.info),
  ActivityType.interview: _ActivityVisual(
    Icons.event_available_outlined,
    AppColors.primary,
  ),
  ActivityType.leaveApproved: _ActivityVisual(
    Icons.check_circle_outline,
    AppColors.success,
  ),
};

/// Reverse-chronological timeline of recent HR activity.
class LiveActivityCard extends StatelessWidget {
  const LiveActivityCard({super.key, required this.entries});

  final List<ActivityEntry> entries;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DashboardSectionHeader(
            icon: Icons.timeline_outlined,
            title: 'Live HR Activity',
          ),
          const SizedBox(height: 12),
          for (var i = 0; i < entries.length; i++)
            _TimelineTile(entry: entries[i], isLast: i == entries.length - 1),
        ],
      ),
    );
  }
}

class _TimelineTile extends StatelessWidget {
  const _TimelineTile({required this.entry, required this.isLast});

  final ActivityEntry entry;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final visual = _visuals[entry.type]!;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: visual.color.withValues(alpha: 0.12),
                child: Icon(visual.icon, color: visual.color, size: 16),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: context.colorScheme.outlineVariant,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 20, top: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.title,
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(entry.timeLabel, style: context.textTheme.bodySmall),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
