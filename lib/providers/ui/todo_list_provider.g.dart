// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(todosStream)
const todosStreamProvider = TodosStreamProvider._();

final class TodosStreamProvider extends $FunctionalProvider<
        AsyncValue<List<Todo>>, List<Todo>, Stream<List<Todo>>>
    with $FutureModifier<List<Todo>>, $StreamProvider<List<Todo>> {
  const TodosStreamProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'todosStreamProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$todosStreamHash();

  @$internal
  @override
  $StreamProviderElement<List<Todo>> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<Todo>> create(Ref ref) {
    return todosStream(ref);
  }
}

String _$todosStreamHash() => r'608a4e274a93ca99e56b004756902a357535e4fc';

@ProviderFor(todoById)
const todoByIdProvider = TodoByIdFamily._();

final class TodoByIdProvider
    extends $FunctionalProvider<AsyncValue<Todo?>, Todo?, FutureOr<Todo?>>
    with $FutureModifier<Todo?>, $FutureProvider<Todo?> {
  const TodoByIdProvider._(
      {required TodoByIdFamily super.from, required int super.argument})
      : super(
          retry: null,
          name: r'todoByIdProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$todoByIdHash();

  @override
  String toString() {
    return r'todoByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Todo?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Todo?> create(Ref ref) {
    final argument = this.argument as int;
    return todoById(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is TodoByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$todoByIdHash() => r'b5043d7e4eb5f0d30eddc7c4a97bd8c0e44d8ac7';

final class TodoByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Todo?>, int> {
  const TodoByIdFamily._()
      : super(
          retry: null,
          name: r'todoByIdProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  TodoByIdProvider call(
    int todoId,
  ) =>
      TodoByIdProvider._(argument: todoId, from: this);

  @override
  String toString() => r'todoByIdProvider';
}

@ProviderFor(TodoAction)
const todoActionProvider = TodoActionProvider._();

final class TodoActionProvider extends $NotifierProvider<TodoAction, void> {
  const TodoActionProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'todoActionProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$todoActionHash();

  @$internal
  @override
  TodoAction create() => TodoAction();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$todoActionHash() => r'9ffa0826189e25baae57ffc875ceea89952b6960';

abstract class _$TodoAction extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<void, void>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<void, void>, void, Object?, Object?>;
    element.handleValue(ref, null);
  }
}
