import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:life_schedule/models/ui_state/todo_edit_mode.dart';
import 'package:life_schedule/screens/expense_tracking_screen.dart';
import 'package:life_schedule/screens/settings_screen.dart';
import 'package:life_schedule/screens/todo_edit_screen.dart';
import 'package:life_schedule/screens/todo_screen.dart';
import 'package:life_schedule/widgets/main_scaffold/main_scaffold.dart';

import '../domain/entities/todo.dart';
import '../screens/calendar_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => MainScaffold(
        navigationShell: navigationShell,
      ),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/', // 这是第一个 tab 的路径，也是应用的初始路径
              name: 'todo', // 使用包的导航方法时使用的标签
              builder: (context, state) => const TodoScreen(),
              // 2. 将 create 和 edit 作为 TodoScreen 的子路由
              routes: [
                GoRoute(
                  path: 'create-todo', // 相对路径，实际为 /create-todo
                  name: 'createTodo',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    // 获取来自创建任务小窗口的数据
                    final extra = state.extra;
                    Todo? existedText; // 默认是 null，表示没有
                    if (extra is Todo) existedText = extra;
                    if (kDebugMode) {
                      print(
                        "existedText: [${existedText?.title}, ${existedText?.content}]");
                    }

                    return TodoEditScreen(
                      mode: TodoEditMode.create(initialTodo: existedText),
                    );
                  },
                ),
                GoRoute(
                  path: 'edit-todo/:id', // 相对路径，实际为 /edit-todo/:id
                  name: 'editTodo',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    final todoId = int.tryParse(state.pathParameters['id']!);
                    if (todoId == null) return const TodoScreen();
                    return TodoEditScreen(
                      mode: TodoEditMode.edit(todoId: todoId),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/calendar',
            name: 'calender',
            builder: (context, state) => const CalendarScreen(),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/expense',
            name: 'expenseTracking',
            builder: (context, state) => const ExpenseTrackingScreen(),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/settings',
            name: 'settings',
            builder: (context, state) => const SettingsScreen(),
          ),
        ]),
      ],
    ),
  ],
);
