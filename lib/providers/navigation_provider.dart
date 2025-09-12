import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// 底部导航栏当前选中的索引
final navigationIndexProvider = StateProvider<int>((ref) => 0);
