import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/local/database.dart';
import 'database_provider.dart';

part 'dao_providers.g.dart';

@riverpod
TodoItemsDao todoItemsDao(Ref ref){
  final db = ref.watch(appDatabaseProvider);
  return TodoItemsDao(db);
}
