import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: const Color(0xff8687E7),
            onPrimary: Colors.white,
            secondary: const Color(0xff363636),
            onSecondary: Colors.white,
            error: Colors.red,
            onError: Colors.white,
            background: Colors.black,
            onBackground: Colors.white,
            surface: Colors.black,
            onSurface: Colors.white,
          ),
          drawerTheme:
              DrawerThemeData(backgroundColor: const Color(0xff363636)),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: const Color(0xff8687E7)),
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.black,
              titleTextStyle: GoogleFonts.lato(
                fontWeight: FontWeight.w400,
                fontSize: 20,
              )),
          textTheme: TextTheme(
              bodyMedium: GoogleFonts.lato(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
              bodySmall: GoogleFonts.lato(
                  fontSize: 14,
                  color: const Color(0xffafafaf),
                  fontWeight: FontWeight.w400))),
      home: const HomeScreen(),
    );
  }
}
