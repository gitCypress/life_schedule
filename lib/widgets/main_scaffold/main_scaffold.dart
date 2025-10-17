import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../mixins/fab_screen_mixin.dart';
import '../../mixins/navigable_screen_mixin.dart';
import '../../models/f_screen.dart';
import '../../providers/ui/navigation_provider.dart';
import '../../providers/ui/screen_manifest_provider.dart';

class MainScaffold extends ConsumerWidget {
  const MainScaffold({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('undefinedTitle'),
        actions: const [
          IconButton(
            onPressed: null,
            icon: Icon(Icons.more_vert),
            tooltip: '更多',
          ),
        ],
      ),
      body: navigationShell,
      // TODO: 原有fab机制失效
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: '首页',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            selectedIcon: Icon(Icons.calendar_month),
            label: '日历',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet_outlined),
            selectedIcon: Icon(Icons.account_balance_wallet),
            label: '记账',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: '设置',
          ),
        ],
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      ),

      // --- 核心改动 ---
      // TODO:fab机制待修复
      floatingActionButton: const FloatingActionButton(
              tooltip: 'undefinedFab',
              onPressed: null,
              child: Icon(Icons.question_mark),
            ),
    );
  }
}
