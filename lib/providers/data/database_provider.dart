import 'package:life_schedule/data/local/database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'database_provider.g.dart';

/// 数据库 Provider
///
/// 注意：应该在 main() 中通过 AppDatabase.initialize() 预初始化数据库，
/// 然后使用 override 注入已初始化的实例
@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  throw UnimplementedError(
    'appDatabaseProvider must be overridden with a pre-initialized database. '
    'Call AppDatabase.initialize() in main() and use override.'
  );
}
