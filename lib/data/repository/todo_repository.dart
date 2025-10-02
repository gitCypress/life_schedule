import 'package:drift/drift.dart';
import 'package:life_schedule/domain/entities/todo.dart';

import '../local/database.dart';

class TodoRepository {
  final TodoItemsDao _todoItemsDao;

  TodoRepository(this._todoItemsDao);

  Stream<List<Todo>> watchAllTodos() => _todoItemsDao
      .watchAllTodos()
      .map((items) => items.map((item) => item.toDomain()).toList());

  Future<void> addTodo(Todo todo) => _todoItemsDao
      .into(_todoItemsDao.todoItems)
      .insert(todo.toCompanion());

  Future<void> updateTodo(Todo todo) =>
      _todoItemsDao.update(_todoItemsDao.todoItems).replace(todo.toCompanion());

  Future<void> deleteTodo(Todo todo) =>
      _todoItemsDao.delete(_todoItemsDao.todoItems).delete(todo.toCompanion());

  Future<Todo?> getTodoById(int id) async {
    try {
      final item = await _todoItemsDao.getTodoById(id);
      return item.toDomain();
    } catch (e) {
      return null;
    }
  }

}

extension on TodoItem {
  Todo toDomain() {
    return Todo(
      id: id,
      title: title,
      content: content,
      isFinished: isFinished,
      createdAt: createdAt,
    );
  }
}

extension on Todo {
  TodoItemsCompanion toCompanion() {
    return TodoItemsCompanion(
      id: id == null ? const Value.absent() : Value(id!),
      title: Value(title),
      content: Value(content),
      isFinished: Value(isFinished),
      createdAt: Value(createdAt),
    );
  }
}
