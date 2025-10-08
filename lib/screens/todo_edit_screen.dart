import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:life_schedule/models/ui_state/todo_edit_mode.dart';
import 'package:life_schedule/providers/ui/todo_list_provider.dart';
import 'package:life_schedule/widgets/todo_edit_screen/todo_edit_scaffold.dart';

class TodoEditScreen extends HookConsumerWidget {
  const TodoEditScreen({super.key, required this.mode});

  final TodoEditMode mode;

  @override
  Widget build(BuildContext context, WidgetRef ref) => mode.when(
      create: () => const TodoEditScaffold.create(),
      edit: (todoId) {
        final todo = ref.watch(todoByIdProvider(todoId));
        return todo.when(
          loading: () => const Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16,),
                  Text("加载中"),
                ],
              ),
            ),
          ),
          error: (err, stack) => Scaffold(
            body: Center(
                child: Text(
              '加载待办事项失败: $err',
            )),
          ),
          data: (todo) {
            if (todo == null) {
              return const Scaffold(
                body: Center(
                  child: Text("未找到待办事项，你是怎么进来的？"),
                ),
              );
            }
            return TodoEditScaffold.edit(initialTodo: todo);
          },
        );
      });
}
