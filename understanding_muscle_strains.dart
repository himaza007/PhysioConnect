import 'package:flutter/material.dart';

class UnderstandingMuscleStrainsScreen extends StatelessWidget {
  const UnderstandingMuscleStrainsScreen({super.key});

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
            "Understanding Muscle Strains",
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
                    "Understanding Muscle Strains",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF33724B), // Midnight Teal
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Muscle strains occur when muscle fibers are overstretched or torn due to excessive force. Strains can range from mild discomfort to severe tears that require medical intervention. Below are the types of muscle strains and how to treat them effectively.",
                    style: TextStyle(fontSize: 15, color: Colors.black87),
                  ),
                  const SizedBox(height: 15),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        _buildMuscleStrainCard(
                          title: "Grade 1 Strain (Mild)",
                          description:
                              "A small number of muscle fibers are overstretched, causing mild pain but no significant loss of strength.",
                          icon: Icons.looks_one,
                        ),
                        _buildMuscleStrainCard(
                          title: "Grade 2 Strain (Moderate)",
                          description:
                              "More muscle fibers are damaged, leading to swelling, bruising, and partial loss of strength.",
                          icon: Icons.looks_two,
                        ),
                        _buildMuscleStrainCard(
                          title: "Grade 3 Strain (Severe)",
                          description:
                              "A complete muscle tear, causing intense pain, loss of function, and possible surgery requirement.",
                          icon: Icons.looks_3,
                        ),
                        _buildMuscleStrainCard(
                          title: "R.I.C.E Treatment",
                          description:
                              "Rest, Ice, Compression, and Elevation—essential first aid for muscle strains.",
                          icon: Icons.health_and_safety,
                        ),
                        _buildMuscleStrainCard(
                          title: "Rehabilitation & Strengthening",
                          description:
                              "Gradual stretching, physical therapy, and strengthening exercises to aid recovery.",
                          icon: Icons.fitness_center,
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

  Widget _buildMuscleStrainCard({
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
