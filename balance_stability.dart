import 'package:flutter/material.dart';

class BalanceStabilityScreen extends StatelessWidget {
  const BalanceStabilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF33724B), // Midnight Teal
        title: const Text("Balance & Stability Training"),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        // Prevents overflow issues
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Balance & Stability Training",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF33724B)),
              ),
              const SizedBox(height: 10),
              const Text(
                "Develop better **balance, coordination, and core strength** with these exercises. These drills help **prevent falls, improve posture, and support injury recovery**.",
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 20),
              _buildExerciseStep(
                  "🦵 Single-Leg Stands",
                  "Improves balance and lower-body strength.",
                  "1️⃣ Stand tall and lift one foot slightly off the ground.\n"
                      "2️⃣ Keep your knee slightly bent and hold the position for **10-20 seconds**.\n"
                      "3️⃣ Switch legs and repeat.\n"
                      "4️⃣ For more challenge, close your eyes or stand on a soft surface.\n"
                      "🔁 Perform **3 sets per leg**."),
              _buildExerciseStep(
                  "🤸‍♂️ Stability Ball Rollouts",
                  "Engages core muscles for better control.",
                  "1️⃣ Kneel on the floor with a **stability ball** in front of you.\n"
                      "2️⃣ Place your hands on the ball and slowly roll it forward, extending your arms.\n"
                      "3️⃣ Keep your core tight and avoid arching your back.\n"
                      "4️⃣ Roll back to the start position with control.\n"
                      "🔁 Perform **8-10 reps for 2-3 sets**."),
              _buildExerciseStep(
                  "🚶‍♂️ Heel-to-Toe Walk",
                  "Enhances overall stability and posture.",
                  "1️⃣ Stand tall and place one foot directly in front of the other so that the heel touches the toes.\n"
                      "2️⃣ Walk in a straight line for **10-15 steps**, keeping your balance.\n"
                      "3️⃣ Focus on slow, controlled steps.\n"
                      "🔁 Repeat **2-3 times**."),
              _buildExerciseStep(
                  "🧘‍♂️ Bosu Ball Squats",
                  "Enhances leg strength and stability.",
                  "1️⃣ Stand on a **Bosu ball** with feet shoulder-width apart.\n"
                      "2️⃣ Lower into a squat while keeping your balance.\n"
                      "3️⃣ Engage your core and slowly return to standing.\n"
                      "🔁 Perform **10-12 reps for 2-3 sets**."),
              _buildExerciseStep(
                  "🏋️‍♂️ Side-Lying Leg Raises",
                  "Strengthens hip stabilizers to prevent falls.",
                  "1️⃣ Lie on your side with legs stacked.\n"
                      "2️⃣ Lift your top leg slowly and hold for **2-3 seconds**.\n"
                      "3️⃣ Lower it back down with control.\n"
                      "🔁 Perform **12-15 reps per leg**."),
              const SizedBox(height: 20), // Prevents bottom cutoff
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExerciseStep(
      String title, String description, String instructions) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.check_circle,
                      color: Color(0xFF33724B)), // Green check icon
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(description,
                  style: const TextStyle(fontSize: 14, color: Colors.black87)),
              const SizedBox(height: 5),
              Text(instructions,
                  style: const TextStyle(fontSize: 13, color: Colors.black54)),
            ],
          ),
        ),
      ),
    );
  }
}
