import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:life_schedule/providers/navigation_provider.dart';
import 'package:life_schedule/providers/theme_provider.dart';
import 'package:life_schedule/themes/green_theme.dart';

import 'config/navigation_config.dart';

void main() => runApp(
  ProviderScope(child: const LifeSchedule()),
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
    final currentNavIndex = ref.watch(navigationIndexProvider);
    final currentNav = appNavDestinations[currentNavIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(currentNav.label),

        /// action 当前纯粹是找了个按钮占位
        actions: const [
          IconButton(
            onPressed: null,
            icon: Icon(Icons.more_vert),
            tooltip: '更多',
          ),
        ],
      ),
      body: currentNav.screen,
      bottomNavigationBar: const BottomNavBar(),
      /// 这个浮动按钮暂时也是个占位符
      floatingActionButton: currentNavIndex == 0
          ? const FloatingActionButton(
              tooltip: '添加',
              onPressed: null,
              child: Icon(Icons.add),
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

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: appNavDestinations
          .map(
            (destinations) => BottomNavigationBarItem(
              icon: Icon(destinations.icon),
              label: destinations.label,
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
