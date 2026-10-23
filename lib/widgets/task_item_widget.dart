import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks/core/widgets/custom_text_form_field.dart';

import '../core/enums/task_item_action_enum.dart';
import '../core/services/preference_manager.dart';
import '../core/theme/theme_controller.dart';
import '../models/task_model.dart';
import 'custom_checkBox.dart';

class TaskItemWidget extends StatelessWidget {
  TaskItemWidget({
    super.key,
    required this.model,
    required this.onChanged,
    required this.onDelete, required this.onEdit,
  });

  final TaskModel model;
  final Function(bool?) onChanged;
  final Function(int) onDelete;
  final Function onEdit;
  String hintTask = 'Edit Task Name';
  String hintDisc = 'Edit Task Description';
  bool isHighPrioeity = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: double.infinity,
      alignment: Alignment.center,

      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: ThemeController.isDark() ? Colors.transparent : Colors.black12,
          width: .5,
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 8),
          CustomCheckbox(
            value: model.isDone,
            onChanged: (bool? value) {
              onChanged(value);
            },
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.taskName,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                    fontSize: 16,
                    decoration: model.isDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationColor: Theme.of(
                      context,
                    ).colorScheme.onPrimaryContainer,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
                if (model.taskDiscription.isNotEmpty)
                  Text(
                    model.taskDiscription,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                      fontSize: 13,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
              ],
            ),
          ),

          PopupMenuButton(
            color: Theme.of(context).popupMenuTheme.color,
            elevation: 10,
            onSelected: (value) async {
              switch (value) {
                case TaskItemActionEnum.marked:
                  onChanged(!model.isDone);
                case TaskItemActionEnum.edit:
                  final result = await _showBottomSheet(context, model);
                  if(result==true){
                    onEdit();
                  }
                case TaskItemActionEnum.delete:
                  await _showAlertDialog(context);
              }
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            icon: Icon(CupertinoIcons.ellipsis),
            itemBuilder: (context) => TaskItemActionEnum.values.map((e) {
              return PopupMenuItem<TaskItemActionEnum>(
                value: e,
                child: Text(e.name),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Future<String?> _showAlertDialog(context) async {
    final TextEditingController controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Task", selectionColor: Colors.red),
          content: Column(
            children: [
              Text("Are you sure you want to delete this task?"),
              CustomTextFormField(
                title: "Task Name",
                controller: controller,
                maxLines: 1,
                hint: "Enter task name",
              ),
            ],
          ),
          actions: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(
                      context,
                    ).textTheme.displaySmall!.color,
                  ),

                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    onDelete(model.id);
                    Navigator.pop(context);
                  },

                  child: Center(child: Text('Delete')),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _showBottomSheet(BuildContext context, TaskModel model) {
    TextEditingController taskNameController = TextEditingController(
      text: model.taskName,
    );
    TextEditingController taskDiscController = TextEditingController(
      text: model.taskDiscription,
    );
    GlobalKey<FormState> key = GlobalKey<FormState>();
    bool isHighPriority = model.isHighPriority;

    return showModalBottomSheet<bool>(
      backgroundColor: Theme.of(context).colorScheme.surface,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8,
                  ),
                  child: Form(
                    key: key,
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
                              return "Task name is required";
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
                              style: Theme.of(
                                context,
                              ).textTheme.displaySmall!.copyWith(fontSize: 16),
                            ),
                            CupertinoSwitch(
                              value: isHighPriority,
                              onChanged: (bool value) {
                                setState(() {
                                  isHighPriority = value;
                                });
                              },
                            ),
                          ],
                        ),

                        SizedBox(height: 32),
                        ElevatedButton.icon(
                          onPressed: () async {
                            if (key.currentState!.validate() ?? false) {
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
                              TaskModel newModel = TaskModel(
                                id: model.id,
                                taskName: taskNameController.text,
                                taskDiscription: taskDiscController.text,
                                isHighPriority: isHighPriority,
                                isDone: model.isDone,
                              );

                              final int index = listTasks.indexWhere(
                                (e) => e['id'] == model.id,
                              );
                              if (index != -1) {
                                listTasks[index] = newModel.convert();
                              } else {
                                listTasks.add(newModel.convert());
                              }

                              final taskEncode = jsonEncode(listTasks);
                              await PreferenceManager().setString(
                                'tasks',
                                taskEncode,
                              );

                              if (context.mounted) {
                                Navigator.of(context).pop(true);
                              }
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
                          label: Text("save Task"),
                        ),
                      ],
                    ),
                  ),
                );
              },
        );
      },
    );
  }
}
