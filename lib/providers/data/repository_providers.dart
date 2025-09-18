import 'package:life_schedule/providers/data/dao_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repository/todo_repository.dart';

part 'repository_providers.g.dart';

@riverpod
TodoRepository todoRepository(Ref ref){
  final todoItemsDao = ref.watch(todoItemsDaoProvider);
  return TodoRepository(todoItemsDao);
}

