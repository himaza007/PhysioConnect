import 'package:flutter/material.dart';

class FirstAidDetailsScreen extends StatelessWidget {
  final String title;
  const FirstAidDetailsScreen({Key? key, required this.title})
      : super(key: key);

  // ✅ First Aid Steps
  static final Map<String, List<String>> firstAidSteps = {
    "CPR - How to Perform Chest Compressions": [
      "✔ Check if the person is responsive.",
      "✔ Call emergency services immediately.",
      "✔ Place both hands in the center of the chest.",
      "✔ Push hard & fast (100-120 compressions per minute).",
      "✔ Continue until professional help arrives."
    ],
    "How to Stop Severe Bleeding": [
      "✔ Apply direct pressure with a **clean cloth**.",
      "✔ If possible, elevate the injured area.",
      "✔ Maintain pressure for at least **5 minutes**.",
      "✔ Seek immediate **medical attention** if bleeding persists."
    ],
    "Choking First Aid - Heimlich Maneuver": [
      "✔ Stand behind the person & **wrap arms around their waist**.",
      "✔ Make a **fist** and place it above the belly button.",
      "✔ Perform **quick** abdominal thrusts.",
      "✔ Continue until the object is **expelled**."
    ],
  };
