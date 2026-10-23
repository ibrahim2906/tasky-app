import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks/models/task_model.dart';
import 'package:tasks/widgets/task_list_widget.dart';

import '../core/services/preference_manager.dart';

class HighPriorityScreen extends StatefulWidget {
  const HighPriorityScreen({
    super.key,
    this.name,
    this.isLoading = false,
    this.tasks = const [],
    this.highPriorityTasks = const [],
    this.onTap,
    this.onDelete, required this.onEdit,
  });

  final String? name;
  final bool isLoading;
  final List<TaskModel> tasks;
  final List<TaskModel> highPriorityTasks;
  final Function(bool?, int?)? onTap;
  final Function(bool?, int?)? onDelete;
  final Function onEdit;

  @override
  State<HighPriorityScreen> createState() => _HighPriorityScreenState();
}

class _HighPriorityScreenState extends State<HighPriorityScreen> {
  late List<TaskModel> _highPriorityTasks;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _highPriorityTasks = widget.highPriorityTasks.isNotEmpty
        ? widget.highPriorityTasks
        : widget.tasks
              .where((task) => task.isHighPriority && !task.isDone)
              .toList();
    _isLoading = widget.isLoading;
    _loadTask();
  }

  Future<void> _loadTask() async {
    setState(() {
      _isLoading = true;
    });

    final pref = await SharedPreferences.getInstance();
    final finalTask = PreferenceManager().getString('tasks');

    List<TaskModel> loaded = [];
    if (finalTask != null && finalTask.isNotEmpty) {
      final taskDecode = jsonDecode(finalTask) as List<dynamic>;
      loaded = taskDecode
          .map((element) => TaskModel.fromJson(element))
          .where((element) => element.isHighPriority && !element.isDone)
          .toList();
    }

    setState(() {
      _highPriorityTasks = loaded;
      _isLoading = false;
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
      _highPriorityTasks.removeWhere((task) => task.id == id);
    });
    final pref = await SharedPreferences.getInstance();
    final updatedTask = _highPriorityTasks
        .map((element) => element.convert())
        .toList();
    PreferenceManager().setString('tasks', jsonEncode(updatedTask));
  }

  @override
  Widget build(BuildContext context) {
    final displayTasks = _highPriorityTasks.isNotEmpty
        ? _highPriorityTasks
        : widget.tasks
              .where((task) => task.isHighPriority && !task.isDone)
              .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('High Priority Tasks'),
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : TaskListWidget(
              tasks: displayTasks,
              onTap: (value, index) async {
                final tappedTask = displayTasks[index!];
                final pref = await SharedPreferences.getInstance();
                final allData = PreferenceManager().getString('tasks');

                if (allData != null) {
                  final allDataList = jsonDecode(allData) as List<dynamic>;
                  final globalIndex = widget.tasks.indexWhere(
                    (task) => task.id == tappedTask.id,
                  );

                  if (globalIndex != -1) {
                    allDataList[globalIndex]['isDone'] = value ?? false;
                    await PreferenceManager().setString(
                      'tasks',
                      jsonEncode(allDataList),
                    );

                    await _loadTask();
                    widget.onTap?.call(value, globalIndex);
                  }
                }
              },
              onDelete: (int? id) {
                _deleteTask(id!);
              }, onEdit: ()=>_loadTask(),
            ),
    );
  }
}
