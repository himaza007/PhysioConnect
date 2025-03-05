import 'package:flutter/material.dart';
import 'customized_injury_remedies.dart'; // Import the new screen

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
      home:
          const CustomizedInjuryRemediesScreen(), // Automatically loads this page
    );
  }
}
