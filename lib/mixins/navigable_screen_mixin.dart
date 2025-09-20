import 'package:flutter/material.dart';
import 'package:life_schedule/models/navigation_entry.dart';

mixin NavigableScreenMixin on Widget{
  NavigationEntry get navEntry;
}