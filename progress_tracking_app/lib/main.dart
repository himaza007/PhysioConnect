import 'package:flutter/material.dart';
import 'screens/progress_tracking_screen.dart';

void main() {
  runApp(const ProgressTrackingApp());
}

class ProgressTrackingApp extends StatelessWidget {
  const ProgressTrackingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF33724B),
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const ProgressTrackingScreen(),
    );
  }
}
