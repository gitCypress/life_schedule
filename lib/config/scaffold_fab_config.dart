import 'package:flutter/material.dart';
import 'package:life_schedule/models/floating_action_button_config.dart';

import '../widgets/todo_screen/fab_todo_dialog_widget.dart';

final scaffoldFabConfig = <String, FloatingActionButtonConfig>{
  '/': FloatingActionButtonConfig(
    child: const Icon(Icons.add),
    tooltip: '添加待办',
    createOnPressed: (context, ref) => () {
      showDialog(
        context: context,
        builder: (context) => const FabTodoDialogWidget(),
      );
    },
  ),
};
