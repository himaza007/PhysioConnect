import 'package:flutter/material.dart';

class StrengthTrainingScreen extends StatelessWidget {
  const StrengthTrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF33724B), // Midnight Teal
        title: const Text("Strength Training for Recovery"),
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
                "Strength Training for Recovery",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF33724B),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Focus on controlled resistance training, bodyweight exercises, and core activation to safely rebuild strength after an injury. Perform each movement with proper form and avoid excessive strain.",
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 20),
              _buildExerciseStep(
                "🏋️‍♂️ Resistance Band Pulls",
                "Enhances muscle strength with controlled resistance.",
                "1️⃣ Anchor a resistance band at chest height.\n"
                    "2️⃣ Hold the band with both hands and step back slightly.\n"
                    "3️⃣ Keep your elbows close to your body and pull the band towards your chest.\n"
                    "4️⃣ Slowly return to the start position.\n"
                    "🔁 Repeat **10-15 times** for **2-3 sets**.",
              ),
              _buildExerciseStep(
                "🦵 Step-ups",
                "Improves lower limb coordination and power.",
                "1️⃣ Stand in front of a **low step or sturdy box**.\n"
                    "2️⃣ Step onto the platform with one foot and push through your heel.\n"
                    "3️⃣ Bring the other foot up and then slowly lower back down.\n"
                    "4️⃣ Switch legs and repeat.\n"
                    "🔁 Perform **10 reps per leg** for **2-3 sets**.",
              ),
              _buildExerciseStep(
                "🤲 Grip Strengthening",
                "Strengthens forearm and wrist muscles.",
                "1️⃣ Hold a **stress ball or hand gripper** in your palm.\n"
                    "2️⃣ Squeeze the ball firmly and hold for **5 seconds**.\n"
                    "3️⃣ Release slowly and repeat.\n"
                    "🔁 Perform **12-15 squeezes per hand**.",
              ),
              _buildExerciseStep(
                "🧍‍♂️ Wall Sit",
                "Builds endurance in the legs and core.",
                "1️⃣ Stand with your back against a **wall** and feet **shoulder-width apart**.\n"
                    "2️⃣ Slide down into a seated position, keeping your knees at **90 degrees**.\n"
                    "3️⃣ Hold for **20-40 seconds**, keeping your core engaged.\n"
                    "🔁 Repeat **3 times**.",
              ),
              _buildExerciseStep(
                "💪 Seated Leg Extensions",
                "Strengthens quadriceps while protecting the knee.",
                "1️⃣ Sit on a sturdy chair with feet flat on the floor.\n"
                    "2️⃣ Slowly extend one leg straight and hold for **3-5 seconds**.\n"
                    "3️⃣ Lower it back down and switch legs.\n"
                    "🔁 Perform **12 reps per leg** for **2-3 sets**.",
              ),
              const SizedBox(height: 20), // Prevents bottom cutoff
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExerciseStep(
    String title,
    String description,
    String instructions,
  ) {
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
                  const Icon(
                    Icons.check_circle,
                    color: Color(0xFF33724B),
                  ), // Green check icon
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                description,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(height: 5),
              Text(
                instructions,
                style: const TextStyle(fontSize: 13, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
