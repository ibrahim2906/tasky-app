import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tasks/core/services/preference_manager.dart';
import 'package:tasks/core/widgets/custom_text_form_field.dart';
import 'package:tasks/models/task_model.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController taskNameController = TextEditingController();

  final TextEditingController taskDiscController = TextEditingController();

  bool isHighPrioeity = true;

  @override
  void dispose() {
    taskNameController.dispose();
    taskDiscController.dispose();
    super.dispose();
  }

  final String hintTask = "Task Name";
  final String hintDisc = "Task Description";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    style: IconButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                    ),
                    icon: Icon(
                      CupertinoIcons.left_chevron,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                  SizedBox(width: 5),
                  Row(
                    children: [
                      Text(
                        "New Task",
                        style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 20)
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8,
                ),
                child: Form(
                  key: _key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      CustomTextFormField(
                        controller: taskNameController,
                        maxLines: 1,
                        hint: hintTask,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "$hintTask Name is required";
                          }
                          return null;
                        },
                        title: hintTask,
                      ),

                      SizedBox(height: 25),

                      SizedBox(height: 8),
                      CustomTextFormField(
                        title: hintDisc,
                        controller: taskDiscController,
                        maxLines: 5,
                        hint: hintDisc,
                      ),

                      SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "High Priority",
                            style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 16)
                          ),
                          CupertinoSwitch(
                            value: isHighPrioeity,
                            onChanged: (bool value) {
                              setState(() {
                                isHighPrioeity = value;
                              });
                            },
                          ),
                        ],
                      ),

                      SizedBox(height: 32),
                      ElevatedButton.icon(
                        onPressed: () async {
                          if (_key.currentState!.validate()) {
                            final taskJson = PreferenceManager().getString(
                              'tasks',
                            );
                            List<dynamic> listTasks = [];
                            if (taskJson != null && taskJson.isNotEmpty) {
                              try {
                                listTasks =
                                    jsonDecode(taskJson) as List<dynamic>;
                              } catch (e) {
                                listTasks = [];
                              }
                            }
                            TaskModel model = TaskModel(
                              id: listTasks.length + 1,
                              taskName: taskNameController.text,
                              taskDiscription: taskDiscController.text,
                              isHighPriority: isHighPrioeity,
                            );

                            listTasks.add(model.convert());

                            final taskEncode = jsonEncode(listTasks);
                            await PreferenceManager().setString('tasks', taskEncode);

                            Navigator.pop(context, true);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CupertinoColors.activeGreen,
                          foregroundColor: Colors.white,
                          fixedSize: Size(
                            MediaQuery.of(context).size.width,
                            40,
                          ),
                        ),
                        icon: Icon(CupertinoIcons.create),
                        label: Text("Add Task"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
