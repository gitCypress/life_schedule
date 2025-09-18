# 持久化架构设计

本文档详细介绍了项目中持久化层的架构设计思路、分层职责和最佳实践。

## 整体架构概览

```
UI Layer (Widgets)
        ↓
State Management (Riverpod Providers)
        ↓
Business Logic (Repository)
        ↓
Data Access (DAO)
        ↓
ORM Layer (Drift)
        ↓
Database (SQLite)
```

## 目录结构

```
lib/
├── data/
│   ├── local/
│   │   ├── database.dart          # 数据库主配置
│   │   ├── database.g.dart        # 自动生成的数据库代码
│   │   ├── tables/                # 表结构定义
│   │   │   └── todo_items_table.dart
│   │   └── daos/                  # 数据访问对象
│   │       └── todo_items_dao.dart
│   └── repository/                # 业务逻辑层
│       └── todo_repository.dart
└── providers/                     # 依赖注入管理
    ├── database_provider.dart     # 数据库实例提供者
    ├── dao_providers.dart         # DAO 实例提供者
    └── repository_provider.dart   # Repository 实例提供者
```

## 分层职责详解

### 1. Database Layer（数据库层）

**文件**: `lib/data/local/database.dart`

**职责**:
- 配置数据库连接和参数
- 注册表和 DAO
- 管理数据库版本和迁移

```dart
@DriftDatabase(tables: [TodoItems], daos: [TodoItemsDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  TodoItemsDao get todoItemsDao => TodoItemsDao(this);
}
```

**设计要点**:
- 使用 `@DriftDatabase` 注解声明式配置
- 支持依赖注入和测试
- 统一管理所有表和 DAO

### 2. Table Layer（表结构层）

**文件**: `lib/data/local/tables/todo_items_table.dart`

**职责**:
- 定义数据表结构
- 设置字段类型、约束和默认值
- 声明索引和关系

```dart
class TodoItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 100)();
  TextColumn get content => text().named('body').nullable()();
  BoolColumn get isFinished => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
```

**设计要点**:
- 使用 Drift 的类型安全 API
- 明确字段约束和验证规则
- 自动生成对应的数据类

### 3. DAO Layer（数据访问层）

**文件**: `lib/data/local/daos/todo_items_dao.dart`

**职责**:
- 封装具体的数据库操作
- 提供类型安全的查询方法
- 支持响应式数据流

```dart
@DriftAccessor(tables: [TodoItems])
class TodoItemsDao extends DatabaseAccessor<AppDatabase> with _$TodoItemsDaoMixin {
  TodoItemsDao(super.db);

  /// 响应式查询所有待办事项
  Stream<List<TodoItem>> watchAllTodos() => select(todoItems).watch();

  /// 根据 ID 查询单个待办事项
  Future<TodoItem> getTodoById(int id) =>
      (select(todoItems)..where((tbl) => tbl.id.equals(id))).getSingle();
}
```

**设计要点**:
- 继承 `DatabaseAccessor` 获得基础 CRUD 能力
- 使用 `@DriftAccessor` 注解自动生成代码
- 提供领域特定的查询方法
- 支持 Stream 响应式编程

### 4. Repository Layer（仓库层）

**文件**: `lib/data/repository/todo_repository.dart`

**职责**:
- 实现业务逻辑
- 协调多个 DAO（如果需要）
- 提供面向 UI 的数据接口
- 处理数据转换和验证

```dart
class TodoRepository {
  final TodoItemsDao _todoItemsDao;

  TodoRepository(this._todoItemsDao);

  /// 监听所有待办事项
  Stream<List<TodoItem>> watchAllTodos() => _todoItemsDao.watchAllTodos();

  /// 添加新的待办事项
  Future<void> addTodo(String title, {String? content}) {
    final companion = TodoItemsCompanion.insert(
      title: title,
      content: Value(content),
    );
    return _todoItemsDao.into(_todoItemsDao.todoItems).insert(companion);
  }

  /// 更新待办事项
  Future<void> updateTodo(TodoItem todoItem) =>
      _todoItemsDao.update(_todoItemsDao.todoItems).replace(todoItem);

  /// 删除待办事项
  Future<void> deleteTodo(TodoItem todoItem) =>
      _todoItemsDao.delete(_todoItemsDao.todoItems).delete(todoItem);
}
```

**设计要点**:
- 依赖注入 DAO，便于测试和替换
- 使用 Drift 默认方法，避免过度封装
- 提供业务友好的方法签名
- 处理错误和边界情况

### 5. Provider Layer（状态管理层）

**职责**: 管理依赖注入和实例生命周期

#### Database Provider
```dart
@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) => AppDatabase();
```
- 使用 `keepAlive: true` 确保数据库连接在应用生命周期内保持
- 单例模式，全局共享

#### DAO Provider
```dart
@riverpod
TodoItemsDao todoItemsDao(Ref ref){
  final db = ref.watch(appDatabaseProvider);
  return TodoItemsDao(db);
}
```
- 依赖数据库实例
- 自动管理生命周期

#### Repository Provider
```dart
@riverpod
TodoRepository todoRepository(Ref ref){
  final todoItemsDao = ref.watch(todoItemsDaoProvider);
  return TodoRepository(todoItemsDao);
}
```
- 依赖 DAO 实例
- 形成完整的依赖链

## 依赖关系图

```
appDatabaseProvider (keepAlive)
        ↓
todoItemsDaoProvider
        ↓
todoRepositoryProvider
        ↓
UI Components (ConsumerWidget)
```

## 设计优势

### 1. 职责分离
- 每层有明确的职责边界
- 修改某层不影响其他层
- 易于理解和维护

### 2. 依赖注入
- 所有依赖通过 Riverpod 管理
- 支持依赖替换和模拟测试
- 自动处理实例生命周期

### 3. 类型安全
- Drift 提供编译时类型检查
- 减少运行时错误
- IDE 友好的代码补全

### 4. 响应式编程
- 原生支持 Stream
- 数据变化自动更新 UI
- 符合 Flutter 响应式理念

### 5. 可测试性
- 每层都可独立测试
- 支持依赖模拟
- 清晰的测试边界

## 最佳实践

### 1. 代码组织
- 使用 `part` 文件分组相关代码
- 遵循命名约定（表名、DAO 名、Provider 名）
- 保持文件结构一致

### 2. 错误处理
- 在 Repository 层处理业务相关错误
- 使用 Drift 的类型安全特性避免 SQL 错误
- 提供有意义的错误信息

### 3. 性能优化
- 合理使用 `keepAlive` 控制实例生命周期
- 避免在 DAO 中进行复杂业务逻辑
- 利用 Drift 的查询优化特性

### 4. 扩展指南
- 新增表时同时创建对应的 DAO 和 Repository
- 保持 Provider 的依赖链清晰
- 遵循现有的代码风格和模式

这种架构设计确保了代码的可维护性、可测试性和可扩展性，是现代 Flutter 应用数据层的最佳实践。