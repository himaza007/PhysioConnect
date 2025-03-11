import 'package:flutter/material.dart';

class PopUpPainAdvice extends StatelessWidget {
  final int painLevel;

  // ✅ Pain Advice Messages
  final Map<int, String> _painAdvice = {
    1: "Minimal discomfort, just relax! 💆‍♂️",
    3: "Try gentle stretching & hydration. 💧",
    5: "Apply an ice pack and move lightly. ❄️",
    7: "Use heat therapy & consider physiotherapy. 🔥",
    9: "Seek medical advice for persistent pain. 🏥",
    10: "Severe pain detected! Consult a doctor immediately. 🚨",
  };

  PopUpPainAdvice({Key? key, required this.painLevel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.teal),
          SizedBox(width: 10),
          Text(
            'Pain Advice',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
      content: Text(
        _painAdvice.entries
            .firstWhere((entry) => painLevel <= entry.key,
                orElse: () => MapEntry(10, "Consult a doctor immediately. 🚨"))
            .value,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'OK',
            style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
