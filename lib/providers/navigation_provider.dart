import 'package:riverpod_annotation/riverpod_annotation.dart';

// 1. 必须添加 part 指令，指向将要生成的代码文件。
part 'navigation_provider.g.dart';

@riverpod
class NavigationIndex extends _$NavigationIndex {
  @override
  int build() {
    return 0;
  }

  void setIndex(int newIndex) {
    state = newIndex;
  }
}
