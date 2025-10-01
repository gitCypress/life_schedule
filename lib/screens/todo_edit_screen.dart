import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:life_schedule/models/ui_state/todo_edit_mode.dart';
import 'package:life_schedule/providers/ui/todo_list_provider.dart';

class TodoEditScreen extends HookConsumerWidget {
  const TodoEditScreen({super.key, required this.mode});

  /// 如果 initialTodo 不为 null，则表示是编辑模式，否则是新增模式
  final TodoEditMode mode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialTodo = mode.when(
      create: () => null,
      edit: (todo) => todo,
    );

    final titleController =
        useTextEditingController(text: initialTodo?.title ?? '');
    final contentController =
        useTextEditingController(text: initialTodo?.content ?? '');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          mode.map(create: (_) => '新建待办', edit: (_) => '编辑待办'),
        ),
        actions: [
          IconButton(
            onPressed: () {
              final content = contentController.text;
              final title = titleController.text;

              // TODO: 表单验证应该在这里吗？
              if (title.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('标题不能为空')),
                );
                return;
              }

              mode.when(
                create: () {
                  ref.read(todoListProvider.notifier).addTodo(
                        title: title,
                        content: content,
                      );
                },
                edit: (originalTodo) {
                  final updatedTodo = originalTodo.copyWith(
                    title: title,
                    content: content,
                  );
                  ref.read(todoListProvider.notifier).updateTodo(updatedTodo);
                },
              );
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.save_outlined),
            tooltip: '保存',
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: '标题',
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TextField(
                controller: contentController,
                decoration: const InputDecoration(
                  labelText: '内容',
                  hintText: '详细描述一下吧...',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
