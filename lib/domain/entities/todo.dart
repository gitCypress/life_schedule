import 'package:freezed_annotation/freezed_annotation.dart';

// 1. 确保 part 指令的文件名与当前文件名匹配
part 'todo.freezed.dart';

@freezed
abstract class Todo with _$Todo {
  const factory Todo({
    int? id,
    required String title,
    String? content,
    required bool isFinished,
    required DateTime createdAt,
  }) = _Todo;
}