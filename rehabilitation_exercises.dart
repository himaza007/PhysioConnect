import 'package:flutter/material.dart';

class RehabilitationExercisesScreen extends StatelessWidget {
  const RehabilitationExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Allows transparency effect
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65), // Adjusted AppBar height
        child: AppBar(
          backgroundColor: Colors.transparent, // Fully transparent AppBar
          elevation: 0, // Removes shadow
          centerTitle: true,
          title: const Text(
            "Rehabilitation Exercises",
            style: TextStyle(
              fontSize: 20, // Adjusted font size
              fontWeight: FontWeight.bold,
              color: Color(0xFF33724B), // Green text (Midnight Teal)
            ),
          ),
          iconTheme: const IconThemeData(
              color: Color(0xFF33724B)), // Green back button
        ),
      ),
      body: Stack(
        children: [
          // Background Gradient (optional for better readability)
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withOpacity(0.1), // Light Transparent White
                  Colors.white.withOpacity(0.05), // Fading White
                ],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Rehabilitation Exercises",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF33724B), // Midnight Teal
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Rehabilitation exercises are essential for recovering from injuries, restoring mobility, and strengthening weakened muscles. These exercises help prevent re-injury and improve overall functional movement. Below are some effective rehabilitation exercises you can incorporate into your recovery process.",
                    style: TextStyle(fontSize: 15, color: Colors.black87),
                  ),
                  const SizedBox(height: 15),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        _buildRehabExerciseCard(
                          title: "Range of Motion Exercises",
                          description:
                              "Gentle movements that improve joint flexibility and mobility after an injury.",
                          icon: Icons.open_in_full,
                        ),
                        _buildRehabExerciseCard(
                          title: "Strengthening Exercises",
                          description:
                              "Focused movements to rebuild muscle strength in the affected area.",
                          icon: Icons.fitness_center,
                        ),
                        _buildRehabExerciseCard(
                          title: "Balance & Coordination Drills",
                          description:
                              "Exercises that help restore stability and prevent future injuries.",
                          icon: Icons.accessibility_new,
                        ),
                        _buildRehabExerciseCard(
                          title: "Stretching & Flexibility Exercises",
                          description:
                              "Improves muscle elasticity and reduces tightness post-injury.",
                          icon: Icons.directions_run,
                        ),
                        _buildRehabExerciseCard(
                          title: "Low-Impact Cardiovascular Training",
                          description:
                              "Activities like cycling or swimming to maintain fitness without stressing injuries.",
                          icon: Icons.pedal_bike,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRehabExerciseCard({
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Card(
      color: Colors.white.withOpacity(0.9), // Slight transparency for cards
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 2, // Lowered elevation for a smoother look
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF33724B)), // Green icon
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        subtitle: Text(description, style: const TextStyle(fontSize: 13)),
        // Removed the trailing `>` icon here
      ),
    );
  }
}
