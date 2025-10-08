import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// 用于标记一个 Widget 是全屏二级页面
/// 这类页面会覆盖底部导航栏，通常作为子路由存在
mixin FullScreenRouteMixin on Widget {
  /// 路由路径（相对于父路由），例如 'create-t odo' 或 'edit-t odo/:id'
  String get routePath;

  /// 路由名称，用于命名导航
  String get routeName;

  /// 父路由名称，声明该页面属于哪个父路由
  String get parentRouteName;

  /// 从 GoRouterState 构建带参数的页面实例
  /// 子类可以重写此方法来处理路径参数和 extra 数据
  Widget buildWithState(GoRouterState state) => this;
}
