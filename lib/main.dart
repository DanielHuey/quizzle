import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(const QuizziApp());
}

class QuizziApp extends StatelessWidget {
  const QuizziApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
        fontFamily: "Indie",
      ),
      home: const HomePage(),
    );
  }
}
