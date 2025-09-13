import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:life_schedule/providers/theme_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider);

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      children: [
        _SettingsHeader(title: '外观'),
        SwitchListTile(
          secondary: const Icon(Icons.dark_mode_outlined),
          title: const Text('暗色模式'),
          subtitle: const Text('开启或关闭暗色主题'),
          value: isDarkMode.asData?.value ?? false,
          onChanged: (value) {
            ref.read(themeProvider.notifier).toggleThemeMode();
          },
        ),
        const SizedBox(height: 24,),
        _SettingsHeader(title: '关于'),
        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text('应用版本'),
          subtitle: const Text('0.0.1'),
          onTap: () {},
        )
      ],
    );
  }

}

class _SettingsHeader extends StatelessWidget {
  final String title;

  const _SettingsHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 16.0),
      child: Text(
          title,
          style: TextStyle(
            color: Theme
                .of(context)
                .colorScheme
                .primary,
            fontWeight: FontWeight.bold,
            fontSize: 16,)
      ),
    );
  }

}
