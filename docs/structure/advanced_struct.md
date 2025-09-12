# Flutter 项目重构指南：迁移到干净架构 (Clean Architecture)

本指南旨在为 Flutter 项目从简单结构迁移到可扩展、可维护的“干净架构”提供一份清晰的蓝图。该架构采用“按功能组织” (Feature-First) 的目录结构。

## 核心思想

架构分为四个层次，遵循严格的依赖规则：**外层可以依赖内层，内层永远不能知道外层的存在**。

1.  **Presentation (表现层)**: UI，只负责显示和用户输入。
2.  **Application (应用层)**: 状态管理 (Riverpod)，连接 UI 和业务逻辑。
3.  **Domain (领域层)**: 核心业务实体和规则，纯 Dart。
4.  **Infrastructure (基础设施层)**: 数据来源的具体实现（API, DB）。

## 目标目录结构 (以 `tasks` 功能为例)

```

lib/
└── src/
└── features/
└── tasks/
├── 1\_domain/
├── 2\_application/
├── 3\_infrastructure/
└── 4\_presentation/

````

---

## 各层职责与文件详解

### ## 1. Domain (领域层)

> 💡 **特点**：最核心、最纯净。不包含任何 Flutter 代码，只有纯 Dart。

#### ### 📁 `entities/task.dart`
* **职责**: 定义核心业务对象 `Task`。
* **推荐包**: `freezed`
* **示例**:
    ```dart
    import 'package:freezed_annotation/freezed_annotation.dart';
    part 'task.freezed.dart';

    @freezed
    class Task with _$Task {
      const factory Task({
        required String id,
        required String title,
        @Default(false) bool isCompleted,
        DateTime? dueDate,
      }) = _Task;
    }
    ```

#### ### 📁 `repositories/task_repository.dart`
* **职责**: 定义数据操作的“契约”（接口），规定了“能做什么”，不关心“怎么做”。
* **示例**:
    ```dart
    import '../entities/task.dart';

    abstract class TaskRepository {
      Future<List<Task>> getTasks();
      Future<void> addTask(Task task);
      Future<void> updateTask(Task task);
    }
    ```

---

### ## 2. Application (应用层)

> 💡 **特点**：UI 和数据之间的桥梁，状态管理中心。

#### ### 📁 `providers/task_list_provider.dart`
* **职责**: 管理任务列表的 UI 状态，并调用 `TaskRepository` 执行操作。
* **推荐包**: `flutter_riverpod`, `riverpod_generator`
* **示例**:
    ```dart
    import 'package:riverpod_annotation/riverpod_annotation.dart';
    import '../../1_domain/entities/task.dart';
    import '../../1_domain/repositories/task_repository.dart';

    part 'task_list_provider.g.dart';

    @riverpod
    class TaskList extends _$TaskList {
      @override
      Future<List<Task>> build() async {
        final taskRepository = ref.watch(taskRepositoryProvider);
        return taskRepository.getTasks();
      }

      Future<void> addTask(String title) async {
        final taskRepository = ref.read(taskRepositoryProvider);
        // ... 实现添加逻辑 ...
      }
    }
    ```

---

### ## 3. Infrastructure (基础设施层)

> 💡 **特点**：所有“脏活累活”的地方，是 Domain 层契约的具体实现者。

#### ### 📁 `repositories/task_repository_impl.dart`
* **职责**: 实现 `TaskRepository` 接口，协调本地和远程数据源，实现云同步逻辑。
* **示例**:
    ```dart
    class TaskRepositoryImpl implements TaskRepository {
      final TaskLocalDataSource _local;
      final TaskRemoteDataSource _remote;

      TaskRepositoryImpl(this._local, this._remote);

      @override
      Future<List<Task>> getTasks() async {
        try {
          final remoteTasks = await _remote.fetchTasks();
          await _local.cacheTasks(remoteTasks);
          return remoteTasks;
        } catch (e) {
          return _local.getTasks(); // 网络失败时返回本地缓存
        }
      }
      // ... 其他方法的实现 ...
    }
    ```

#### ### 📁 `datasources/remote/task_remote_datasource.dart`
* **职责**: 专门负责与后端 API 通信。
* **推荐包**: `dio`
* **示例**:
    ```dart
    class TaskRemoteDataSource {
      final Dio _dio;
      TaskRemoteDataSource(this._dio);

      Future<List<TaskDto>> fetchTasks() async {
        // ... dio.get('/tasks') ...
      }
    }
    ```

#### ### 📁 `datasources/local/task_local_datasource.dart`
* **职责**: 专门负责与本地数据库交互。
* **推荐包**: `drift` (推荐, 关系型), `isar` (推荐, NoSQL)
* **示例**:
    ```dart
    class TaskLocalDataSource {
      final AppDatabase _db; // Drift 数据库实例
      TaskLocalDataSource(this._db);

      Future<List<Task>> getTasks() async {
        // ... _db.select(...) ...
      }
    }
    ```

---

### ## 4. Presentation (表现层)

> 💡 **特点**：用户能看到和交互的一切。

#### ### 📁 `screens/task_list_screen.dart`
* **职责**: 显示任务列表，并响应用户操作。
* **内容**: 一个 `ConsumerWidget`。
* **示例**:
    ```dart
    import 'package:flutter/material.dart';
    import 'package:flutter_riverpod/flutter_riverpod.dart';
    import '../../2_application/providers/task_list_provider.dart';

    class TaskListScreen extends ConsumerWidget {
      const TaskListScreen({super.key});

      @override
      Widget build(BuildContext context, WidgetRef ref) {
        final taskListState = ref.watch(taskListProvider);

        return Scaffold(
          body: taskListState.when(
            data: (tasks) => ListView.builder(),
            loading: () => Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('出错了')),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              ref.read(taskListProvider.notifier).addTask('新任务');
            },
            child: const Icon(Icons.add),
          ),
        );
      }
    }
    ```

## 推荐技术栈总结
* **状态管理**: `flutter_riverpod`
* **HTTP 客户端**: `dio`
* **本地数据库**: `drift` 或 `isar`
* **数据模型**: `freezed`, `json_serializable`
* **路由管理**: `go_router`
