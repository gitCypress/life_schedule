# LifeSchedule 架构文档

## 概述

LifeSchedule 采用 Clean Architecture 分层架构，结合现代 Flutter 开发的最佳实践，实现了一个可维护、可测试、可扩展的生活管理应用。

## 技术栈

### 核心框架
- **Flutter SDK**: >=3.2.0
- **Dart**: >=3.2.0

### 状态管理
- **Riverpod 3.0**: 提供声明式、可测试的状态管理
- **riverpod_annotation**: 通过代码生成减少样板代码
- **flutter_hooks**: 组件级状态管理
- **hooks_riverpod**: Hooks 与 Riverpod 的集成

### 数据持久化
- **Drift 2.28**: 类型安全的 SQLite 封装
- **sqlite3_flutter_libs**: SQLite 原生库
- **path_provider**: 获取应用目录

### 导航
- **go_router 16.2**: 声明式路由，支持深链接和类型安全的导航

### 不可变数据
- **freezed 3.1**: 通过代码生成创建不可变对象，减少样板代码
- **freezed_annotation**: Freezed 注解

### 其他
- **shared_preferences**: 轻量级键值对存储
- **package_info_plus**: 获取应用信息
- **cupertino_icons**: iOS 风格图标

## 架构分层

```
┌─────────────────────────────────────────┐
│         Presentation Layer              │
│   (widgets, screens, providers/ui)      │
├─────────────────────────────────────────┤
│         Application Layer               │
│         (providers/data)                │
├─────────────────────────────────────────┤
│         Domain Layer                    │
│         (domain/entities)               │
├─────────────────────────────────────────┤
│         Data Layer                      │
│   (data/repository, data/local)         │
├─────────────────────────────────────────┤
│         External Services               │
│   (SQLite, SharedPreferences)           │
└─────────────────────────────────────────┘
```

### 1. Domain Layer (领域层)

**职责**: 定义核心业务实体和业务规则

**目录结构**:
```
domain/
└── entities/
    ├── todo.dart           # Todo 实体定义
    └── todo.freezed.dart   # Freezed 生成的代码
```

**特点**:
- 使用 Freezed 创建不可变对象
- 不依赖任何外部框架（纯 Dart）
- 定义业务实体的核心属性和行为

**示例**:
```dart
@freezed
abstract class Todo with _$Todo {
  const factory Todo({
    int? id,
    required String title,
    String? content,
    required bool isFinished,
    required DateTime createdAt,
  }) = _Todo;
}
```

### 2. Data Layer (数据层)

**职责**: 管理数据的持久化和数据源

**目录结构**:
```
data/
├── local/
│   ├── database.dart       # Drift 数据库配置
│   ├── tables/             # 表结构定义
│   │   └── todo_items_table.dart
│   └── daos/               # 数据访问对象
│       └── todo_items_dao.dart
└── repository/             # 仓储模式
    └── todo_repository.dart
```

**特点**:
- 使用 Repository 模式隔离数据源
- Drift 提供类型安全的 SQL 操作
- DAO 层负责具体的数据库操作
- Repository 层提供领域层友好的 API

**数据流**:
```
Repository → DAO → Drift Database → SQLite
```

### 3. Providers Layer (提供者层)

**职责**: 管理应用状态和依赖注入

**目录结构**:
```
providers/
├── data/                   # 数据层的 Provider
│   ├── database_provider.dart
│   ├── dao_providers.dart
│   ├── repository_providers.dart
│   ├── config_provider.dart
│   └── shared_preference_provider.dart
└── ui/                     # UI 层的 Provider
    ├── todo_list_provider.dart
    ├── theme_provider.dart
    ├── app_info_provider.dart
    └── navigation_provider.dart
```

**分类**:

**Data Providers** (数据提供者):
- 提供数据库、DAO、Repository 的实例
- 管理配置数据（导航、FAB 配置）
- 生命周期与应用一致

**UI Providers** (UI 提供者):
- 提供 UI 状态和业务逻辑
- 监听数据变化并更新 UI
- 可以被组件订阅

### 4. Presentation Layer (展示层)

**职责**: 用户界面和用户交互

**目录结构**:
```
screens/                    # 页面级组件
├── todo_screen.dart
├── todo_edit_screen.dart
├── calendar_screen.dart
├── expense_tracking_screen.dart
└── settings_screen.dart

widgets/                    # 可复用组件
├── main_scaffold/
│   ├── main_scaffold.dart
│   └── nav_bar.dart
├── todo_screen/
│   ├── todo_list_view_widget.dart
│   └── fab_todo_dialog_widget.dart
└── todo_edit_screen/
    └── todo_edit_scaffold.dart

models/                     # UI 数据模型
├── floating_action_button_config.dart
├── navigation_destination_config.dart
└── ui_state/
    ├── todo_edit_mode.dart
    └── todo_edit_mode.freezed.dart
```

**设计原则**:
- Screen: 页面级组件，处理路由参数和整体布局
- Widget: 可复用的 UI 组件，按功能模块组织
- Model: UI 层的数据结构，与业务实体分离

## 导航系统

### go_router 配置

采用声明式路由，使用 `StatefulShellRoute.indexedStack` 实现带底部导航栏的多分支路由。

**路由结构**:
```
StatefulShellRoute (MainScaffold)
  ├── Branch[/]                 # Todo 首页
  │   ├── /create-todo          # 全屏创建 (parentNavigatorKey)
  │   └── /edit-todo/:id        # 全屏编辑 (parentNavigatorKey)
  ├── Branch[/calendar]         # 日历
  ├── Branch[/expense]          # 记账
  └── Branch[/settings]         # 设置
```

**关键特性**:

1. **StatefulShellRoute**: 保持每个分支的导航栈状态
2. **parentNavigatorKey**: 子路由使用根导航器实现全屏显示
3. **路由监听**: MainScaffold 监听 `router.routeInformationProvider` 获取当前路由

### 配置驱动的 UI

**底部导航栏配置** (`config/nav_bar_config.dart`):
```dart
final navBarConfig = [
  NavigationDestinationConfig(
    icon: const Icon(Icons.home_outlined),
    selectedIcon: const Icon(Icons.home),
    label: '首页',
  ),
  // ...
];
```

**FAB 配置** (`config/scaffold_fab_config.dart`):
```dart
final scaffoldFabConfig = <String, FloatingActionButtonConfig>{
  '/': FloatingActionButtonConfig(
    child: const Icon(Icons.add),
    tooltip: '添加待办',
    createOnPressed: (context, ref) => () { ... },
  ),
};
```

**优势**:
- UI 配置与实现分离
- 易于扩展新的导航目标
- 支持基于路由的动态 FAB

## 数据流

### 数据读取流程

```
UI Widget
  → ref.watch(todosStreamProvider)
    → TodoRepository.watchAllTodos()
      → TodoItemsDao.watchAllTodos()
        → Drift Stream<List<TodoItem>>
          → 自动映射为 Stream<List<Todo>>
            → UI 自动重建
```

### 数据修改流程

```
UI Event (点击保存)
  → ref.read(todoActionProvider.notifier).addTodo()
    → TodoRepository.addTodo(todo)
      → TodoItemsDao.insert()
        → Drift 插入数据到 SQLite
          → Stream 自动发出新数据
            → 订阅了 todosStreamProvider 的 Widget 重建
```

### 关键设计

**Repository 模式**:
- 隔离 UI 层和数据层
- 提供领域友好的 API（使用 Todo 实体而不是 TodoItem 表对象）
- 便于测试和更换数据源

**Stream 响应式**:
- Drift 的 `watchAllTodos()` 返回 Stream
- Riverpod 的 StreamProvider 自动管理订阅
- UI 层通过 `ref.watch()` 响应式更新

## 状态管理

### Provider 类型

**StreamProvider** - 监听数据流:
```dart
@riverpod
Stream<List<Todo>> todosStream(Ref ref) {
  final repository = ref.watch(todoRepositoryProvider);
  return repository.watchAllTodos();
}
```

**FutureProvider** - 异步数据:
```dart
@riverpod
Future<Todo?> todoById(Ref ref, int todoId) {
  final repository = ref.watch(todoRepositoryProvider);
  return repository.getTodoById(todoId);
}
```

**NotifierProvider** - 可变状态:
```dart
@riverpod
class TodoAction extends _$TodoAction {
  @override
  void build() {
    _repository = ref.watch(todoRepositoryProvider);
  }

  Future<void> addTodo({...}) async { ... }
  Future<void> updateTodo(Todo todo) async { ... }
}
```

### 依赖注入

通过 Riverpod Provider 实现依赖注入，遵循依赖倒置原则：

```dart
// 数据库 Provider
@riverpod
AppDatabase database(Ref ref) => AppDatabase();

// DAO Provider
@riverpod
TodoItemsDao todoItemsDao(Ref ref) {
  final db = ref.watch(databaseProvider);
  return db.todoItemsDao;
}

// Repository Provider
@riverpod
TodoRepository todoRepository(Ref ref) {
  final dao = ref.watch(todoItemsDaoProvider);
  return TodoRepository(dao);
}
```

## 代码生成

项目使用多个代码生成工具减少样板代码：

### Freezed (不可变对象)

**用途**: 生成不可变数据类、copyWith、toString、==、hashCode 等

**示例**:
```dart
// domain/entities/todo.dart
@freezed
abstract class Todo with _$Todo {
  const factory Todo({...}) = _Todo;
}

// 生成 todo.freezed.dart
```

**运行**: `flutter pub run build_runner build`

### Riverpod Generator

**用途**: 生成类型安全的 Provider

**示例**:
```dart
// providers/ui/todo_list_provider.dart
@riverpod
Stream<List<Todo>> todosStream(Ref ref) { ... }

// 生成 todo_list_provider.g.dart
// 提供 todosStreamProvider
```

**运行**: `flutter pub run build_runner build`

### Drift (数据库)

**用途**: 生成类型安全的 SQL 查询代码

**示例**:
```dart
// data/local/database.dart
@DriftDatabase(tables: [TodoItems], daos: [TodoItemsDao])
class AppDatabase extends _$AppDatabase { ... }

// 生成 database.g.dart
```

**运行**: `flutter pub run build_runner build`

## 测试策略

### 单元测试

**数据层**:
- Repository 测试：验证数据转换和业务逻辑
- DAO 测试：使用 `AppDatabase.forTesting` 测试数据库操作

**业务逻辑**:
- Provider 测试：使用 `ProviderContainer` 测试状态变化

### 集成测试

- 端到端用户流程测试
- 路由导航测试

### Widget 测试

- 组件渲染测试
- 用户交互测试

## 添加新功能的流程

### 1. 添加新的数据实体

```
1. domain/entities/     → 定义实体 (Freezed)
2. data/local/tables/   → 定义表结构 (Drift)
3. data/local/daos/     → 创建 DAO
4. data/repository/     → 实现 Repository
5. providers/           → 创建 Provider
6. 运行 build_runner
```

### 2. 添加新的导航目标

```
1. config/router.dart           → 添加 StatefulShellBranch
2. config/nav_bar_config.dart   → 添加导航配置
3. screens/                     → 创建 Screen
4. (可选) config/scaffold_fab_config.dart → 配置 FAB
```

### 3. 添加子路由

```
1. config/router.dart → 在对应 routes: [] 中添加 GoRoute
2. 使用 parentNavigatorKey 实现全屏显示（如需要）
3. 创建对应的 Screen 或 Widget
```

## 性能优化

### 数据库优化
- 使用 `LazyDatabase` 延迟初始化
- 使用 `NativeDatabase.createInBackground` 后台创建
- 合理使用索引和查询优化

### 状态管理优化
- 使用 `select()` 限制监听范围
- 避免不必要的 Provider rebuild
- 使用 `family` 实现细粒度缓存

### UI 优化
- StatefulShellRoute 保持导航栈状态，避免重建
- 使用 const 构造函数减少重建
- 合理使用 `ListView.builder` 懒加载

## 常见问题

### Q: 为什么 Repository 返回 Todo 而不是 TodoItem？

A: Repository 模式的核心是提供领域友好的 API。TodoItem 是数据库表对象（数据层），而 Todo 是业务实体（领域层）。通过在 Repository 中进行转换，UI 层不需要知道底层数据结构。

### Q: 为什么使用 StatefulShellRoute 而不是普通的 GoRoute？

A: StatefulShellRoute.indexedStack 会保持每个分支的导航栈状态。当用户在不同 tab 间切换时，每个 tab 的页面状态都会被保留，提供更好的用户体验。

### Q: 为什么子路由需要 parentNavigatorKey？

A: 默认情况下，子路由会在 StatefulShellRoute 的 body 区域显示，底部导航栏仍然可见。使用 parentNavigatorKey 让子路由使用根导航器，实现全屏显示。

### Q: 如何添加新的配置驱动的 FAB？

A: 在 `config/scaffold_fab_config.dart` 中添加新的路由对应的 FAB 配置，MainScaffold 会根据当前路由自动显示对应的 FAB。

## 项目约定

### 命名规范
- 文件名: snake_case (如 `todo_screen.dart`)
- 类名: PascalCase (如 `TodoScreen`)
- 变量/函数: camelCase (如 `todoRepository`)
- 常量: camelCase (如 `navBarConfig`)
- Provider: 以 Provider 结尾 (如 `todoRepositoryProvider`)

### 文件组织
- Screen 文件放在 `screens/`
- 可复用 Widget 按功能模块组织在 `widgets/[module]/`
- 私有 Widget 使用下划线前缀 (如 `_TodoListTile`)

### 代码风格
- 优先使用 const 构造函数
- 使用 => 简化单表达式函数
- 避免深层嵌套，适当提取 Widget
- 添加必要的注释说明业务逻辑

## 工具和命令

### 代码生成
```bash
# 一次性生成
flutter pub run build_runner build

# 监听模式（开发时使用）
flutter pub run build_runner watch

# 删除旧文件重新生成
flutter pub run build_runner build --delete-conflicting-outputs
```

### 测试
```bash
# 运行所有测试
flutter test

# 运行特定测试
flutter test test/path/to/test.dart

# 生成测试覆盖率
flutter test --coverage
```

### 分析
```bash
# 运行 Dart 分析器
flutter analyze

# 格式化代码
flutter format lib/
```

## 参考资源

- [Riverpod 官方文档](https://riverpod.dev/)
- [Drift 官方文档](https://drift.simonbinder.eu/)
- [go_router 官方文档](https://pub.dev/packages/go_router)
- [Freezed 官方文档](https://pub.dev/packages/freezed)
- [Flutter 官方文档](https://flutter.dev/docs)
