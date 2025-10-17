import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_schedule/data/local/database.dart';
import 'package:life_schedule/providers/data/database_provider.dart';
import 'package:life_schedule/providers/data/shared_preference_provider.dart';
import 'package:life_schedule/widgets/life_schedule.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 确保 Flutter 引擎已初始化

  // 在 UI 启动前初始化异步依赖
  final results = await Future.wait([
    SharedPreferences.getInstance(),
    AppDatabase.initialize(),  // 预初始化数据库
  ]);

  final prefs = results[0] as SharedPreferences;
  final database = results[1] as AppDatabase;

  runApp(
    ProviderScope(
      overrides: [
        // 使用 override 的方式注入已经初始化的实例
        sharedPreferencesProvider.overrideWithValue(prefs),
        appDatabaseProvider.overrideWithValue(database),
      ],
      child: const LifeSchedule(),
    ),
  );
}
