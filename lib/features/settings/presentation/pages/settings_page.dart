import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/app_nav_drawer.dart';
import '../providers/settings_provider.dart';
import '../widgets/settings_app_bar.dart';
import '../widgets/settings_card.dart';
import '../widgets/settings_category_chips.dart';
import '../widgets/settings_header.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(filteredSettingsItemsProvider);

    return Scaffold(
      appBar: const SettingsAppBar(),
      drawer: const AppNavDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SettingsHeader(),
          const SizedBox(height: 16),
          const SettingsCategoryChips(),
          const SizedBox(height: 24),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: SettingsCard(item: item),
            ),
          ),
          const SizedBox(height: 32), // Bottom spacing
        ],
      ),
    );
  }
}
