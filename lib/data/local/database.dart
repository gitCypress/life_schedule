import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

part 'tables/todo_items_table.dart';

part 'daos/todo_items_dao.dart';

@DriftDatabase(tables: [TodoItems], daos: [TodoItemsDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  AppDatabase.forTesting(super.e);

  /// 表结构版本号
  @override
  int get schemaVersion => 1;

  /// DAO Getter
  @override
  TodoItemsDao get todoItemsDao => TodoItemsDao(this);
}

LazyDatabase _openConnection() => LazyDatabase(() async {
  final dbFolder = await getApplicationDocumentsDirectory();
  final file = File(p.join(dbFolder.path, 'app_db.sqlite'));
  return NativeDatabase.createInBackground(file);
});
