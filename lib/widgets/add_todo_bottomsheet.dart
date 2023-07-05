import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../controller/todo_controller.dart';

class AddTodoBottomSheet extends StatefulWidget {
  const AddTodoBottomSheet({super.key, required this.controller});
  final TodoController controller;

  @override
  State<AddTodoBottomSheet> createState() => _AddTodoBottomSheetState();
}

class _AddTodoBottomSheetState extends State<AddTodoBottomSheet> {
  String? title, description;
  DateTime? date;
  File? todoImage;

  @override
  Widget build(BuildContext context) {
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
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(15))),
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  builder: (context) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          onTap: () async {
                            final ImagePicker picker = ImagePicker();
                            XFile? image = await picker.pickImage(
                                source: ImageSource.camera);
                            print(image?.name);
                            print(image?.path);
                            if (image != null) {
                              setState(() {
                                todoImage = File(image!.path);
                              });
                            }
                            Navigator.pop(context);
                          },
                          textColor: Theme.of(context).colorScheme.onPrimary,
                          iconColor: Theme.of(context).colorScheme.onPrimary,
                          leading: Icon(Icons.camera),
                          title: Text("Pick from Camera"),
                        ),
                        ListTile(
                          onTap: () async {
                            final ImagePicker picker = ImagePicker();
                            XFile? image = await picker.pickImage(
                                source: ImageSource.gallery);
                            print(image?.name);
                            print(image?.path);
                            if (image != null) {
                              setState(() {
                                todoImage = File(image!.path);
                              });
                            }
                            Navigator.pop(context);
                          },
                          textColor: Theme.of(context).colorScheme.onPrimary,
                          iconColor: Theme.of(context).colorScheme.onPrimary,
                          leading: Icon(Icons.photo),
                          title: Text("Pick from Gallery"),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    );
                  });
            },
            child: CircleAvatar(
              child: Icon(Icons.add_a_photo),
              radius: 35,
              foregroundImage: todoImage == null ? null : FileImage(todoImage!),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
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
                    if (title != null && description != null && date != null) {
                      setState(() {
                        widget.controller.addTodo(
                            title!, description!, date!, context,
                            image: todoImage);
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
