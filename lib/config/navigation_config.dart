import 'package:flutter/material.dart';
import 'package:life_schedule/screens/calender_screen.dart';
import 'package:life_schedule/screens/expense_tracking_screen.dart';
import '../models/nav_destination.dart';
import '../screens/home_screen.dart';
import '../screens/settings_screen.dart';

/// App 导航目的地配置
final List<NavDestination> appNavDestinations = [
  const NavDestination(
    screen: HomeScreen(),
    icon: Icons.home_outlined,
    label: '首页',
  ),
  const NavDestination(
    screen: CalenderScreen(), // 临时占位符
    icon: Icons.calendar_month_outlined,
    label: '日历',
  ),
  const NavDestination(
    screen: ExpenseTrackingScreen(), // 临时占位符
    icon: Icons.account_balance_wallet_outlined,
    label: '记账',
  ),
  const NavDestination(
    screen: SettingsScreen(),
    icon: Icons.settings_outlined,
    label: '设置',
  ),
];