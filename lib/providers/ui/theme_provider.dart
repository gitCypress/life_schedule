import 'package:life_schedule/providers/data/shared_preference_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_provider.g.dart';

@riverpod
// 1. 类名从 ThemeNotifier 改为 Theme，继承自 _$Theme
class ThemeCustom extends _$ThemeCustom {
  static const _key = 'isDarkMode';
  SharedPreferences get _prefs => ref.read(sharedPreferencesProvider);

  // 2. build 方法保持不变，它依然负责加载初始状态
  @override
  bool build() => _prefs.getBool(_key) ?? false;

  // 3. toggleTheme 方法也保持不变
  Future<void> toggleTheme() async {
    final currentMode = state; // `state` 现在直接就是 bool 类型
    final newMode = !currentMode;
    await _prefs.setBool(_key, newMode);
    state = newMode;
  }
}