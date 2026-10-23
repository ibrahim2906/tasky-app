enum TaskItemActionEnum { marked(name: "mark as done"),
  edit(name: "Edit"),
  delete(name:"Delete");

  final String name;
  const TaskItemActionEnum({required this.name});
}