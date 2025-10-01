// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screen_manifest_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(fScreenManifest)
const fScreenManifestProvider = FScreenManifestProvider._();

final class FScreenManifestProvider extends $FunctionalProvider<
    List<FScreen<Widget>>,
    List<FScreen<Widget>>,
    List<FScreen<Widget>>> with $Provider<List<FScreen<Widget>>> {
  const FScreenManifestProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'fScreenManifestProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$fScreenManifestHash();

  @$internal
  @override
  $ProviderElement<List<FScreen<Widget>>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<FScreen<Widget>> create(Ref ref) {
    return fScreenManifest(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<FScreen<Widget>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<FScreen<Widget>>>(value),
    );
  }
}

String _$fScreenManifestHash() => r'19917a3d199e7f60f4c54cb6c9700b3185b5ef99';
