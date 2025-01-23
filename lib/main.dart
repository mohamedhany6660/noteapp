import 'package:flutter/material.dart';
import 'package:sql_first/home.dart';
import 'package:sql_first/note%20App/note1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
   
      home: noteapp(),
    );
  }
}
