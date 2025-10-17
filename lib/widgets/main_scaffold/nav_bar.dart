import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:life_schedule/providers/data/config_provider.dart';


class NavBar extends ConsumerWidget {
  const NavBar({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationDestinationConfig = ref.read(navConfigProvider);
    return NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        destinations: navigationDestinationConfig
            .map(
              (config) => NavigationDestination(
                icon: config.icon,
                selectedIcon: config.selectedIcon,
                label: config.label,
              ),
            )
            .toList(),
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      );
  }
}
