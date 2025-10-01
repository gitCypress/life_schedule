import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/todo.dart';

part 'todo_edit_mode.freezed.dart';

@freezed
sealed class TodoEditMode with _$TodoEditMode {
  const factory TodoEditMode.create() = CreateTodoMode;
  const factory TodoEditMode.edit({required Todo todo}) = ModifyTodoMode;
}
