import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/ui/todo_list_provider.dart';

// 这是一个“纯内容”页面，它不包含 Scaffold。
class TodoScreen extends ConsumerWidget {
  const TodoScreen({super.key});

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
                  decoration: todo.isFinished ? TextDecoration.lineThrough : null,
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