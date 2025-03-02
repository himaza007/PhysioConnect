import 'package:flutter/material.dart';
import 'gender_selection_screen.dart';

void main() {
  runApp(const PhysioConnectApp());
}

class PhysioConnectApp extends StatelessWidget {
  const PhysioConnectApp({super.key});
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'PhysioConnect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Color(0xFF33724B), scaffoldBackgroundColor: Color(0xFFEAF7FF)),
      home: GenderSelectionScreen(),
    );
  }
}