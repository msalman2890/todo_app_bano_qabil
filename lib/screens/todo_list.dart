import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/models/todo_model.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Todo> _todoList = [];

  void _addTodo() {
    setState(() {
      _todoList = [
        Todo(
            title: "Do maths homework",
            description: "krle bhai",
            todoTime: DateTime(2023, 05, 24, 10, 30)),
        Todo(
            title: "Do physics homework",
            description: "krle bhai",
            todoTime: DateTime(2023, 05, 24, 10, 30))
      ];
    });
  }

  @override
  void initState() {
    _addTodo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _showAppBar(),
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
                  return _showTodoTile(_todoList[index]);
                }),
                itemCount: _todoList.length,
              ),
            )
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

  Container _showTodoTile(Todo todo) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
          color: const Color(0xff363636),
          borderRadius: BorderRadius.circular(4)),
      child: Row(
        children: [
          const Icon(
            Icons.circle_outlined,
            size: 16,
            color: Colors.white,
          ),
          const SizedBox(
            width: 12,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${todo.title}",
                style: GoogleFonts.lato(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                "${todo.todoTime}",
                style: GoogleFonts.lato(
                    fontSize: 14,
                    color: const Color(0xffafafaf),
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
