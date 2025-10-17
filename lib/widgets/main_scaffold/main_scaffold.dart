import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:life_schedule/config/router.dart';
import 'package:life_schedule/providers/data/config_provider.dart';
import 'package:life_schedule/widgets/main_scaffold/nav_bar.dart';

class MainScaffold extends ConsumerWidget {
  const MainScaffold({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uri = router.routeInformationProvider.value.uri.toString();
    if (kDebugMode) {
      print("current location: $uri");
    }
    final appBarTitle =
        ref.read(navConfigProvider)[navigationShell.currentIndex].label;
    final fabConfig = ref.read(fabConfigProvider)[uri];

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        actions: const [
          IconButton(
            onPressed: null,
            icon: Icon(Icons.more_vert),
            tooltip: '更多',
          ),
        ],
      ),
      body: navigationShell,
      bottomNavigationBar: NavBar(navigationShell: navigationShell),

      // --- 核心改动 ---
      floatingActionButton: fabConfig != null
          ? FloatingActionButton(
              tooltip: fabConfig.tooltip,
              onPressed: fabConfig.createOnPressed(context, ref),
              child: fabConfig.child,
            )
          : null,
    );
  }
}
