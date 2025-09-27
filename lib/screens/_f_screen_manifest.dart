import 'package:life_schedule/models/f_screen.dart';
import 'package:life_schedule/screens/calendar_screen.dart';
import 'package:life_schedule/screens/expense_tracking_screen.dart';
import 'package:life_schedule/screens/settings_screen.dart';
import 'package:life_schedule/screens/todo_screen.dart';

final List<FScreen> fScreenManifest = [
  FScreen<TodoScreen>(() => const TodoScreen()),
  FScreen<CalendarScreen>(() => const CalendarScreen()),
  FScreen<ExpenseTrackingScreen>(() => const ExpenseTrackingScreen()),
  FScreen<SettingsScreen>(() => const SettingsScreen()),
];