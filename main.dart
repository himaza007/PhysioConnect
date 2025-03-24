import 'package:flutter/material.dart';
import 'nearby_facilities.dart';
import 'custom_exercise_plans.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Physio Educational Resources',
      theme: ThemeData(
        primaryColor: const Color(0xFF33724B), // Midnight Teal
        scaffoldBackgroundColor: const Color(0xFFEAF7FF), // Alice Blue
      ),
      home: const CustomExercisePlansScreen(), // Automatically loads this page
    );
  }
}
