part of '../database.dart';

class TodoItems extends Table {
  /// 主键
  IntColumn get id => integer().autoIncrement()();
  /// 关键内容
  TextColumn get title => text().withLength(min: 1, max: 100)();
  TextColumn get content => text().named('body').nullable()();
  BoolColumn get isFinished => boolean().withDefault(const Constant(false))();
  /// 元数据
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}