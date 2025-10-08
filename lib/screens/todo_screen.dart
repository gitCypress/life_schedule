import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_schedule/mixins/fab_screen_mixin.dart';
import 'package:life_schedule/mixins/navigable_screen_mixin.dart';
import 'package:life_schedule/models/floating_action_button_config.dart';
import 'package:life_schedule/models/navigation_entry.dart';
import 'package:life_schedule/widgets/todo_screen/fab_todo_dialog_widget.dart';
import 'package:life_schedule/widgets/todo_screen/todo_list_view_widget.dart';

import '../providers/ui/todo_list_provider.dart';

class TodoScreen extends ConsumerWidget
    with NavigableScreenMixin, FabScreenMixin {
  const TodoScreen({super.key});

  @override
  NavigationEntry get navEntry => _TodoNavigationEntry();

  @override
  FloatingActionButtonConfig get fabConfig => _TodoFloatingActionButtonConfig();

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
  String get tooltip => '添加待办';

  @override
  VoidCallback? createOnPressed(BuildContext context, WidgetRef ref) => () {
        _showAddTodoDialog(context, ref);
      };

  void _showAddTodoDialog(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return FabTodoDialogWidget(
            titleController: titleController,
            contentController: contentController);
      },
    ).then((_) {
      titleController.dispose();
      contentController.dispose();
    });
  }
}
