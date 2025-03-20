import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Center(
        child: SwitchListTile(
          title: const Text("Dark Mode"),
          value: Provider.of<ThemeProvider>(context).currentTheme.brightness ==
              Brightness.dark,
          onChanged: (value) =>
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
        ),
      ),
    );
  }
}