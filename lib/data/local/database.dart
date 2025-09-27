import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
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
  // 使用应用数据目录而不是文档目录
  final dbFolder = await getApplicationSupportDirectory();
  final file = File(p.join(dbFolder.path, 'app_db.sqlite'));
  if (kDebugMode) {
    print('Database path: ${file.path}');
  }
  return NativeDatabase.createInBackground(file);
});
