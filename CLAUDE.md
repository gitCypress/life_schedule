# 工程结构

项目采用了Clean Architecture分层架构，确保代码的可维护性和可扩展性。

```
lib/
├── main.dart                    # App入口，配置ProviderScope
│
├── config/                      # 应用配置文件
│   └── navigation_config.dart   # 导航配置（待重构为分散式）
│
├── data/                        # 数据层
│   ├── local/                   # 本地数据源
│   │   ├── daos/               # 数据访问对象
│   │   ├── tables/             # 数据库表定义
│   │   └── database.dart       # 数据库配置
│   └── repository/             # 仓库实现
│       └── todo_repository.dart
│
├── domain/                      # 领域层
│   └── entities/               # 业务实体
│       └── todo.dart
│
├── models/                      # 数据传输对象和UI模型
│   └── nav_destination.dart    # 导航目标模型
│
├── providers/                   # Riverpod状态管理
│   ├── data/                   # 数据相关Provider
│   │   ├── dao_providers.dart
│   │   ├── database_provider.dart
│   │   └── repository_providers.dart
│   └── ui/                     # UI状态Provider
│       ├── navigation_provider.dart
│       ├── theme_provider.dart
│       └── todo_list_provider.dart
│
├── screens/                     # 页面/屏幕UI
│   ├── todo_screen.dart
│   ├── calender_screen.dart
│   ├── expense_tracking_screen.dart
│   └── settings_screen.dart
│
├── services/                    # 业务服务层
│   └── (待扩展)
│
├── themes/                      # 主题配置
│   └── green_theme.dart
│
└── widgets/                     # 通用UI组件
    └── example/
        └── custom_button.dart
```

**各层职责说明：**

  * **`domain/entities/`**: 核心业务实体，不依赖任何外部框架
  * **`data/`**: 数据层，包含Repository实现、DAO、数据库配置
  * **`models/`**: UI数据传输对象，主要服务于展示层
  * **`providers/`**: Riverpod状态管理，分为数据层和UI层Provider
  * **`screens/`**: 页面UI，使用ConsumerWidget监听Provider状态
  * **`services/`**: 业务服务层，处理复杂业务逻辑
  * **`config/`**: 应用级配置文件

**架构原则：**
- 依赖倒置：上层不依赖下层具体实现
- 单一职责：每个文件/类只负责一个职责
- 分离关注点：UI、业务逻辑、数据访问分离
