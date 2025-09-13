import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeProvider = AsyncNotifierProvider(() => ThemeNotifier());

class ThemeNotifier extends AsyncNotifier<bool> {
  static const _key = 'isDarkMode';

  @override
  Future<bool> build() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_key) ?? false;
  }

  Future<void> toggleThemeMode() async {
    final currentMode = state.value ?? false;
    final newMode = !currentMode;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, newMode);
    state = AsyncData(newMode);
  }
}
