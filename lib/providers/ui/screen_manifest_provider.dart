import 'package:flutter/cupertino.dart';
import 'package:life_schedule/models/f_screen.dart';
import 'package:life_schedule/config/f_screen_manifest.dart' as manifest;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'screen_manifest_provider.g.dart';

@riverpod
List<FScreen> fScreenManifest(Ref ref) => manifest.fScreenManifest;
