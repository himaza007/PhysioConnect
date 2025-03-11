import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GlowingEffect extends StatelessWidget {
  const GlowingEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      "lib/assets/animations/glowing_effect.json",
      width: 200, // ✅ Matches the Physio Animation for proper centering
      height: 200,
      repeat: true,
      fit: BoxFit.cover,
    );
  }
}
