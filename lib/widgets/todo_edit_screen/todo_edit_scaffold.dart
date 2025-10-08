import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/entities/todo.dart';
import '../../providers/ui/todo_list_provider.dart';

class TodoEditScaffold extends HookConsumerWidget {
  const TodoEditScaffold.edit({
    super.key,
    required this.initialTodo,
  });

  const TodoEditScaffold.create({
    super.key,
  }) : initialTodo = null;

  final Todo? initialTodo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController =
        useTextEditingController(text: initialTodo?.title ?? '');
    final contentController =
        useTextEditingController(text: initialTodo?.content ?? '');

    return Scaffold(
      appBar: AppBar(
        title: Text(initialTodo == null ? '新建待办' : '编辑待办'),
        actions: [
          IconButton(
            onPressed: () => _handleSave(
              context: context,
              ref: ref,
              title: titleController.text,
              content: contentController.text,
            ),
            icon: const Icon(Icons.save_outlined),
            tooltip: '保存',
          )
        ],
      ),
      body: _TodoEditScaffoldBody(
        titleController: titleController,
        contentController: contentController,
      ),
    );
  }

  void _handleSave({
    required BuildContext context,
    required WidgetRef ref,
    required String title,
    required String content,
  }) {
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('标题不能为空')),
      );
      return;
    }

    final actionsNotifier = ref.read(todoActionProvider.notifier);

    if (initialTodo == null) {
      actionsNotifier.addTodo(
        title: title,
        content: content,
      );
    } else {
      final updatedTodo = initialTodo!.copyWith(
        title: title,
        content: content,
      );
      actionsNotifier.updateTodo(updatedTodo);
    }

    context.pop();
  }
}

class _TodoEditScaffoldBody extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController contentController;

  const _TodoEditScaffoldBody({
    required this.titleController,
    required this.contentController,
  });

  @override
  Widget build(BuildContext context) => Padding(
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
      );
}
