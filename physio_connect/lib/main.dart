import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/theme_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'login_page.dart';
import 'signup_page.dart';
import 'video_consultation_screen.dart';
import 'booking_screen.dart';
import 'rehabilitation_exercises.dart';
import 'rehabilitation_workouts.dart';
import 'support_chat_screen.dart';
import 'educational_resources.dart';
import 'customized_injury_remedies.dart';
import 'interactive_human_body.dart';
import 'muscle_selection_page.dart';
import 'emergency_session_screen.dart';
import 'nearby_facilities.dart';
import 'messaging_screen.dart';
import 'sos_button.dart';
import 'custom_exercise_plans.dart';
import 'strength_training.dart';
import 'flexibility_mobility.dart';
import 'balance_stability.dart';
import 'cardio_recovery.dart';
import 'preventing_common_sports_injuries.dart';
import 'effective_stretching_techniques.dart';
import 'understanding_muscle_strains.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const PhysioConnectApp(),
    ),
  );
}

class PhysioConnectApp extends StatelessWidget {
  const PhysioConnectApp({super.key});

  static const String splash = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String videoConsult = '/video-consult';
  static const String booking = '/booking';
  static const String rehabExercises = '/rehab-exercises';
  static const String rehabWorkouts = '/rehab-workouts';
  static const String supportChat = '/support-chat';
  static const String education = '/education';
  static const String remedies = '/remedies';
  static const String humanBody = '/human-body';
  static const String muscleSelect = '/muscle-select';
  static const String emergency = '/emergency';
  static const String nearby = '/nearby';
  static const String messaging = '/messaging';
  static const String sos = '/sos';
  static const String customPlans = '/custom-plans';
  static const String strength = '/strength';
  static const String flexibility = '/flexibility';
  static const String balance = '/balance';
  static const String cardio = '/cardio';
  static const String preventInjuries = '/prevent-injuries';
  static const String stretching = '/stretching';
  static const String strainInfo = '/strain-info';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PhysioConnect',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).currentTheme,
      initialRoute: splash,
      routes: {
        splash: (context) => const SplashScreen(),
        home: (context) => HomeScreen(),
        login: (context) => LoginPage(),
        signup: (context) => SignupPage(),
        videoConsult: (context) => VideoConsultationScreen(),
        booking: (context) => BookingScreen(therapistName: 'Dr. Jane Doe', therapistSpecialty: '',),
        rehabExercises: (context) => RehabilitationExercisesScreen(),
        rehabWorkouts: (context) => RehabilitationWorkoutsScreen(),
        supportChat: (context) => SupportChatScreen(),
        education: (context) => EducationalResourcesScreen(),
        remedies: (context) => CustomizedInjuryRemediesScreen(),
        humanBody: (context) => InteractiveHumanBody(toggleTheme: () {}, isDarkMode: false,),
        muscleSelect: (context) => MuscleSelectionPage(
        muscles: [], 
        onSelectionComplete: (List<String> selectedMuscles) {},
        isDarkMode: false, 
        bodyPart: '',
      ),
        emergency: (context) => EmergencySessionScreen(),
        nearby: (context) => NearbyFacilitiesScreen(),
        messaging: (context) => MessagingScreen(),
        sos: (context) => SOSFloatingButton(contacts: [],),
        customPlans: (context) => CustomExercisePlansScreen(),
        strength: (context) => StrengthTrainingScreen(),
        flexibility: (context) => FlexibilityMobilityScreen(),
        balance: (context) => BalanceStabilityScreen(),
        cardio: (context) => CardioRecoveryScreen(),
        preventInjuries: (context) => PreventingCommonSportsInjuriesScreen(),
        stretching: (context) => EffectiveStretchingTechniquesScreen(),
        strainInfo: (context) => UnderstandingMuscleStrainsScreen(),
      },
    );
  }
}
