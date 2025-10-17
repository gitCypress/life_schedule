import 'package:flutter/material.dart';
import 'package:life_schedule/models/navigation_destination_config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../config/nav_bar_config.dart';

part 'config_provider.g.dart';

@riverpod
List<NavigationDestinationConfig> navConfig(Ref ref) => navBarConfig;