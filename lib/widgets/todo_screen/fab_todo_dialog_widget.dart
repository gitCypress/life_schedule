import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/ui_state/todo_edit_mode.dart';
import '../../providers/ui/todo_list_provider.dart';
import '../../screens/todo_edit_screen.dart';

class FabTodoDialogWidget extends HookConsumerWidget {
  const FabTodoDialogWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useTextEditingController();
    final contentController = useTextEditingController();

    return AlertDialog(
        title: const Text('创建待办事项'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              autofocus: true,
              decoration: const InputDecoration(hintText: '标题'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(
                labelText: '内容（可选）',
                hintText: '详细描述事项',
              ),
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              // TODO: 这里的详细编辑路由切换不会迁移框中已有的内容
              IconButton(
                icon: const Icon(Icons.fullscreen),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const TodoEditScreen(
                        mode: TodoEditMode.create(),
                      ),
                    ),
                  );
                },
                tooltip: '详细编辑',
              ),
              const Spacer(),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('取消'),
              ),
              TextButton(
                onPressed: () {
                  final title = titleController.text;
                  if (title.isNotEmpty) {
                    ref.read(todoActionProvider.notifier).addTodo(
                          title: title,
                          content: contentController.text.isNotEmpty
                              ? contentController.text
                              : null,
                        );
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('添加'),
              ),
            ],
          ),
        ],
      );
  }
}
