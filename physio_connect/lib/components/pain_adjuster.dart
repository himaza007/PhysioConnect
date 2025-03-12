import 'package:flutter/material.dart';

class PainAdjuster extends StatelessWidget {
  final double painLevel;
  final Function(double) onPainLevelChanged;

  const PainAdjuster(
      {Key? key, required this.painLevel, required this.onPainLevelChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Adjust Pain Level",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(height: 15),
        Slider(
          value: painLevel,
          min: 1,
          max: 10,
          divisions: 9,
          activeColor: Colors.teal,
          onChanged: onPainLevelChanged,
        ),
      ],
    );
  }
}





