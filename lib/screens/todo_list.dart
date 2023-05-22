import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            TextField(
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
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: ((context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    height: 100,
                    width: double.infinity,
                    color: Colors.red,
                    child: Center(
                      child: Text(
                        "$index",
                        style:
                            const TextStyle(fontSize: 48, color: Colors.white),
                      ),
                    ),
                  );
                }),
                itemCount: 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}
