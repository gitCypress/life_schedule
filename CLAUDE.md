# 工程结构

这个结构保留了最基本的分离思想，但大大减少了文件夹数量和层级深度，非常容易上手。

```
lib/
├── main.dart             # App入口，配置ProviderScope
│
├── models/               # 存放所有的数据模型
│   └── task_model.dart   # 比如Task类
│
├── providers/            # 存放所有的Riverpod Provider
│   ├── task_provider.dart  # 任务相关的Provider
│   └── auth_provider.dart  # 认证相关的Provider
│
├── screens/              # 存放所有的页面/屏幕UI
│   ├── tasks/
│   │   └── task_list_screen.dart
│   └── auth/
│       └── login_screen.dart
│
├── services/             # 存放所有的“服务”逻辑
│   ├── task_service.dart   # 任务相关的所有数据操作（本地+远程）
│   └── api_service.dart    # Dio的封装和配置
│
└── widgets/              # 存放通用的、可复用的UI组件
    └── custom_app_bar.dart
```

**如何使用这个简化结构：**

  * **`models/`**: 不区分 `entity` 和 `dto`，暂时都放在这里。
  * **`screens/`**: 你的UI，使用 `ConsumerWidget` 来 `watch` `providers/` 里的状态。
  * **`providers/`**: 你的状态管理中心，负责调用 `services/` 里的方法来获取或修改数据，并管理UI状态。
  * **`services/`**: 这是关键的简化。我们**暂时不分 `Repository` 和 `DataSource`**。比如 `TaskService` 这个类，就直接负责调用 `Dio` 请求网络、调用 `Drift/Isar` 操作数据库，并把数据处理好，返回给 `Provider`。它融合了之前复杂架构中 `Infrastructure` 和部分 `Domain` 的职责。

这个结构足够清晰，能够支撑你完成应用的核心功能，并且在未来也很容易向更完善的架构迁移。
