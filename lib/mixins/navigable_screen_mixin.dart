import 'package:flutter/material.dart';
import 'package:life_schedule/models/navigation_entry.dart';

/// 用于标记一个 Widget 是可导航的屏幕
/// 需要实现 [navEntry] 来提供导航条目
mixin NavigableScreenMixin on Widget{
  NavigationEntry get navEntry;
}