import 'package:flutter/material.dart';

import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/app_card.dart';
import '../../domain/entities/dashboard_overview.dart';
import 'dashboard_section_header.dart';

const Color _avatarLight = Color(0xFFF0D48A);
const Color _avatarDark = Color(0xFFB8932F);
const Color _tileTintLight = Color(0xFFFDF3E3);
const Color _tileTintDark = Color(0xFF332B1A);

/// Reusable row for a single birthday — avatar, name/role, and a
/// "Send Wish" action. Dynamic: built once per [BirthdayEntry].
class BirthdayCard extends StatelessWidget {
  const BirthdayCard({super.key, required this.entries, this.onSendWish});

  final List<BirthdayEntry> entries;
  final ValueChanged<BirthdayEntry>? onSendWish;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DashboardSectionHeader(
            icon: Icons.cake_outlined,
            title: "Today's Birthdays",
          ),
          const SizedBox(height: 16),
          for (var i = 0; i < entries.length; i++) ...[
            _BirthdayTile(
              entry: entries[i],
              onSendWish: onSendWish == null
                  ? null
                  : () => onSendWish!(entries[i]),
            ),
            if (i != entries.length - 1) const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

class _BirthdayTile extends StatelessWidget {
  const _BirthdayTile({required this.entry, this.onSendWish});

  final BirthdayEntry entry;
  final VoidCallback? onSendWish;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? _tileTintDark : _tileTintLight,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: isDark ? _avatarDark : _avatarLight,
            child: const Text('🎂'),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.name,
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(entry.subtitle, style: context.textTheme.bodySmall),
              ],
            ),
          ),
          OutlinedButton.icon(
            onPressed: onSendWish,
            icon: const Icon(Icons.cake_outlined, size: 16),
            label: const Text('Send Wish'),
          ),
        ],
      ),
    );
  }
}
