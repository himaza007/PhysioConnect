import 'package:flutter/material.dart';

class EffectiveStretchingTechniquesScreen extends StatelessWidget {
  const EffectiveStretchingTechniquesScreen({super.key});

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
            "Effective Stretching Techniques",
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
                    "Stretching Techniques",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF33724B), // Midnight Teal
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Stretching is an essential part of any fitness or rehabilitation program. Proper stretching improves flexibility, reduces muscle tension, and helps prevent injuries. Here are some effective stretching techniques you can incorporate into your routine.",
                    style: TextStyle(fontSize: 15, color: Colors.black87),
                  ),
                  const SizedBox(height: 15),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        _buildStretchingCard(
                          title: "Static Stretching",
                          description:
                              "Holding a stretch for a prolonged period to increase flexibility and relax muscles.",
                          icon: Icons.accessibility,
                        ),
                        _buildStretchingCard(
                          title: "Dynamic Stretching",
                          description:
                              "Involves controlled movements to improve range of motion and activate muscles.",
                          icon: Icons.directions_walk,
                        ),
                        _buildStretchingCard(
                          title: "PNF Stretching",
                          description:
                              "A technique that combines stretching and contracting the muscle to enhance flexibility.",
                          icon: Icons.fitness_center,
                        ),
                        _buildStretchingCard(
                          title: "Ballistic Stretching",
                          description:
                              "Uses bouncing movements to stretch muscles beyond their normal range.",
                          icon: Icons.sports_gymnastics,
                        ),
                        _buildStretchingCard(
                          title: "Active Isolated Stretching",
                          description:
                              "Short, repeated stretches targeting specific muscle groups to improve mobility.",
                          icon: Icons.accessibility_new,
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

  Widget _buildStretchingCard({
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
