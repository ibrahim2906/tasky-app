import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks/models/task_model.dart';
import 'package:tasks/widgets/task_item_widget.dart';

import '../core/services/preference_manager.dart';

class SliverTaskListWidget extends StatefulWidget {
   const SliverTaskListWidget({
    super.key,
    required this.tasks,
    required this.onTap,
    required  Function(int id) onDelete,
    required this.onEdit,
  });

  final List<TaskModel> tasks;
  final Function(bool?, int?) onTap;
  final Function onEdit;

  @override
  State<SliverTaskListWidget> createState() => _SliverTaskListWidgetState();
}

class _SliverTaskListWidgetState extends State<SliverTaskListWidget> {

  _deleteTask(int id) async {
    List<TaskModel> tasks = [];
    final finalTask = PreferenceManager().getString('tasks');

    if (finalTask != null && finalTask.isNotEmpty) {
      final taskDecode = jsonDecode(finalTask) as List<dynamic>;

      tasks = taskDecode.map((element) => TaskModel.fromJson(element)).toList();
      tasks.removeWhere((e) => e.id == id);
    }
    setState(() {
      tasks.removeWhere((task) => task.id == id);
    });
    final pref = await SharedPreferences.getInstance();
    final updatedTask = tasks
        .map((element) => element.convert())
        .toList();
    PreferenceManager().setString('tasks', jsonEncode(updatedTask));
  }

  @override
  Widget build(BuildContext context) {
    return widget.tasks.isEmpty
        ? SliverToBoxAdapter(
      child: Text(
        "No Tasks",
        style: Theme
            .of(context)
            .textTheme
            .displaySmall,
      ),
    )
        : SliverPadding(
      padding: const EdgeInsets.only(bottom: 50),
      sliver: SliverList.builder(
        itemCount: widget.tasks.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: TaskItemWidget(
                model: widget.tasks[index],
                onChanged: (bool? value) {
                  widget.onTap(value, index);
                },
                onDelete: (int id) {
                  _deleteTask(id);
                }, onEdit:()=>widget.onEdit(),
            ),
          );
        },
      ),
    );
  }
}
