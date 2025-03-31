// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../components/animated_button.dart';
import '../components/wave_background.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // ✅ Smooth Fade Animation for Entry
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..forward();

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9FA), // ✅ Light Modern Background
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ✅ Animated Wave Background
          Positioned.fill(child: WaveBackground()),

          // ✅ Centered Main UI with Smooth Entry Animation
          SafeArea(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 🎥 **Lottie Animation (Smaller & Balanced)**
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.teal.shade300.withOpacity(0.4),
                          blurRadius: 18,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Lottie.asset(
                      "lib/assets/animations/physio_animation.json",
                      height: 200, // ✅ Adjusted Size for Balance
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // ✅ Elegant Title with Glow Effect
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [Colors.teal.shade700, Colors.black87],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: const Text(
                      "Welcome to PhysioConnect",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                        shadows: [
                          Shadow(
                            color: Colors.black26,
                            blurRadius: 5,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // ✅ Interactive Buttons with Subtle Hover Effect
                  AnimatedButton(
                    label: "Pain Monitoring",
                    icon: Icons.monitor_heart_rounded,
                    color: Colors.redAccent,
                    textColor: Colors.white,
                    route: "/pain-monitoring",
                  ),

                  const SizedBox(height: 20),

                  AnimatedButton(
                    label: "First Aid Tutorials",
                    icon: Icons.local_hospital_rounded,
                    color: Colors.blueAccent,
                    textColor: Colors.white,
                    route: "/first-aid-tutorials",
                  ),
                ],
              ),
            ),
          ),

          // ✅ App Logo Positioned at the Top for Branding
          Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: const Offset(2, 3),
                    ),
                  ],
                ),
                child: Image.asset(
                  "lib/assets/images/app_logo.png",
                  height: 32, // ✅ Slightly Bigger for Professional Look
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
