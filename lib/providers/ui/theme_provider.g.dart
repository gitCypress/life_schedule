// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ThemeCustom)
const themeCustomProvider = ThemeCustomProvider._();

final class ThemeCustomProvider
    extends $AsyncNotifierProvider<ThemeCustom, bool> {
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
}

String _$themeCustomHash() => r'2c31674f50807d08a5497850a790e005f711f9c7';

abstract class _$ThemeCustom extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<bool>, bool>,
        AsyncValue<bool>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
