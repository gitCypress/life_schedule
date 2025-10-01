import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../mixins/fab_screen_mixin.dart';
import '../../mixins/navigable_screen_mixin.dart';
import '../../models/f_screen.dart';
import '../../providers/ui/navigation_provider.dart';
import '../../providers/ui/screen_manifest_provider.dart';
import 'bottom_nav_bar_widget.dart';

class MainScaffold extends ConsumerWidget {
  const MainScaffold({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// 当前导航
    final selectedIndex = ref.watch(navigationIndexProvider);
    final navigableFS = ref
        .watch(fScreenManifestProvider)
        .whereType<FScreen<NavigableScreenMixin>>()
        .toList();
    final currentScreen = navigableFS[selectedIndex].builder();
    final fabConfig = switch (currentScreen) {  // 类型匹配模式语法
      FabScreenMixin fabscreen => fabscreen.fabConfig,
      _ => null,
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(currentScreen.navEntry.label),
        actions: const [
          IconButton(
            onPressed: null,
            icon: Icon(Icons.more_vert),
            tooltip: '更多',
          ),
        ],
      ),
      body: currentScreen,
      bottomNavigationBar: const BottomNavBar(),

      // --- 核心改动 ---
      // 根据当前选中的页面索引，来决定显示哪个 FloatingActionButton
      floatingActionButton: fabConfig != null
          ? FloatingActionButton(
              tooltip: fabConfig.tooltip,
              onPressed: fabConfig.createOnPressed(context, ref),
              child: fabConfig.child,
            )
          : null,
    );
  }
}