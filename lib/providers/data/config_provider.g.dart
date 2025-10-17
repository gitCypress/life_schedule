// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(navConfig)
const navConfigProvider = NavConfigProvider._();

final class NavConfigProvider extends $FunctionalProvider<
        List<NavigationDestinationConfig>,
        List<NavigationDestinationConfig>,
        List<NavigationDestinationConfig>>
    with $Provider<List<NavigationDestinationConfig>> {
  const NavConfigProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'navConfigProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$navConfigHash();

  @$internal
  @override
  $ProviderElement<List<NavigationDestinationConfig>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<NavigationDestinationConfig> create(Ref ref) {
    return navConfig(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<NavigationDestinationConfig> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<List<NavigationDestinationConfig>>(value),
    );
  }
}

String _$navConfigHash() => r'e4effa0b0276966b2757a971c692c52d57d6408f';

@ProviderFor(fabConfig)
const fabConfigProvider = FabConfigProvider._();

final class FabConfigProvider extends $FunctionalProvider<
        Map<String, FloatingActionButtonConfig>,
        Map<String, FloatingActionButtonConfig>,
        Map<String, FloatingActionButtonConfig>>
    with $Provider<Map<String, FloatingActionButtonConfig>> {
  const FabConfigProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'fabConfigProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$fabConfigHash();

  @$internal
  @override
  $ProviderElement<Map<String, FloatingActionButtonConfig>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Map<String, FloatingActionButtonConfig> create(Ref ref) {
    return fabConfig(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, FloatingActionButtonConfig> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<Map<String, FloatingActionButtonConfig>>(value),
    );
  }
}

String _$fabConfigHash() => r'ed2107287ee8eacedfe76ff567828623a3cbe106';
