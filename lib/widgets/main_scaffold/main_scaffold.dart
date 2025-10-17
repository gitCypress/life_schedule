import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:life_schedule/providers/data/config_provider.dart';
import 'package:life_schedule/widgets/main_scaffold/nav_bar.dart';

class MainScaffold extends ConsumerWidget {
  const MainScaffold({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appBarTitle =
        ref.read(navConfigProvider)[navigationShell.currentIndex].label;

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
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
      bottomNavigationBar: NavBar(navigationShell: navigationShell),

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
