import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_schedule/mixins/fab_screen_mixin.dart';
import 'package:life_schedule/mixins/navigable_screen_mixin.dart';
import 'package:life_schedule/models/floating_action_button_config.dart';
import 'package:life_schedule/models/navigation_entry.dart';
import '../providers/ui/todo_list_provider.dart';

// 这是一个“纯内容”页面，它不包含 Scaffold。
class TodoScreen extends ConsumerWidget
    with NavigableScreenMixin, FabScreenMixin {
  const TodoScreen({super.key});

  @override
  NavigationEntry get navEntry => _TodoNavigationEntry();

  @override
  FloatingActionButtonConfig get fabConfig =>
      _TodoFloatingActionButtonConfig();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. 监听 todoListProvider 的状态。
    final todoListState = ref.watch(todoListProvider);

    // 2. 将悬浮按钮的逻辑移动到 MainScreen 中 (下一步会做)

    // 3. 根 Widget 直接就是 .when() 的结果，
    //    它会根据状态返回 ListView, Center 等布局 Widget。
    return todoListState.when(
      data: (todos) {
        if (todos.isEmpty) {
          return const Center(
            child: Text('太棒了！没有待办事项。'),
          );
        }
        return ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final todo = todos[index];
            return ListTile(
              leading: Checkbox(
                value: todo.isFinished,
                onChanged: (value) {
                  ref.read(todoListProvider.notifier).toggleTodoStatus(todo);
                },
              ),
              title: Text(
                todo.title,
                style: TextStyle(
                  decoration:
                      todo.isFinished ? TextDecoration.lineThrough : null,
                  color: todo.isFinished
                      ? Theme.of(context).colorScheme.onSurface.withOpacity(0.5)
                      : null,
                ),
              ),
              subtitle: todo.content != null ? Text(todo.content!) : null,
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: () {
                  ref.read(todoListProvider.notifier).deleteTodo(todo);
                },
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('出错了: $err')),
    );
  }
}

class _TodoNavigationEntry implements NavigationEntry {
  @override
  IconData get icon => Icons.home_outlined;

  @override
  String get label => '首页';
}

class _TodoFloatingActionButtonConfig implements FloatingActionButtonConfig {
  @override
  Widget? get child => const Icon(Icons.add);

  @override
  VoidCallback? createOnPressed(BuildContext context, WidgetRef ref) =>
      () { _showAddTodoDialog(context, ref); };

  @override
  String get tooltip => '添加待办';

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
