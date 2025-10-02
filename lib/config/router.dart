import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:life_schedule/models/ui_state/todo_edit_mode.dart';
import 'package:life_schedule/screens/calendar_screen.dart';
import 'package:life_schedule/screens/expense_tracking_screen.dart';
import 'package:life_schedule/screens/settings_screen.dart';
import 'package:life_schedule/screens/todo_edit_screen.dart';
import 'package:life_schedule/screens/todo_screen.dart';
import 'package:life_schedule/widgets/main_scaffold/main_scaffold.dart';
import 'package:life_schedule/domain/entities/todo.dart';

final _shellNavigatorKey = GlobalKey<NavigatorState>();
final _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => const MainScaffold(),
        routes: [
          GoRoute(
              path: '/',
              name: 'todo',
              builder: (context, state) => const TodoScreen(),
              routes: [
                GoRoute(
                  path: 'create-todo',
                  name: 'createTodo',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) =>
                  const TodoEditScreen(mode: TodoEditMode.create()),
                ),
                GoRoute(
                  path: 'edit-todo/:id',
                  name: 'editTodo',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    final todoId = int.tryParse(state.pathParameters['id']!);

                    // TODO: 添加更合适的错误页面，应对 Web 情况下手动修改 id 部分的行为
                    if (todoId == null) return const TodoScreen();
                    return TodoEditScreen(mode: TodoEditMode.edit(todoId: todoId));
                  },
                ),
              ]
          ),
          GoRoute(
            path: '/calendar',
            name: 'calender',
            builder: (context, state) => const CalendarScreen(),
          ),
          GoRoute(
            path: '/expense-tracking',
            name: 'expenseTracking',
            builder: (context, state) => const ExpenseTrackingScreen(),
          ),
          GoRoute(
            path: '/settings',
            name: 'settings',
            builder: (context, state) => const SettingsScreen(),
          ),
        ]
    )
  ],
);
