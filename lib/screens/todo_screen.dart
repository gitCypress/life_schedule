import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_schedule/widgets/todo_screen/todo_list_view_widget.dart';

import '../providers/ui/todo_list_provider.dart';

class TodoScreen extends ConsumerWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoListState = ref.watch(todosStreamProvider);

    return todoListState.when(
      data: (todos) => switch (todos.isEmpty) {
        true => const EmptyTodoListWidget(),
        false => TodoListViewWidget(todos: todos),
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('出错了: $err')),
    );
  }
}
