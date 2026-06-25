import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/app_card.dart';
import '../../domain/entities/dashboard_overview.dart';
import 'dashboard_section_header.dart';

class _ActionVisual {
  const _ActionVisual(this.icon, this.color);

  final IconData icon;
  final Color color;
}

const Map<HrActionType, _ActionVisual> _visuals = {
  HrActionType.leave: _ActionVisual(
    Icons.beach_access_outlined,
    AppColors.success,
  ),
  HrActionType.separation: _ActionVisual(Icons.logout_rounded, AppColors.error),
  HrActionType.smtp: _ActionVisual(
    Icons.mark_email_read_outlined,
    AppColors.info,
  ),
  HrActionType.document: _ActionVisual(
    Icons.description_outlined,
    AppColors.secondaryDark,
  ),
};

/// HR's pending-action inbox: each row navigates further via
/// [onItemTap] when provided.
class HrActionQueueCard extends StatelessWidget {
  const HrActionQueueCard({super.key, required this.items, this.onItemTap});

  final List<HrActionItem> items;
  final ValueChanged<HrActionItem>? onItemTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DashboardSectionHeader(
            icon: Icons.inbox_outlined,
            title: 'HR Action Queue',
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.warning.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${items.length} items',
                style: context.textTheme.labelMedium?.copyWith(
                  color: AppColors.secondaryDark,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          for (var i = 0; i < items.length; i++) ...[
            if (i != 0) const Divider(height: 1),
            _ActionTile(
              item: items[i],
              onTap: onItemTap == null ? null : () => onItemTap!(items[i]),
            ),
          ],
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({required this.item, this.onTap});

  final HrActionItem item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final visual = _visuals[item.type]!;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: visual.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(visual.icon, color: visual.color, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(item.subtitle, style: context.textTheme.bodySmall),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}
