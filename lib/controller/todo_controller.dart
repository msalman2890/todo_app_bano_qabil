import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/todo_model.dart';

class TodoController {
  List<Todo> todoList = [];
  List<Todo>? searchedTodoList;

  void addTodo(
      String title, String description, DateTime date, BuildContext context,
      {File? image}) {
    Todo _todo = Todo(
        title: title, description: description, todoTime: date, image: image);
    todoList.add(_todo);
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Todo has been added successfully"),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3)));
    setData();
  }

  List<String> convertTodolistToStringList() {
    // Todo List -> Map list -> STring list
    List<Map<String, dynamic>> todoInMap =
        todoList.map((e) => e.toJson()).toList();
    List<String> todoInString = todoInMap.map((e) => jsonEncode(e)).toList();

    return todoInString;
  }

  void convertStringListInToTodoList(List<String> todoInString) {
    // STring list -> Map list -> Todo list
    List todoInMap = todoInString.map((e) => jsonDecode(e)).toList();
    List<Todo> todoInClass = todoInMap.map((e) => Todo.fromJson(e)).toList();

    todoList = todoInClass;
  }

  Future<void> setData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList('todo_list', convertTodolistToStringList());
  }

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? todoInString = prefs.getStringList('todo_list');
    convertStringListInToTodoList(todoInString ?? []);
  }

  void searchTodo(String searchKey) {
    if (searchKey.isEmpty) {
      searchedTodoList = null;
    } else {
      List<Todo> results = todoList
          .where((element) => element.title.contains(searchKey))
          .toList();

      searchedTodoList = results;
    }
  }
}
