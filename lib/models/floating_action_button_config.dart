import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 悬浮按钮配置接口
abstract class FloatingActionButtonConfig {
  String get tooltip; // 悬浮按钮提示
  Widget? get child; // 悬浮按钮子组件

  /// 间接传参的工厂方法设计
  ///
  /// 问题: FAB的onPressed要求是VoidCallback(无参数)，但需要context/ref
  /// 方案: 用工厂方法实现闭包传参
  ///
  /// 流程:
  /// 1. Screen定义: createOnPressed(context, ref) => () { 使用context/ref }
  /// 2. Scaffold调用: VoidCallback callback = createOnPressed(context, ref)
  /// 3. FAB执行: onPressed: callback (此时context/ref已通过闭包绑定)
  ///
  /// 本质: 通过高阶函数将有参数的需求转换为无参数的VoidCallback
  VoidCallback? createOnPressed(
      BuildContext context, WidgetRef ref);
}
