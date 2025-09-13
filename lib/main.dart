import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:life_schedule/providers/navigation_provider.dart';
import 'package:life_schedule/providers/theme_provider.dart';
import 'package:life_schedule/screens/calender_screen.dart';
import 'package:life_schedule/screens/expense_tracking_screen.dart';
import 'package:life_schedule/screens/home_screen.dart';
import 'package:life_schedule/screens/settings_screen.dart';
import 'package:life_schedule/widgets/bottom_nav_bar.dart';
import 'package:life_schedule/themes/green_theme.dart';

void main() =>
    runApp(ProviderScope(child: const LifeSchedule()));

class LifeSchedule extends ConsumerWidget {
  const LifeSchedule({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const appTheme = MaterialGreenTheme();
    final isDarkMode = ref.watch(themeProvider).asData?.value ?? false;

    return MaterialApp(
        title: 'LifeSchedule',
        theme: appTheme.light(),
        darkTheme: appTheme.dark(),
        themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
        home: const MainScreen(),
      );
  }
}

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  static const List<Widget> _screens = [
    HomeScreen(),
    CalenderScreen(),
    ExpenseTrackingScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationIndexProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('LifeSchedule'),
        actions: const [
          IconButton(
            onPressed: null,
            icon: Icon(Icons.more_vert),
            tooltip: '更多',
          ),
        ],
      ),
      body: _screens[selectedIndex],
      bottomNavigationBar: const BottomNavBar(),
      floatingActionButton: const FloatingActionButton(
        tooltip: '添加',
        onPressed: null,
        child: Icon(Icons.add),
      ),
    );
  }


}

