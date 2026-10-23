import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks/core/services/preference_manager.dart';
import 'package:tasks/models/task_model.dart';
import 'dart:convert';

import 'package:tasks/widgets/task_list_widget.dart';

class CompleteTasks extends StatefulWidget {
  const CompleteTasks({super.key});

  @override
  State<CompleteTasks> createState() => _CompleteTasksState();
}

class _CompleteTasksState extends State<CompleteTasks> {
  String? name;
  List<TaskModel> tasks = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _loadTask();
  }

  void _loadUserName() async {
    final pref = await SharedPreferences.getInstance();

    setState(() {
      name = pref.getString("username");
    });
  }

  void _loadTask() async {
    final finalTask = PreferenceManager().getString('tasks');

    List<TaskModel> loaded = [];
    if (finalTask != null && finalTask.isNotEmpty) {
      final taskDecode = jsonDecode(finalTask) as List<dynamic>;
      setState(() {
        tasks = taskDecode
            .map((element) => TaskModel.fromJson(element))
            .where((element) => element.isDone == true)
            .toList();
      });
    }

    setState(() {
      isLoading = false;
    });
  }
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
    final updatedTask = tasks
        .map((element) => element.convert())
        .toList();
    PreferenceManager().setString('tasks', jsonEncode(updatedTask));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Completed Tasks")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : TaskListWidget(
                tasks: tasks,
                onTap: (value, index) async {
                  final tappedTask = tasks[index!];
                  final pref = await SharedPreferences.getInstance();
                  final allData = pref.getString("tasks");

                  if (allData != null) {
                    List<dynamic> allDataList = jsonDecode(allData);
                    // Find the task in the full list by name (as unique ID)
                    int globalIndex = allDataList.indexWhere(
                      (e) => e['taskName'] == tappedTask.taskName,
                    );

                    if (globalIndex != -1) {
                      allDataList[globalIndex]['isDone'] = value ?? true;
                      await PreferenceManager().setString(
                        'tasks',
                        jsonEncode(allDataList),
                      );
                      _loadTask(); // Refresh list to show only incomplete tasks
                    }
                  }
                },
          onDelete: (int id) {
            _deleteTask(id);
          }, onEdit: (){_loadTask();},
              ),
      ),
    );
  }
}
