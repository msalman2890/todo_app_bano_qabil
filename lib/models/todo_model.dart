class Todo {
  String title, description;
  String? tag;
  DateTime todoTime;
  int? priority;
  bool isCompleted = false;

  Todo({
    required this.title,
    required this.description,
    this.tag,
    required this.todoTime,
    this.priority,
  });
}
