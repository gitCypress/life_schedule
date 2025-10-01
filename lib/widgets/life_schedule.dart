import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/ui/theme_provider.dart';
import '../themes/green_theme.dart';
import 'main_scaffold/main_scaffold.dart';

/// LifeSchedule
/// 控制标题和应用主题内容
class LifeSchedule extends ConsumerWidget {
  const LifeSchedule({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const appTheme = MaterialGreenTheme();
    final isDarkMode = ref.watch(themeCustomProvider);

    return MaterialApp(
      /// 供给操作系统使用的元数据
      title: 'LifeSchedule',
      theme: appTheme.light(),
      darkTheme: appTheme.dark(),

      /// 夜间模式
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const MainScaffold(),
    );
  }
}