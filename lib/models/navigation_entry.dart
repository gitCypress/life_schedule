import 'package:flutter/cupertino.dart';

/// 导航条目接口
abstract class NavigationEntry {
  String get label;  // 导航标签
  IconData get icon;  // 导航图标
}
