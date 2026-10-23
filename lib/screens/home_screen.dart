import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:tasks/models/task_model.dart';
import 'package:tasks/screens/profile_screen.dart';
import 'package:tasks/widgets/high_priority_tasks.dart';
import 'package:tasks/widgets/sliver_task_list_widget.dart';
import '../core/services/preference_manager.dart';
import '../widgets/achieved_tasks.dart';
import 'add_task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? name;
  String? userImage;
  String? quoteName;
  List<TaskModel> tasks = [];
  bool isChecked = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _loadTask();
    _loadUserImage();
    _loadQuote();
  }

  void _loadUserName() async {
    setState(() {
      name = PreferenceManager().getString('username');
    });
  }

  void _loadUserImage() async {
    setState(() {
      userImage = PreferenceManager().getString('userImage');
    });
  }

  void _loadQuote() async {
    setState(() {
      quoteName = PreferenceManager().getString('quotename');
    });
  }

  void _loadTask() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 1));
    final pref = await SharedPreferences.getInstance();
    final finalTask = pref.getString('tasks');

    List<TaskModel> loaded = [];
    if (finalTask != null && finalTask.isNotEmpty) {
      try {
        final taskDecode = jsonDecode(finalTask) as List<dynamic>;
        loaded = taskDecode
            .map((element) => TaskModel.fromJson(element))
            .toList();
      } catch (e) {
        // If stored value is corrupted or invalid, start with empty list
        loaded = [];
      }
    }

    setState(() {
      tasks = loaded;
      isLoading = false;
    });
  }

  void _doneTask(bool? value, int? index) async {
    setState(() {
      tasks[index!].isDone = value ?? false;
    });
    final updatedTask = tasks.map((element) => element.convert()).toList();
    PreferenceManager().setString('tasks', jsonEncode(updatedTask));
  }

  void _deleteTask(int id) async {
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
    final updatedTask = tasks.map((element) => element.convert()).toList();
    PreferenceManager().setString('tasks', jsonEncode(updatedTask));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 45,
        child: FloatingActionButton.extended(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) => AddTask()),
            );
            _loadTask();
          },
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          icon: Icon(CupertinoIcons.create),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
          label: Text("Add Task"),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:userImage==null? AssetImage(
                            'assets/images/Leading element.png',
                          ):FileImage(File(userImage!)),
                          backgroundColor: Colors.green,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Welcome back, ${name ?? "guest"}!",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(fontSize: 20),
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'one task ',
                                          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                            fontSize: 13,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'at time',
                                          style: const TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ', one step closer',
                                          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  border: Border.all(color: Colors.green),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: IconButton(
                                  onPressed: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            ProfileScreen(),
                                      ),
                                    );
                                    _loadUserImage();
                                    _loadUserName();
                                    _loadQuote();
                                  },
                                  icon: Icon(CupertinoIcons.settings, size: 30),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          "All your work here",
                          style: Theme.of(
                            context,
                          ).textTheme.displayLarge!.copyWith(fontSize: 32),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "will be done!",
                          style: Theme.of(
                            context,
                          ).textTheme.displayLarge!.copyWith(fontSize: 32),
                        ),
                        SizedBox(width: 7),

                        Image.asset("assets/images/hand.png"),
                      ],
                    ),
                    SizedBox(height: 15),

                    //======Achieved Tasks==========================
                    AchievedTasks(
                      tasks: tasks,
                      name: name,
                      isLoading: true,
                      isChecked: true,
                    ),
                    SizedBox(height: 8),
                    if ((tasks.where((e) => e.isHighPriority)).isNotEmpty)
                      HighPriorityTasks(
                        highPriority: tasks
                            .where((e) => e.isHighPriority)
                            .toList(),
                        tasks: tasks,
                        onTap: (bool? value, int? index) async {
                          _doneTask(value, index);
                        },
                        refresh: () {
                          _loadTask();
                        },
                        onEdit: () => _loadTask(),
                      ),

                    if (tasks.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (tasks.isNotEmpty)
                              Text(
                                "My Tasks",
                                style: Theme.of(context).textTheme.displaySmall!
                                    .copyWith(fontSize: 20),
                              ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              if (isLoading)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  ),
                )
              else
                SliverTaskListWidget(
                  tasks: tasks,
                  onTap: (bool? value, int? index) async {
                    _doneTask(value, index);
                  },
                  onDelete: (int id) {
                    _deleteTask(id);
                  },
                  onEdit: () {
                    _loadTask();
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
