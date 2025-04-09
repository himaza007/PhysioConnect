import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// Import configuration
import 'config/theme.dart';
import 'config/routes.dart';
import 'config/constants.dart';

// Import services
import 'services/auth_service.dart';
import 'services/ephr_service.dart';
import 'services/storage_service.dart';
import 'services/notification_service.dart';

/// Main entry point for the PhysioConnect EPHR application
/// Sets up providers, theme, and initial routing

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize services
  final authService = AuthService();
  final ephrService = EPHRService();
  final storageService = StorageService();
  final notificationService = NotificationService();

  // Initialize services that require async initialization
  await notificationService.init();
  await storageService.init();

  runApp(
    MyApp(
      authService: authService,
      ephrService: ephrService,
      storageService: storageService,
      notificationService: notificationService,
    ),
  );
}

class MyApp extends StatelessWidget {
  final AuthService authService;
  final EPHRService ephrService;
  final StorageService storageService;
  final NotificationService notificationService;

  const MyApp({
    Key? key,
    required this.authService,
    required this.ephrService,
    required this.storageService,
    required this.notificationService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Register services as providers
        Provider<AuthService>.value(value: authService),
        Provider<EPHRService>.value(value: ephrService),
        Provider<StorageService>.value(value: storageService),
        Provider<NotificationService>.value(value: notificationService),

        // Add additional providers for state management
        // This could be ChangeNotifier or other state management providers
        ChangeNotifierProvider(create: (_) => authService.userState),
      ],
      child: MaterialApp(
        title: AppConstants.appName,
        theme: AppTheme.lightTheme(),
        initialRoute: AppRoutes.initialRoute,
        onGenerateRoute: AppRoutes.generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
