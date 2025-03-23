import 'package:flutter/material.dart';
import 'interactive_human_body.dart';
import 'theme_provider.dart';

void main() {
  runApp(const PhysioConnectApp());
}

class PhysioConnectApp extends StatefulWidget {
  const PhysioConnectApp({super.key});

  @override
  State<PhysioConnectApp> createState() => _PhysioConnectAppState();
}

class _PhysioConnectAppState extends State<PhysioConnectApp> {
  bool isDarkMode = true;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
      home: InteractiveHumanBody(
        toggleTheme: toggleTheme,
        isDarkMode: isDarkMode,
      ),
    );
  }
}
