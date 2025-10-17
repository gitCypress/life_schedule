import 'package:flutter/cupertino.dart';

class NavigationDestinationConfig {
  NavigationDestinationConfig(
      {required this.icon, required this.selectedIcon, required this.label});

  final Icon icon;
  final Icon selectedIcon;
  final String label;
}
