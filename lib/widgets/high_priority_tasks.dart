import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasks/models/task_model.dart';
import 'package:tasks/screens/high_priority_screen.dart';
import 'package:tasks/widgets/custom_checkBox.dart';

class HighPriorityTasks extends StatelessWidget {
  const HighPriorityTasks({
    super.key,
    required this.highPriority,
    required this.onTap,
    required this.tasks,
    required this.refresh, required this.onEdit,
  });

  final List<TaskModel> highPriority;
  final List<TaskModel> tasks;

  final Function(bool?, int?) onTap;
  final Function refresh;
  final Function onEdit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'High Priority Tasks',
                        style: TextStyle(color: Colors.green, fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      ...tasks.reversed
                          .where((e) => e.isHighPriority)
                          .take(4)
                          .map((element) {
                            return Row(
                              children: [
                                CustomCheckbox(
                                  value: element.isDone,
                                  onChanged: (bool? value) {
                                    final index = tasks.indexWhere(
                                      (e) => e.id == element.id,
                                    );
                                    onTap(value, index);
                                  },
                                ),

                                Expanded(
                                  child: Text(
                                    element.taskName,
                                    style: element.isDone
                                        ? Theme.of(context).textTheme.titleSmall
                                        : Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(fontSize: 16),
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            );
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if ((tasks.where((tasks) => tasks.isHighPriority).length) > 4)
          Positioned(
            top: 180,
            right: 10,
            child: GestureDetector(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => HighPriorityScreen(
                      tasks: tasks,
                      highPriorityTasks: highPriority,
                      onTap: (bool? value, int? index) {
                        if (index != null) {
                          onTap(value, index);
                        }
                      }, onEdit: ()=>onEdit(),
                    ),
                  ),
                );
              },

              child: SvgPicture.asset(
                "assets/images/arrow.svg",
                width: 40,
                height: 40,
              ),
            ),
          ),
      ],
    );
  }
}
