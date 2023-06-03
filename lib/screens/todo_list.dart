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
  List<Todo>? _searchedTodoList;
  String? title, description;
  DateTime? date;

  void _addTodo(String title, String description, DateTime date) {
    setState(() {
      _todoList
          .add(Todo(title: title, description: description, todoTime: date));
    });
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
  }

  void searchTodo(String searchKey) {
    if (searchKey.isEmpty) {
      setState(() {
        _searchedTodoList = null;
      });
    } else {
      List<Todo> results = _todoList
          .where((element) => element.title.contains(searchKey))
          .toList();

      setState(() {
        _searchedTodoList = results;
      });
    }
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
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(15))),
              backgroundColor: Color(0xff363636),
              builder: (context) {
                return _bottomSheetWidget();
              });
        },
        backgroundColor: Color(0xff8687E7),
        child: Icon(Icons.add),
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
                  Todo item = _searchedTodoList != null
                      ? _searchedTodoList![index]
                      : _todoList[index];
                  return _showTodoTile(item);
                }),
                itemCount: _searchedTodoList != null
                    ? _searchedTodoList!.length
                    : _todoList.length,
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
      onChanged: searchTodo,
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
                    print(date);
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
                      _addTodo(title!, description!, date!);
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
