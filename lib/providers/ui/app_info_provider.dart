import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_info_provider.g.dart';

@Riverpod(keepAlive: true)
Future<PackageInfo> packageInfo(Ref ref) async {
  return await PackageInfo.fromPlatform();
}

@Riverpod(keepAlive: true)
Future<String> appVersion(Ref ref) async {
  final packageInfo = await ref.watch(packageInfoProvider.future);
  return packageInfo.version;
}

@Riverpod(keepAlive: true)
Future<String> appName(Ref ref) async {
  final packageInfo = await ref.watch(packageInfoProvider.future);
  return packageInfo.appName;
}

@Riverpod(keepAlive: true)
Future<String> buildNumber(Ref ref) async {
  final packageInfo = await ref.watch(packageInfoProvider.future);
  return packageInfo.buildNumber;
}