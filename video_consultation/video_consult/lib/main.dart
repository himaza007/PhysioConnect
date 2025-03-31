import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(PhysioApp());
}

class PhysioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Physio Connect',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomeScreen(),
    );
  }
}
