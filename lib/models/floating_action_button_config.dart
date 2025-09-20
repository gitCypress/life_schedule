import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class FloatingActionButtonConfig {
  String get tooltip;
  Widget? get child;

  VoidCallback? createOnPressed(BuildContext context, WidgetRef ref);
}