import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:life_schedule/domain/entities/todo.dart';
import 'package:life_schedule/providers/data/repository_providers.dart';
import 'package:life_schedule/providers/data/shared_preference_provider.dart';
import 'package:life_schedule/widgets/life_schedule.dart';
import 'package:life_schedule/widgets/todo_screen/fab_todo_dialog_widget.dart';
import 'package:life_schedule/widgets/todo_screen/todo_list_view_widget.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mocks.mocks.dart';

void main() {
  late MockTodoRepository mockTodoRepository;

  /// 所有测试开始前只运行一次
  setUpAll((){
    SharedPreferences.setMockInitialValues({});
  });

  /// 测试用例开始前会调用该函数，在函数内进行的初始化是为了测试隔离
  setUp(() {
    mockTodoRepository = MockTodoRepository();
  });

  ///测试三步骤：Arrange 准备，Act 操作，assert 验证

  testWidgets('通过 Fab 添加一个新待办事项', (WidgetTester tester) async {
    /// === Arrange ===

    // 模拟 prefs 和数据库的实时数据流
    final prefs = await SharedPreferences.getInstance();
    final todosStreamController = StreamController<List<Todo>>();

    // .watchAllTodos() 返回模拟数据流
    when(mockTodoRepository.watchAllTodos())
        .thenAnswer((_) => todosStreamController.stream);

    // 直接让 .addTodo() 成功
    when(mockTodoRepository.addTodo(any)).thenAnswer((invocation) async {
      final todo = invocation.positionalArguments.first as Todo;
      final todoWithId = todo.copyWith(id: 1);
      todosStreamController.add([todoWithId]);
    });

    await tester.pumpWidget(ProviderScope(
      overrides: [
        todoRepositoryProvider.overrideWithValue(mockTodoRepository),
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const LifeSchedule(),
    ));

    // 1. 初始时流中无数据，会进行加载
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // 添加空列表，模拟空状态
    todosStreamController.add([]);
    await tester.pump();

    // 2. 显示列表为空的 Widget
    expect(find.byType(EmptyTodoListWidget), findsOneWidget);

    /// === Act ===

    await tester.tap(find.byIcon(Icons.add)); // 点击 FAB
    await tester.pumpAndSettle(); // 等待弹出动画

    // 3. 出现添加待办事项的对话框
    expect(find.byType(FabTodoDialogWidget), findsOneWidget);

    await tester.enterText(find.widgetWithText(TextField, '标题'), '测试title');
    await tester.enterText(
        find.widgetWithText(TextField, '内容（可选）'), '测试context');

    await tester.tap(find.text('添加')); // 点击添加
    await tester.pumpAndSettle(); // 等待dialog关闭动画完成

    /// === Assert ===

    final captured = verify(mockTodoRepository.addTodo(captureAny)).captured;
    // 4. addTodo被正确调用
    expect(captured.length, 1);

    final capturedTodo = captured.first as Todo;

    // 5. 验证保存的内容是正确的
    expect(capturedTodo.title, '测试title');
    expect(capturedTodo.content, '测试context');

    // mock已在第48行推送数据流，这里等待UI重建即可
    await tester.pump();

    // 6. 找到新添加的列
    expect(find.text('测试title'), findsOneWidget);
    // 7. 空列表提示消失
    expect(find.byType(EmptyTodoListWidget), findsNothing);

    await todosStreamController.close();
  });
}
