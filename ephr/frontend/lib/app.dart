// File: frontend/lib/app.dart

import 'package:flutter/material.dart';
import 'config/theme.dart';
import 'config/routes.dart';

class PhysioConnectApp extends StatelessWidget {
  const PhysioConnectApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PhysioConnect EHPR',
      theme: AppTheme.lightTheme, // Custom theme defined in theme.dart
      initialRoute: AppRoutes.initial, // Define initial route from routes.dart
      routes: AppRoutes.routes,
      debugShowCheckedModeBanner: false, // Remove debug banner
    );
  }
}
