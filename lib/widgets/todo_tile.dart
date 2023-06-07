import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/todo_model.dart';

class TodoTile extends StatefulWidget {
  TodoTile({required this.todo});

  Todo todo;

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
          color: const Color(0xff363636),
          borderRadius: BorderRadius.circular(4)),
      child: Row(
        children: [
          Checkbox(
              value: widget.todo.isCompleted,
              onChanged: (bool? value) {
                print(value);
                setState(() {
                  widget.todo.isCompleted = value!;
                });
              }),
          const SizedBox(
            width: 12,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${widget.todo.title}",
                style: GoogleFonts.lato(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                "${DateFormat("EEEE, MMM d, yyyy -  hh:mm a").format(widget.todo.todoTime)}",
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
