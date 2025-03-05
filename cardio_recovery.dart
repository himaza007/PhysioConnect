import 'package:flutter/material.dart';

class CardioRecoveryScreen extends StatelessWidget {
  const CardioRecoveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF33724B), // Midnight Teal
        title: const Text("Cardio for Safe Recovery"),
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
                "Cardio for Safe Recovery",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF33724B)),
              ),
              const SizedBox(height: 10),
              const Text(
                "Perform these **low-impact cardiovascular exercises** to improve **endurance, circulation, and overall heart health** without stressing your joints.",
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 20),
              _buildExerciseStep(
                  "🚶 Brisk Walking",
                  "Walk at a moderate pace for **15-30 minutes** to improve cardiovascular health.",
                  "1️⃣ Choose a **flat, safe path** for your walk.\n"
                      "2️⃣ Maintain an **upright posture** and engage your core.\n"
                      "3️⃣ Swing your arms naturally to assist movement.\n"
                      "4️⃣ Start at a **comfortable pace**, then gradually increase speed.\n"
                      "🔁 Perform **daily or 4-5 times per week**."),
              _buildExerciseStep(
                  "🚴 Stationary Cycling",
                  "Pedal at a **low resistance** for **10-20 minutes** to increase endurance.",
                  "1️⃣ Adjust the **seat height** so your knees are slightly bent at full extension.\n"
                      "2️⃣ Start pedaling at a **slow, comfortable pace**.\n"
                      "3️⃣ Maintain a **steady breathing rhythm**.\n"
                      "4️⃣ Gradually **increase resistance** as tolerated.\n"
                      "🔁 Perform **3-4 times per week**."),
              _buildExerciseStep(
                  "🏊 Pool Walking",
                  "Water-based walking **reduces joint impact** and builds strength.",
                  "1️⃣ Walk **forward and backward** in waist-deep water.\n"
                      "2️⃣ Keep a **straight posture** and engage your core.\n"
                      "3️⃣ Move at a **moderate pace** for **15-25 minutes**.\n"
                      "🔁 Perform **3-5 times per week**."),
              _buildExerciseStep(
                  "🧘 Deep Breathing Exercises",
                  "Enhances **lung capacity and relaxation**.",
                  "1️⃣ Sit comfortably and **close your eyes**.\n"
                      "2️⃣ Inhale deeply through your **nose** for **4 seconds**.\n"
                      "3️⃣ Hold the breath for **3 seconds**.\n"
                      "4️⃣ Exhale slowly through your **mouth** for **6 seconds**.\n"
                      "🔁 Repeat **8-10 times**."),
              _buildExerciseStep(
                  "🚶‍♂️ Treadmill Incline Walk",
                  "Use a **slight incline** for low-impact endurance training.",
                  "1️⃣ Set the **incline to 3-5%**.\n"
                      "2️⃣ Walk at a **slow pace** (2.5-3.5 mph).\n"
                      "3️⃣ Keep your posture **straight and relaxed**.\n"
                      "4️⃣ Walk for **15-20 minutes**, then gradually reduce speed.\n"
                      "🔁 Perform **3-4 times per week**."),
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
