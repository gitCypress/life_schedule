# 工程结构

项目采用Clean Architecture + 分散式导航架构。

```
lib/
├── main.dart                    # App入口，分散式导航实现
├── mixins/                      # 分散式架构核心
│   ├── navigable_screen_mixin.dart
│   └── fab_screen_mixin.dart
├── data/                        # 数据层(Drift)
├── domain/                      # 领域层(Freezed)
├── models/                      # UI数据模型
├── providers/                   # Riverpod状态管理
├── screens/                     # 页面UI + Mixin实现
└── ...
```

**核心特色：**
- **分散式导航**: 每个Screen通过Mixin自治管理导航和FAB
- **工厂模式**: 依赖注入解决context/ref传递
- **YAGNI原则**: 按需添加功能，避免过度设计

# important-instruction-reminders
Do what has been asked; nothing more, nothing less.
NEVER create files unless they're absolutely necessary for achieving your goal.
ALWAYS prefer editing an existing file to creating a new one.
NEVER proactively create documentation files (*.md) or README files. Only create documentation files if explicitly requested by the User.