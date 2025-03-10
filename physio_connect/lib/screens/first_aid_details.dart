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
   @override
  Widget build(BuildContext context) {
    final List<String> steps =
        firstAidSteps[title] ?? ["⚠ No instructions available."];

    return Scaffold(
      backgroundColor: Colors.white, // ✅ Clean White Background
      body: SafeArea(
        child: Column(
          children: [
            // ✅ Custom AppBar with Animated Back Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(2, 3),
                          ),
                        ],
                      ),
                      child: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal.shade800,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            // ✅ Interactive Step-by-Step Guide
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(2, -2),
                    ),
                  ],
                ),
                child: ListView(
                  children: [
                    // 📜 Title
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Step-by-Step Guide",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal.shade800,
                        ),
                      ),
                    ),

                    // 📋 Steps List with Animated Cards
                    ...steps.map((step) => _buildStepCard(step)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ Reusable Step Card with Hover Effect
  Widget _buildStepCard(String step) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.teal.shade50,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(2, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 24),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                step,
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


