# 工程结构

项目采用 Clean Architecture + 配置驱动架构。

```
lib/
├── main.dart                    # App入口
├── config/                      # 路由和UI配置
├── data/                        # 数据层(Drift)
├── domain/                      # 领域层(Freezed)
├── models/                      # UI数据模型
├── providers/                   # Riverpod状态管理
├── screens/                     # 页面UI
└── widgets/                     # 可复用组件
```

**核心特色：**
- **配置驱动**: 导航和FAB通过配置文件统一管理
- **声明式路由**: go_router 实现类型安全的导航
- **YAGNI原则**: 按需添加功能，避免过度设计

详细架构说明见 `docs/architecture.md`

# important-instruction-reminders
Do what has been asked; nothing more, nothing less.
NEVER create files unless they're absolutely necessary for achieving your goal.
ALWAYS prefer editing an existing file to creating a new one.
NEVER proactively create documentation files (*.md) or README files. Only create documentation files if explicitly requested by the User.