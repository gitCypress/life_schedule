import 'package:flutter/material.dart';
import 'package:life_schedule/mixins/navigable_screen_mixin.dart';
import 'package:life_schedule/models/navigation_entry.dart';


class CalendarScreen extends StatelessWidget with NavigableScreenMixin {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('这是日程页'));
  }

  @override
  NavigationEntry get navEntry => _CalendarNavigationEntry();
}

class _CalendarNavigationEntry implements NavigationEntry{
  @override
  IconData get icon => Icons.calendar_month_outlined;

  @override
  String get label => '日历';
}
