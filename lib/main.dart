import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_schedule/providers/data/shared_preference_provider.dart';
import 'package:life_schedule/widgets/life_schedule.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 确保 Flutter 引擎已初始化

  // 在 UI 启动前初始化
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [  // 使用 override 的方式注入已经初始化的 SharedPreferences 实例
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const LifeSchedule(),
    ),
  );
} // 使用 ProviderScope 引入 Riverpod
