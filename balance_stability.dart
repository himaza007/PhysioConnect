import 'package:flutter/material.dart';

class FlexibilityMobilityScreen extends StatelessWidget {
  const FlexibilityMobilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF33724B), // Midnight Teal
        title: const Text("Flexibility & Mobility"),
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
                "Flexibility & Mobility",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF33724B),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Perform these gentle stretches and mobility drills to improve range of motion, reduce stiffness, and prevent injuries. Hold stretches without bouncing and maintain controlled breathing.",
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 20),
              _buildExerciseStep(
                "🧘‍♂️ Forward Fold Stretch",
                "Lengthens hamstrings and lower back muscles.",
                "1️⃣ Stand with feet hip-width apart.\n"
                    "2️⃣ Hinge at the hips and slowly fold forward, reaching for your toes.\n"
                    "3️⃣ Let your upper body relax and hold for **20-30 seconds**.\n"
                    "4️⃣ Slowly rise back up.\n"
                    "🔁 Repeat **3 times**.",
              ),
              _buildExerciseStep(
                "🦶 Ankle Mobility Circles",
                "Enhances ankle joint flexibility.",
                "1️⃣ Sit or stand with one foot slightly raised.\n"
                    "2️⃣ Rotate your ankle in **small circles** clockwise for **10 reps**.\n"
                    "3️⃣ Switch directions and repeat.\n"
                    "4️⃣ Perform on both ankles.\n"
                    "🔁 Complete **2-3 sets per side**.",
              ),
              _buildExerciseStep(
                "🙆‍♂️ Shoulder Openers",
                "Loosens up tight shoulder muscles.",
                "1️⃣ Stand tall and clasp your hands behind your back.\n"
                    "2️⃣ Straighten your arms and gently lift them upwards.\n"
                    "3️⃣ Hold for **15-20 seconds**, then relax.\n"
                    "🔁 Repeat **3 times**.",
              ),
              _buildExerciseStep(
                "🦵 Seated Hamstring Stretch",
                "Increases flexibility in the back of the thighs.",
                "1️⃣ Sit on the floor with one leg extended and the other foot placed against the inner thigh.\n"
                    "2️⃣ Reach forward toward the extended foot, keeping your back straight.\n"
                    "3️⃣ Hold for **20-30 seconds**, then switch legs.\n"
                    "🔁 Repeat **2-3 times per leg**.",
              ),
              _buildExerciseStep(
                "🏃‍♂️ Hip Flexor Stretch",
                "Improves hip mobility and reduces tightness.",
                "1️⃣ Kneel on one knee with the opposite foot in front at **90 degrees**.\n"
                    "2️⃣ Shift your weight forward to stretch the hip flexor of the kneeling leg.\n"
                    "3️⃣ Hold for **20-30 seconds**, then switch sides.\n"
                    "🔁 Repeat **2-3 times per side**.",
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
