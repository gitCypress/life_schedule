// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ThemeCustom)
const themeCustomProvider = ThemeCustomProvider._();

final class ThemeCustomProvider extends $NotifierProvider<ThemeCustom, bool> {
  const ThemeCustomProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'themeCustomProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$themeCustomHash();

  @$internal
  @override
  ThemeCustom create() => ThemeCustom();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$themeCustomHash() => r'ad35084605d35d68c28960576aaf4cd5ffb19151';

abstract class _$ThemeCustom extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<bool, bool>, bool, Object?, Object?>;
    element.handleValue(ref, created);
  }
}
