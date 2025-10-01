import 'package:flutter/cupertino.dart';
import 'package:life_schedule/models/floating_action_button_config.dart';

/// 用于标记一个 Widget 具有悬浮按钮
/// 需要实现 [fabConfig] 来提供悬浮按钮配置
mixin FabScreenMixin on Widget{
  FloatingActionButtonConfig get fabConfig;
}