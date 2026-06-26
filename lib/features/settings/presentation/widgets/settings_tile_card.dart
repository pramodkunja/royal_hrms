import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/extensions.dart';
import '../pages/settings_page_types.dart';

class SettingsTileCard extends StatelessWidget {
  const SettingsTileCard({
    super.key,
    required this.tile,
    required this.isMobile,
  });

  final SettingsTileData tile;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;
    final surfaceColor =
        isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final mutedColor =
        isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;
    final isNavigable = tile.routePath != null;

    return InkWell(
      onTap: isNavigable ? () => context.push(tile.routePath!) : null,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor),
        ),
        child: isMobile
            ? _MobileTileContent(tile: tile, mutedColor: mutedColor)
            : _DesktopTileContent(tile: tile, mutedColor: mutedColor),
      ),
    );
  }
}

class _DesktopTileContent extends StatelessWidget {
  const _DesktopTileContent({required this.tile, required this.mutedColor});

  final SettingsTileData tile;
  final Color mutedColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: tile.accentColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(tile.icon, size: 20, color: tile.accentColor),
            ),
            const Spacer(),
            if (tile.hasChevron)
              Icon(Icons.arrow_forward_ios, size: 14, color: mutedColor),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          tile.title,
          style: context.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 2),
        Text(
          tile.subtitle,
          style: context.textTheme.bodySmall?.copyWith(
            color: mutedColor,
            height: 1.3,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _MobileTileContent extends StatelessWidget {
  const _MobileTileContent({required this.tile, required this.mutedColor});

  final SettingsTileData tile;
  final Color mutedColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: tile.accentColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(tile.icon, size: 20, color: tile.accentColor),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                tile.title,
                style: context.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                tile.subtitle,
                style: context.textTheme.bodySmall?.copyWith(
                  color: mutedColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        if (tile.hasChevron) ...[
          const SizedBox(width: 8),
          Icon(Icons.arrow_forward_ios, size: 14, color: mutedColor),
        ],
      ],
    );
  }
}
