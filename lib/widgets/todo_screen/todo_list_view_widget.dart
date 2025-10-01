import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_schedule/models/ui_state/todo_edit_mode.dart';
import 'package:life_schedule/screens/todo_edit_screen.dart';

import '../../domain/entities/todo.dart';
import '../../providers/ui/todo_list_provider.dart';

class TodoListViewWidget extends ConsumerWidget {
  const TodoListViewWidget({super.key, required this.todos});

  final List<Todo> todos;

  @override
  Widget build(BuildContext context, WidgetRef ref) => ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return _TodoListTile(todo: todo);
        },
      );
}

class _TodoListTile extends ConsumerWidget {
  const _TodoListTile({required this.todo});

  final Todo todo;

  @override
  Widget build(BuildContext context, WidgetRef ref) => ListTile(
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
                // ignore: deprecated_member_use
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
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TodoEditScreen(
                mode: TodoEditMode.edit(todo: todo),
              ),
            ),
          );
        },
      );
}

class EmptyTodoListWidget extends StatelessWidget {
  const EmptyTodoListWidget({super.key});

  @override
  Widget build(BuildContext context) => Center(
        child: Text(
          '暂无待办事项',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      );
}
