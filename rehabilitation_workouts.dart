import 'package:flutter/material.dart';

class RehabilitationWorkoutsScreen extends StatelessWidget {
  const RehabilitationWorkoutsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF33724B), // Midnight Teal
        title: const Text("Rehabilitation Workouts"),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        // Allows scrolling to prevent overflow
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Rehabilitation Workouts",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF33724B)),
              ),
              const SizedBox(height: 10),
              const Text(
                "Perform these exercises **slowly and with control** to promote healing, **restore mobility**, and **strengthen** weakened muscles without causing strain.",
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 20),
              _buildExerciseStep(
                  "🦵 Controlled Leg Raises",
                  "Improves lower limb strength without excessive strain.",
                  "1️⃣ Lie on your back with one knee bent and the other leg straight.\n"
                      "2️⃣ Tighten your thigh muscles and slowly lift the straight leg about 12 inches off the ground.\n"
                      "3️⃣ Hold for **3-5 seconds**, then slowly lower the leg back down.\n"
                      "🔁 Repeat **10-12 times** for each leg."),
              _buildExerciseStep(
                  "👐 Shoulder Pendulum Swings",
                  "Enhances shoulder mobility and reduces stiffness.",
                  "1️⃣ Stand with your good arm resting on a table for support.\n"
                      "2️⃣ Let the injured arm hang freely and gently swing it forward and backward.\n"
                      "3️⃣ Move it side to side and in small circles.\n"
                      "🔁 Perform **10 reps** in each direction."),
              _buildExerciseStep(
                  "🧍‍♂️ Gentle Core Activation",
                  "Strengthens deep core muscles to stabilize movement.",
                  "1️⃣ Lie on your back with knees bent and feet flat on the floor.\n"
                      "2️⃣ Tighten your stomach muscles as if preparing for impact.\n"
                      "3️⃣ Hold the tension for **5-10 seconds**, then relax.\n"
                      "🔁 Repeat **8-10 times**."),
              _buildExerciseStep(
                  "🦶 Ankle Alphabet",
                  "Improves ankle flexibility and mobility.",
                  "1️⃣ Sit comfortably and lift your injured foot off the ground.\n"
                      "2️⃣ Use your big toe to 'draw' each letter of the alphabet in the air.\n"
                      "3️⃣ Keep movements **small and controlled** to avoid pain.\n"
                      "🔁 Complete **one full alphabet set per session**."),
              _buildExerciseStep(
                  "🤲 Grip Strengthening",
                  "Helps restore hand and wrist function.",
                  "1️⃣ Hold a soft stress ball or rolled towel in your hand.\n"
                      "2️⃣ Squeeze gently and hold for **5 seconds**, then release slowly.\n"
                      "🔁 Repeat **12-15 times per hand**."),
              const SizedBox(
                  height: 20), // Extra space to prevent bottom cutoff
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
