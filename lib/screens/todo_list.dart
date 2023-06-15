import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/controller/todo_controller.dart';
import 'package:todo_app/models/todo_model.dart';
import '../widgets/todo_tile.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  TodoController controller = TodoController();
  String? title, description;
  DateTime? date;

  @override
  void initState() {
    setState(() {
      controller.getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _showAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(15))),
              backgroundColor: const Color(0xff363636),
              builder: (context) {
                return _bottomSheetWidget();
              });
        },
        backgroundColor: const Color(0xff8687E7),
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
          ],
        ),
      ),
    );
  }

  AppBar _showAppBar() {
    return AppBar(
      backgroundColor: Colors.black,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Image.asset("assets/sort.png"),
      ),
      title: Text(
        'Todo',
        style: GoogleFonts.lato(
          fontWeight: FontWeight.w400,
          fontSize: 20,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Image.asset(
            "assets/user.png",
            height: 42,
            width: 42,
          ),
        )
      ],
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
          hintStyle: GoogleFonts.lato(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: const Color(0xffAFAFAF),
          ),
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff979797)))),
    );
  }

  Widget _bottomSheetWidget() {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          25.0, 25.0, 25.0, MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Add Task",
            style: GoogleFonts.lato(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white.withOpacity(0.87)),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            cursorColor: const Color(0xff979797),
            style: GoogleFonts.lato(
              fontWeight: FontWeight.w400,
              fontSize: 18,
              color: Colors.white.withOpacity(0.87),
            ),
            onChanged: (value) {
              title = value;
            },
            decoration: InputDecoration(
                hintText: "Title",
                hintStyle: GoogleFonts.lato(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: const Color(0xffafafaf),
                ),
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff979797))),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff979797))),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff979797)))),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            cursorColor: const Color(0xff979797),
            style: GoogleFonts.lato(
              fontWeight: FontWeight.w400,
              fontSize: 18,
              color: Colors.white.withOpacity(0.87),
            ),
            onChanged: (value) {
              description = value;
            },
            decoration: InputDecoration(
                hintText: "Description",
                hintStyle: GoogleFonts.lato(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: const Color(0xffafafaf),
                ),
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff979797))),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff979797))),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff979797)))),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () async {
                    date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2025));

                    TimeOfDay? time = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());
                    print(date);
                    print(time);
                    if (time != null) {
                      date = DateTime(date!.year, date!.month, date!.day,
                          time.hour, time.minute);
                    }
                  },
                  icon: Image.asset("assets/timer.png")),
              const SizedBox(
                width: 15,
              ),
              IconButton(onPressed: () {}, icon: Image.asset("assets/tag.png")),
              const SizedBox(
                width: 15,
              ),
              IconButton(
                  onPressed: () {}, icon: Image.asset("assets/flag.png")),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    print(title);
                    print(description);
                    print(date);
                    // true , true, false
                    if (title != null && description != null && date != null) {
                      setState(() {
                        controller.addTodo(
                            title!, description!, date!, context);
                      });
                    } else {
                      print("Date de bhai");
                    }
                  },
                  icon: Image.asset("assets/send.png")),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
