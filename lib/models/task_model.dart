class TaskModel {
  final int id;
  final String taskName;
  final String taskDiscription;
  final bool isHighPriority;
  bool isDone;

  TaskModel({
    required this.id,
    required this.taskName,
    required this.taskDiscription,
    required this.isHighPriority,
    this.isDone = false,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json["id"],
      taskName: json["taskName"],
      taskDiscription: json["taskDiscription"],
      isHighPriority: json["isHighPriority"],
      isDone: json["isDone"] ?? false,
    );
  }

  Map<String, dynamic> convert() {
    return {
      "id": id,
      "taskName": taskName,
      "taskDiscription": taskDiscription,
      "isHighPriority": isHighPriority,
      "isDone": isDone,
    };
  }

  @override
  String toString() {
    return 'TaskModel{id: $id, taskName: $taskName, taskDiscription: $taskDiscription, isHighPriority: $isHighPriority, isDone: $isDone}';
  }
}
