import 'package:flutter/material.dart';
import 'package:tasks/models/task_model.dart';
import 'dart:math';

class AchievedTasks extends StatelessWidget {
  AchievedTasks({
    super.key,
    required this.tasks,
    required this.name,
    required this.isLoading,
    required this.isChecked,
  });

  String? name;
  List<TaskModel> tasks = [];
  bool isChecked = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 72,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Achieved Tasks',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 20),
                ),
                Text(
                  '${tasks.where((tasks) => tasks.isDone).length} Out of ${tasks.length}',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 13),
                ),
              ],
            ),

            Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Transform.rotate(
                    angle: -pi / 2,
                    child: SizedBox(
                      width: 48,
                      height: 48,
                      child: CircularProgressIndicator(
                        value:
                            tasks.where((tasks) => tasks.isDone).length /
                            tasks.length,
                        backgroundColor: Colors.grey,
                        color: Colors.green,
                        strokeCap: StrokeCap.round,
                        strokeWidth: 6,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "${tasks.isEmpty ? 0 : (((tasks.where((tasks) => tasks.isDone).length) / (tasks.length)) * 100).toStringAsFixed(0)}%",
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 15),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
