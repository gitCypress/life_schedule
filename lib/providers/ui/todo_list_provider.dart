import 'package:life_schedule/data/repository/todo_repository.dart';
import 'package:life_schedule/providers/data/repository_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/todo.dart';

part 'todo_list_provider.g.dart';

@riverpod
Stream<List<Todo>> todosStream(Ref ref) {
  final repository = ref.watch(todoRepositoryProvider);
  return repository.watchAllTodos();
}

@riverpod
Future<Todo?> todoById(Ref ref, int todoId)  {
  final repository = ref.watch(todoRepositoryProvider);
  return repository.getTodoById(todoId);
}

@riverpod
class TodoAction extends _$TodoAction {
  late final TodoRepository _repository;

  @override
  void build() {
    _repository = ref.watch(todoRepositoryProvider);
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
