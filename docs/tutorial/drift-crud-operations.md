# Drift CRUD 操作指南

本文档介绍如何在 Drift 中使用默认的 CRUD 操作方法。

## 基本操作模式

所有操作都通过 DAO 访问，基本模式为：
```dart
_daoInstance.operation(_daoInstance.tableName).method()
```

## Insert 操作

```dart
// 插入新记录
Future<int> addTodo(String title, {String? content}) {
  final companion = TodoItemsCompanion.insert(
    title: title,
    content: Value(content),
  );
  return _todoItemsDao.into(_todoItemsDao.todoItems).insert(companion);
}
```

## Update 操作

```dart
// 替换整个记录
Future<void> updateTodo(TodoItem todoItem) =>
    _todoItemsDao.update(_todoItemsDao.todoItems).replace(todoItem);

// 使用条件更新特定字段
Future<void> updateTodoTitle(int id, String newTitle) =>
    (_todoItemsDao.update(_todoItemsDao.todoItems)..where((tbl) => tbl.id.equals(id)))
        .write(TodoItemsCompanion(title: Value(newTitle)));
```

## Delete 操作

```dart
// 删除特定记录
Future<void> deleteTodo(TodoItem todoItem) =>
    _todoItemsDao.delete(_todoItemsDao.todoItems).delete(todoItem);

// 使用条件删除
Future<void> deleteTodoById(int id) =>
    (_todoItemsDao.delete(_todoItemsDao.todoItems)..where((tbl) => tbl.id.equals(id)))
        .go();
```

## Select 操作

```dart
// 查询所有记录
Future<List<TodoItem>> getAllTodos() =>
    _todoItemsDao.select(_todoItemsDao.todoItems).get();

// 条件查询单个记录
Future<TodoItem> getTodoById(int id) =>
    (_todoItemsDao.select(_todoItemsDao.todoItems)..where((tbl) => tbl.id.equals(id)))
        .getSingle();

// 监听变化（响应式查询）
Stream<List<TodoItem>> watchAllTodos() =>
    _todoItemsDao.select(_todoItemsDao.todoItems).watch();
```

## 常用查询条件

```dart
// 等于
..where((tbl) => tbl.id.equals(id))

// 包含文本
..where((tbl) => tbl.title.contains('关键词'))

// 多条件
..where((tbl) => tbl.completed.equals(false) & tbl.priority.isIn([1, 2]))

// 排序
..orderBy([(tbl) => OrderingTerm.asc(tbl.createdAt)])

// 限制数量
..limit(10)
```

## 注意事项

1. **Companion 对象**：插入和更新时使用 `*Companion` 类，可以指定哪些字段需要更新
2. **Value 包装**：可选字段需要用 `Value()` 包装，必填字段直接传值
3. **异步操作**：所有数据库操作都是异步的，返回 `Future` 或 `Stream`
4. **响应式查询**：使用 `.watch()` 而不是 `.get()` 来监听数据变化