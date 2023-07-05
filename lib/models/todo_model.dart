import 'dart:io';

class Todo {
  String title = "";
  String description = "";
  String? tag;
  DateTime todoTime = DateTime.now();
  bool? isCompleted;
  int? priority;
  File? image;

  Todo(
      {required this.title,
      required this.description,
      this.tag,
      required this.todoTime,
      this.isCompleted = false,
      this.image,
      this.priority});

  Todo.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    tag = json['tag'];
    todoTime = DateTime.parse(json['todoTime']);
    isCompleted = json['isCompleted'];
    priority = json['priority'];
    if (json["image"] != null && json["image"] != "") {
      image = File(json["image"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['tag'] = this.tag;
    data['todoTime'] = this.todoTime.toString();
    data['isCompleted'] = this.isCompleted;
    data['priority'] = this.priority;
    if (this.image != null) {
      data['image'] = this.image!.path;
    }
    return data;
  }
}
