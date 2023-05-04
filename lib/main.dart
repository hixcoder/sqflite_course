import 'package:flutter/material.dart';
import 'package:sqflite_course/home_page.dart';
import 'package:sqflite_course/add_note_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
      routes: {
        "addnotes": (context) => AddNotesPage(),
      },
    );
  }
}
