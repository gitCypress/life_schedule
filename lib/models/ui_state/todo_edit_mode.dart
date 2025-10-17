import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/todo.dart';

part 'todo_edit_mode.freezed.dart';

@freezed
sealed class TodoEditMode with _$TodoEditMode {
  /// ClassName.constructorName() 是命名构造函数的格式
  /// 写在这里的 CreateTodoMode 将会由代码生成器处理，成为密封类 TodoEditMode 的子类
  const factory TodoEditMode.create({required Todo? initialTodo}) = CreateTodoMode;
  const factory TodoEditMode.edit({required int todoId}) = ModifyTodoMode;
}
