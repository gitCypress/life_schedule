// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_edit_mode.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TodoEditMode {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is TodoEditMode);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'TodoEditMode()';
  }
}

/// @nodoc
class $TodoEditModeCopyWith<$Res> {
  $TodoEditModeCopyWith(TodoEditMode _, $Res Function(TodoEditMode) __);
}

/// Adds pattern-matching-related methods to [TodoEditMode].
extension TodoEditModePatterns on TodoEditMode {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateTodoMode value)? create,
    TResult Function(ModifyTodoMode value)? edit,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case CreateTodoMode() when create != null:
        return create(_that);
      case ModifyTodoMode() when edit != null:
        return edit(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateTodoMode value) create,
    required TResult Function(ModifyTodoMode value) edit,
  }) {
    final _that = this;
    switch (_that) {
      case CreateTodoMode():
        return create(_that);
      case ModifyTodoMode():
        return edit(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateTodoMode value)? create,
    TResult? Function(ModifyTodoMode value)? edit,
  }) {
    final _that = this;
    switch (_that) {
      case CreateTodoMode() when create != null:
        return create(_that);
      case ModifyTodoMode() when edit != null:
        return edit(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? create,
    TResult Function(Todo todo)? edit,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case CreateTodoMode() when create != null:
        return create();
      case ModifyTodoMode() when edit != null:
        return edit(_that.todo);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() create,
    required TResult Function(Todo todo) edit,
  }) {
    final _that = this;
    switch (_that) {
      case CreateTodoMode():
        return create();
      case ModifyTodoMode():
        return edit(_that.todo);
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? create,
    TResult? Function(Todo todo)? edit,
  }) {
    final _that = this;
    switch (_that) {
      case CreateTodoMode() when create != null:
        return create();
      case ModifyTodoMode() when edit != null:
        return edit(_that.todo);
      case _:
        return null;
    }
  }
}

/// @nodoc

class CreateTodoMode implements TodoEditMode {
  const CreateTodoMode();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is CreateTodoMode);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'TodoEditMode.create()';
  }
}

/// @nodoc

class ModifyTodoMode implements TodoEditMode {
  const ModifyTodoMode({required this.todo});

  final Todo todo;

  /// Create a copy of TodoEditMode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ModifyTodoModeCopyWith<ModifyTodoMode> get copyWith =>
      _$ModifyTodoModeCopyWithImpl<ModifyTodoMode>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ModifyTodoMode &&
            (identical(other.todo, todo) || other.todo == todo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, todo);

  @override
  String toString() {
    return 'TodoEditMode.edit(todo: $todo)';
  }
}

/// @nodoc
abstract mixin class $ModifyTodoModeCopyWith<$Res>
    implements $TodoEditModeCopyWith<$Res> {
  factory $ModifyTodoModeCopyWith(
          ModifyTodoMode value, $Res Function(ModifyTodoMode) _then) =
      _$ModifyTodoModeCopyWithImpl;
  @useResult
  $Res call({Todo todo});

  $TodoCopyWith<$Res> get todo;
}

/// @nodoc
class _$ModifyTodoModeCopyWithImpl<$Res>
    implements $ModifyTodoModeCopyWith<$Res> {
  _$ModifyTodoModeCopyWithImpl(this._self, this._then);

  final ModifyTodoMode _self;
  final $Res Function(ModifyTodoMode) _then;

  /// Create a copy of TodoEditMode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? todo = null,
  }) {
    return _then(ModifyTodoMode(
      todo: null == todo
          ? _self.todo
          : todo // ignore: cast_nullable_to_non_nullable
              as Todo,
    ));
  }

  /// Create a copy of TodoEditMode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TodoCopyWith<$Res> get todo {
    return $TodoCopyWith<$Res>(_self.todo, (value) {
      return _then(_self.copyWith(todo: value));
    });
  }
}

// dart format on
