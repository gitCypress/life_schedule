// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 数据库 Provider
///
/// 注意：应该在 main() 中通过 AppDatabase.initialize() 预初始化数据库，
/// 然后使用 override 注入已初始化的实例

@ProviderFor(appDatabase)
const appDatabaseProvider = AppDatabaseProvider._();

/// 数据库 Provider
///
/// 注意：应该在 main() 中通过 AppDatabase.initialize() 预初始化数据库，
/// 然后使用 override 注入已初始化的实例

final class AppDatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  /// 数据库 Provider
  ///
  /// 注意：应该在 main() 中通过 AppDatabase.initialize() 预初始化数据库，
  /// 然后使用 override 注入已初始化的实例
  const AppDatabaseProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'appDatabaseProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return appDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$appDatabaseHash() => r'21b5b23479b7abc176296d7aa7d7512cfa5b6fb2';
