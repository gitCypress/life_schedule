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

  /// 在应用启动时预初始化数据库
  /// 返回已经准备好的数据库实例
  static Future<AppDatabase> initialize() async {
    final executor = await _createExecutor();
    final database = AppDatabase(executor);

    // 触发一次简单查询以确保数据库已打开和初始化
    await database.customSelect('SELECT 1').get();

    if (kDebugMode) {
      print('Database initialized successfully');
    }

    return database;
  }

  /// 创建数据库执行器
  static Future<QueryExecutor> _createExecutor() async {
    final dbFolder = await getApplicationSupportDirectory();
    final file = File(p.join(dbFolder.path, 'app_db.sqlite'));

    if (kDebugMode) {
      print('Database path: ${file.path}');
    }

    return NativeDatabase.createInBackground(file);
  }
}

LazyDatabase _openConnection() => LazyDatabase(() async {
  return AppDatabase._createExecutor();
});
