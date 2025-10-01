import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../mixins/navigable_screen_mixin.dart';
import '../../models/f_screen.dart';
import '../../providers/ui/navigation_provider.dart';
import '../../providers/ui/screen_manifest_provider.dart';

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationIndexProvider);
    final navigableScreens = ref
        .watch(fScreenManifestProvider)
        .whereType<FScreen<NavigableScreenMixin>>()
        .map((f) => f.builder())
        .toList();

    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) =>
          ref.read(navigationIndexProvider.notifier).setIndex(index),
      destinations: navigableScreens
          .map(
            (screen) => NavigationDestination(
              icon: Icon(screen.navEntry.icon),
              label: screen.navEntry.label,
            ),
          )
          .toList(),
    );
  }
}
