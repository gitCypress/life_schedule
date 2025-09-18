import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:life_schedule/providers/ui/navigation_provider.dart';
import 'package:life_schedule/providers/ui/theme_provider.dart';
import 'package:life_schedule/providers/ui/todo_list_provider.dart';
import 'package:life_schedule/themes/green_theme.dart';

import 'config/navigation_config.dart';

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
    final currentNavIndex = ref.watch(navigationIndexProvider);
    final currentNav = appNavDestinations[currentNavIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(currentNav.label),
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

      // --- 核心改动 ---
      // 根据当前选中的页面索引，来决定显示哪个 FloatingActionButton
      floatingActionButton: _buildFab(context, ref, currentNavIndex),
    );
  }

  /// 一个辅助方法，用于根据页面索引构建对应的 FAB
  Widget? _buildFab(BuildContext context, WidgetRef ref, int index) {
    // 假设我们的“待办”页面在导航列表的第 0 个位置
    if (index == 0) {
      return FloatingActionButton(
        tooltip: '添加待办',
        onPressed: () {
          // 这个方法现在需要从 TodoScreen 移动到这里，或者保持在 TodoScreen 中并设为 static
          // 为了简单，我们直接在这里调用显示对话框的逻辑
          _showAddTodoDialog(context, ref);
        },
        child: const Icon(Icons.add),
      );
    }
    // 其他页面不显示 FAB
    return null;
  }

  /// 将显示对话框的逻辑也放在 MainScreen 中，因为它现在是 FAB 的“主人”
  void _showAddTodoDialog(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('新的待办事项'),
          content: TextField(
            controller: titleController,
            autofocus: true,
            decoration: const InputDecoration(hintText: '请输入标题'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                final title = titleController.text;
                if (title.isNotEmpty) {
                  ref.read(todoListProvider.notifier).addTodo(title);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('添加'),
            ),
          ],
        );
      },
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
