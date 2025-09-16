import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_provider.g.dart';

@riverpod
// 1. 类名从 ThemeNotifier 改为 Theme，继承自 _$Theme
class ThemeCustom extends _$ThemeCustom {
  static const _key = 'isDarkMode';

  // 2. build 方法保持不变，它依然负责加载初始状态
  @override
  Future<bool> build() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_key) ?? false;
  }

  // 3. toggleTheme 方法也保持不变
  Future<void> toggleTheme() async {
    final currentMode = state.value ?? false;
    final newMode = !currentMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, newMode);
    state = AsyncData(newMode);
  }
}