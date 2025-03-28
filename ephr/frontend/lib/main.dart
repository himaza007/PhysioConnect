// frontend/lib/main.dart

import 'package:flutter/material.dart';
import 'app.dart';

void main() {
  // Initialize any required services
  WidgetsFlutterBinding.ensureInitialized();

  // Run the app
  runApp(const PhysioConnectApp());
}
