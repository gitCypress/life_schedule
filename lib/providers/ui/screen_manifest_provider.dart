import 'package:flutter/cupertino.dart';
import 'package:life_schedule/screens/_screen_manifest.dart' as manifest;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'screen_manifest_provider.g.dart';

@riverpod
List<Widget> screenManifest(Ref ref) => manifest.screenManifest;