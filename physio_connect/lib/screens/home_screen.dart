import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../components/animated_button.dart';
import '../components/wave_background.dart';
import '../components/glowing_effect.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // ✅ Smooth Fade Animation for Entry
    _fadeController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
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
      body: Stack(
        fit: StackFit.expand, // ✅ Ensures no blank spaces
        alignment: Alignment.center,
        children: [
          // ✅ Animated Wave Background (from wave_background.dart)
          Positioned.fill(child: WaveBackground()),

          // ✅ App Logo Positioned at the Top with a Professional Look
          Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(2, 3),
                    ),
                  ],
                ),
                child: Image.asset(
                  "lib/assets/images/app_logo.png",
                  height: 30, // ✅ Adjusted Size for Professional Look
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // ✅ Subtle Glowing Effect Centered to Physio Animation
          Positioned(
            top: MediaQuery.of(context).size.height * 0.22, // Centered Effect
            left: MediaQuery.of(context).size.width / 2 - 100,
            child: SizedBox(
              width: 200,
              height: 200,
              child: GlowingEffect(),
            ),
          ),

          // ✅ Main UI with Smooth Entry Animation
          SafeArea(
            child: Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ✅ Enlarged & Centered Animated Header with Glow
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        // 🎥 **Enlarged Lottie Animation (Transparent Background)**
                        Lottie.asset(
                          "lib/assets/animations/physio_animation.json",
                          height: 250, // ✅ Adjusted to fit screen properly
                          fit: BoxFit.cover,
                          frameRate: FrameRate.max,
                        ),
                      ],
                    ),

                    SizedBox(height: 25),

                    // ✅ Elegant Title with Subtle Glow
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [Colors.white, Colors.teal.shade100],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds),
                      child: Text(
                        "Welcome to PhysioConnect",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
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

                    SizedBox(height: 40),

                    // ✅ Interactive Animated Buttons
                    AnimatedButton(
                      label: "Pain Monitoring",
                      icon: Icons.favorite,
                      color: Colors.redAccent,
                      textColor: Colors.white,
                      route: "/pain-monitoring",
                    ),

                    SizedBox(height: 20),

                    AnimatedButton(
                      label: "First Aid Tutorials",
                      icon: Icons.local_hospital,
                      color: Colors.blueAccent,
                      textColor: Colors.white,
                      route: "/first-aid-tutorials",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
