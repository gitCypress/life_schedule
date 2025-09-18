// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dao_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(todoItemsDao)
const todoItemsDaoProvider = TodoItemsDaoProvider._();

final class TodoItemsDaoProvider
    extends $FunctionalProvider<TodoItemsDao, TodoItemsDao, TodoItemsDao>
    with $Provider<TodoItemsDao> {
  const TodoItemsDaoProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'todoItemsDaoProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$todoItemsDaoHash();

  @$internal
  @override
  $ProviderElement<TodoItemsDao> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TodoItemsDao create(Ref ref) {
    return todoItemsDao(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TodoItemsDao value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TodoItemsDao>(value),
    );
  }
}

String _$todoItemsDaoHash() => r'7d59d1ca1e9371abe18c58e57b8a1f28990c538d';
