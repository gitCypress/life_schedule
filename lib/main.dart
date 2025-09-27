import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_schedule/mixins/fab_screen_mixin.dart';
import 'package:life_schedule/mixins/navigable_screen_mixin.dart';
import 'package:life_schedule/models/f_screen.dart';

import 'package:life_schedule/providers/ui/navigation_provider.dart';
import 'package:life_schedule/providers/ui/screen_manifest_provider.dart';
import 'package:life_schedule/providers/ui/theme_provider.dart';
import 'package:life_schedule/themes/green_theme.dart';

void main() => runApp(
      const ProviderScope(child: LifeSchedule()),
    ); // 使用 ProviderScope 引入 Riverpod

/// LifeSchedule
/// 控制标题和应用主题内容
class LifeSchedule extends ConsumerWidget {
  const LifeSchedule({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const appTheme = MaterialGreenTheme();

    /// Developer: 为什么有 asData?
    /// AsyncNotifierProvider 的返回值有三种：
    /// AsyncData(✅),AsyncLoading(...),,AsyncError(❌)
    /// 使用 asData是为了检验返回的是不是成功状态，不是就返回 null
    /// .value 则负责拆箱
    /// (使用 .when 来处理更复杂的情况)
    final isDarkMode = ref.watch(themeCustomProvider).asData?.value ?? false;

    return MaterialApp(
      /// 供给操作系统使用的元数据
      title: 'LifeSchedule',
      theme: appTheme.light(),
      darkTheme: appTheme.dark(),

      /// 夜间模式
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const MainScreen(),
    );
  }
}

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// 当前导航
    final selectedIndex = ref.watch(navigationIndexProvider);
    final navigableFS = ref
        .watch(fScreenManifestProvider)
        .whereType<FScreen<NavigableScreenMixin>>()
        .toList();
    final currentScreen = navigableFS[selectedIndex].builder();
    final fabConfig = switch (currentScreen) {
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

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: navigableScreens
          .map(
            (destinations) => BottomNavigationBarItem(
              icon: Icon(destinations.navEntry.icon),
              label: destinations.navEntry.label,
            ),
          )
          .toList(),
      currentIndex: selectedIndex,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Theme.of(context).colorScheme.onSurfaceVariant,
      onTap: (index) =>
          ref.read(navigationIndexProvider.notifier).setIndex(index),
    );
  }
}
