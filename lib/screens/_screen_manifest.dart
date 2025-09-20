import 'package:flutter/cupertino.dart';
import 'package:life_schedule/screens/calendar_screen.dart';
import 'package:life_schedule/screens/expense_tracking_screen.dart';
import 'package:life_schedule/screens/settings_screen.dart';
import 'package:life_schedule/screens/todo_screen.dart';

List<Widget> screenManifest = const [
  TodoScreen(),
  CalendarScreen(),
  ExpenseTrackingScreen(),
  SettingsScreen(),
];