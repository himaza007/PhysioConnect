import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(const PhysioConnectApp());
}

class PhysioConnectApp extends StatelessWidget {
  const PhysioConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFF33724B),
      ),
      home: const HomePage(),
    );
  }
}
