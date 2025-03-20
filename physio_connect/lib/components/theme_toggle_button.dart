import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/theme_provider.dart'; 

class ThemeToggleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.teal,
      child: Icon(Icons.brightness_6, color: Colors.white),
      onPressed: () {
        Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
      },
    );
  }
}
