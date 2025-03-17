import 'package:flutter/material.dart';

class PopUpPainAdvice extends StatelessWidget {
  final double painLevel;

  PopUpPainAdvice({Key? key, required this.painLevel}) : super(key: key);

  final Map<int, String> _painDescriptions = {
    1: "Minimal discomfort, just relax! 💆‍♂️",
    3: "Try gentle stretching & hydration. 💧",
    5: "Apply an ice pack and move lightly. ❄️",
    7: "Use heat therapy & consider physiotherapy. 🔥",
    9: "Seek medical advice for persistent pain. 🏥",
    10: "Severe pain detected! Consult a doctor immediately. 🚨",
  };

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: 1.0,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.teal.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
                color: Colors.black26, blurRadius: 10, offset: Offset(2, 4))
          ],
        ),
        child: Text(
          _painDescriptions.entries
              .firstWhere((entry) => painLevel <= entry.key,
                  orElse: () =>
                      const MapEntry(10, "Consult a doctor immediately. 🚨"))
              .value,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ),
    );
  }
}
