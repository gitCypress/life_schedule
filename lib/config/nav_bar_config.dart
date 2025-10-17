import 'package:flutter/material.dart';

import '../models/navigation_destination_config.dart';

final navBarConfig = [
  NavigationDestinationConfig(
    icon: const Icon(Icons.home_outlined),
    selectedIcon: const Icon(Icons.home),
    label: '首页',
  ),
  NavigationDestinationConfig(
    icon: const Icon(Icons.calendar_month_outlined),
    selectedIcon: const Icon(Icons.calendar_month),
    label: '日历',
  ),
  NavigationDestinationConfig(
    icon: const Icon(Icons.account_balance_wallet_outlined),
    selectedIcon: const Icon(Icons.account_balance_wallet),
    label: '记账',
  ),
  NavigationDestinationConfig(
    icon: const Icon(Icons.settings_outlined),
    selectedIcon: const Icon(Icons.settings),
    label: '设置',
  ),
];