import 'package:flutter/material.dart';
import 'home_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.green.shade700,
      ),
      body: Center(
        child: Text(
          'Welcome to Home Screen',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
