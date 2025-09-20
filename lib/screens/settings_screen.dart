import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_schedule/mixins/navigable_screen_mixin.dart';
import 'package:life_schedule/models/navigation_entry.dart';

import '../providers/ui/theme_provider.dart';
import '../providers/ui/app_info_provider.dart';

class SettingsScreen extends ConsumerWidget with NavigableScreenMixin {
  const SettingsScreen({super.key});

  @override
  NavigationEntry get navEntry => _SettingsNavigationEntry();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeCustomProvider);
    final appVersion = ref.watch(appVersionProvider);

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      children: [
        const _SettingsHeader(title: '外观'),
        SwitchListTile(
          secondary: const Icon(Icons.dark_mode_outlined),
          title: const Text('暗色模式'),
          subtitle: const Text('开启或关闭暗色主题'),
          value: isDarkMode.asData?.value ?? false,
          onChanged: (value) {
            ref.read(themeCustomProvider.notifier).toggleTheme();
          },
        ),
        const SizedBox(
          height: 24,
        ),
        const _SettingsHeader(title: '关于'),
        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text('应用版本'),
          subtitle: appVersion.when(
            data: (version) => Text(version),
            loading: () => const Text('加载中...'),
            error: (error, stack) => const Text('无法获取版本信息'),
          ),
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
      child: Text(title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          )),
    );
  }
}

class _SettingsNavigationEntry implements NavigationEntry {
  @override
  IconData get icon => Icons.settings_outlined;

  @override
  String get label => '设置';
}
