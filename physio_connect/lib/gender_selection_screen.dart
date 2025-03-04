import 'package:flutter/material.dart';
import 'body_model_screen.dart'; 

class GenderSelectionScreen extends StatelessWidget {
  const GenderSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/bg.png", fit: BoxFit.cover),
          Container(color: Colors.black.withOpacity(0.4)), // Elegant dark overlay
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Select Your Profile",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 30),

              // Glass Effect Cards for Gender
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _genderCard(context, "Male", "assets/images/male.png"),
                  SizedBox(width: 20),
                  _genderCard(context, "Female", "assets/images/female.png"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _genderCard(BuildContext context, String gender, String imagePath) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 600),
            pageBuilder: (_, __, ___) => BodyModelScreen(gender: gender),
            transitionsBuilder: (_, anim, __, child) {
              return FadeTransition(opacity: anim, child: child);
            },
          ),
        );
      },
      child: Hero(
        tag: gender, // Unique tag per gender.
        child: Container(
          width: 140,
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(0.2),
            border: Border.all(color: Colors.white.withOpacity(0.5), width: 1.5),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10, spreadRadius: 3),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(imagePath, width: 80),
              const SizedBox(height: 10),
              Text(
                gender,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
