import 'package:flutter/cupertino.dart';

/// 封装底部导航栏目的地信息的数据类
class NavDestination {
  final Widget screen;  // 导航项对应 Widget
  final IconData icon;  // 图标
  final String label;  // 标签

  const NavDestination({
    required this.screen,
    required this.icon,
    required this.label,
  });
}
