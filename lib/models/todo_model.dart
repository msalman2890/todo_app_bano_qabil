class Todo {
  String title = "";
  String description = "";
  String? tag;
  DateTime todoTime = DateTime.now();
  bool? isCompleted;
  int? priority;

  Todo(
      {required this.title,
      required this.description,
      this.tag,
      required this.todoTime,
      this.isCompleted = false,
      this.priority});

  Todo.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    tag = json['tag'];
    todoTime = DateTime.parse(json['todoTime']);
    isCompleted = json['isCompleted'];
    priority = json['priority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['tag'] = this.tag;
    data['todoTime'] = this.todoTime.toString();
    data['isCompleted'] = this.isCompleted;
    data['priority'] = this.priority;
    return data;
  }
}
