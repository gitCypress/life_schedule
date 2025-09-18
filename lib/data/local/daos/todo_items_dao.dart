part of '../database.dart';

@DriftAccessor(tables: [TodoItems])
class TodoItemsDao extends DatabaseAccessor<AppDatabase> with _$TodoItemsDaoMixin {
  TodoItemsDao(super.db);

  /// 监听所有待办事项的变化。这是一个响应式查询。
  Stream<List<TodoItem>> watchAllTodos() => select(todoItems).watch();

  /// 根据 ID 获取单个待办事项。
  Future<TodoItem> getTodoById(int id) =>
      (select(todoItems)..where((tbl) => tbl.id.equals(id))).getSingle();
}
