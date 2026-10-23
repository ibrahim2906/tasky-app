import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks/models/task_model.dart';
import 'package:tasks/widgets/task_item_widget.dart';

import 'custom_checkBox.dart';

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({super.key, required this.tasks, required this.onTap,required  this.onDelete, required this.onEdit});

  final List<TaskModel> tasks;
  final Function(bool?, int?) onTap;
  final Function(int) onDelete;
  final Function onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 50),
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: TaskItemWidget(
              model: tasks[index],
              onChanged: (bool? value) {
                onTap(value, index);
              },
              onDelete: (int id) {
                onDelete(id);
              }, onEdit: (){onEdit();},
            ),
          );
        },
      ),
    );
  }
}
