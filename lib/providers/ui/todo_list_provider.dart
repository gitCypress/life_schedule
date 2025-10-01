import 'package:life_schedule/data/repository/todo_repository.dart';
import 'package:life_schedule/providers/data/repository_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/todo.dart';

part 'todo_list_provider.g.dart';

@riverpod
class TodoList extends _$TodoList {
  late final TodoRepository _repository;

  @override
  Stream<List<Todo>> build() {
    _repository = ref.watch(todoRepositoryProvider);
    return _repository.watchAllTodos();
  }

  Future<void> addTodo({required String title, String? content}) async {
    final newTodo = Todo(
      title: title,
      content: content,
      isFinished: false,
      createdAt: DateTime.now(),
    );
    await _repository.addTodo(newTodo);
  }

  Future<void> updateTodo(Todo todo) async {
    await _repository.updateTodo(todo);
  }

  Future<void> toggleTodoStatus(Todo todo) async {
    final updatedTodo = todo.copyWith(isFinished: !todo.isFinished);
    await updateTodo(updatedTodo);
  }

  Future<void> deleteTodo(Todo todo) async {
    await _repository.deleteTodo(todo);
  }
}