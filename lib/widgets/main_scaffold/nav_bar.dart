import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../models/navigation_destination_config.dart';

class NavBar extends ConsumerWidget {
  const NavBar({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) => NavigationBar(
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

final navigationDestinationConfig = [
  NavigationDestinationConfig(
    icon: const Icon(Icons.home_outlined),
    selectedIcon: const Icon(Icons.home),
    label: '首页',
  ),
  NavigationDestinationConfig(
    icon: const Icon(Icons.calendar_month_outlined),
    selectedIcon: const Icon(Icons.calendar_month),
    label: '日历',
  ),
  NavigationDestinationConfig(
    icon: const Icon(Icons.account_balance_wallet_outlined),
    selectedIcon: const Icon(Icons.account_balance_wallet),
    label: '记账',
  ),
  NavigationDestinationConfig(
    icon: const Icon(Icons.settings_outlined),
    selectedIcon: const Icon(Icons.settings),
    label: '设置',
  ),
];
