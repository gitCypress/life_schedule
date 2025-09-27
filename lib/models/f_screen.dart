import 'package:flutter/widgets.dart';

/// 携带了特性元数据的 Screen，用于在编译期检查一个 Screen 是否携带了某个特性
/// 考虑到我们为 Screen 引入了懒加载等特性来保证安全
/// 为了避免非要创建出实例来检查一个 Screen 是否携带了某个特性
/// 这里引入了一个 FScreen 的概念来存储相关元数据，从而无需创建实例就可以完成筛选
class FScreen<T extends Widget> {
  final T Function() builder;
  const FScreen(this.builder);
}
