import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../controller/todo_controller.dart';
import '../models/todo_model.dart';
import '../widgets/add_todo_bottomsheet.dart';
import '../widgets/todo_tile.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  TodoController controller = TodoController();
  int currentSelectedIndex = 0;

  @override
  void initState() {
    setState(() {
      controller.getData().then((value) => setState(() {}));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(15))),
              backgroundColor: Theme.of(context).colorScheme.secondary,
              builder: (context) {
                return AddTodoBottomSheet(
                  controller: controller,
                );
              });
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            _showSearchTextField(),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: ((context, index) {
                  Todo item = controller.searchedTodoList != null
                      ? controller.searchedTodoList![index]
                      : controller.todoList[index];
                  return TodoTile(todo: item);
                }),
                itemCount: controller.searchedTodoList != null
                    ? controller.searchedTodoList!.length
                    : controller.todoList.length,
              ),
            ),
            // Lttie.network(
            //     "https://assets8.lottiefiles.com/packages/lf20_x62chJ.json")
          ],
        ),
      ),
    );
  }

  TextField _showSearchTextField() {
    return TextField(
      cursorColor: const Color(0xff979797),
      style: GoogleFonts.lato(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: const Color(0xffAFAFAF),
      ),
      onChanged: (value) {
        setState(() {
          controller.searchTodo(value);
        });
      },
      decoration: InputDecoration(
          fillColor: const Color(0xff1d1d1d),
          filled: true,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "assets/search.png",
              height: 24,
              width: 24,
            ),
          ),
          hintText: "Search for your task...",
          hintStyle: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: const Color(0xffAFAFAF)),
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff979797)))),
    );
  }
}
