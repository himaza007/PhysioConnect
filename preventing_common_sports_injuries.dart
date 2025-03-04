import 'package:flutter/material.dart';

class PreventingCommonSportsInjuriesScreen extends StatelessWidget {
  const PreventingCommonSportsInjuriesScreen({super.key});

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
            "Preventing Sports Injuries",
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
                    "Sports Injury Prevention",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF33724B), // Midnight Teal
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Preventing sports injuries is crucial for athletes and fitness enthusiasts. By following proper techniques, warming up, and using the right equipment, injuries can be significantly reduced. Here are some essential strategies to stay injury-free in sports.",
                    style: TextStyle(fontSize: 15, color: Colors.black87),
                  ),
                  const SizedBox(height: 15),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        _buildInjuryPreventionCard(
                          title: "Proper Warm-up & Cool-down",
                          description:
                              "Warming up prepares muscles for activity, and cooling down helps in muscle recovery.",
                          icon: Icons.directions_run,
                        ),
                        _buildInjuryPreventionCard(
                          title: "Strength & Conditioning",
                          description:
                              "Regular strength training helps improve muscle endurance and reduces injury risk.",
                          icon: Icons.fitness_center,
                        ),
                        _buildInjuryPreventionCard(
                          title: "Use Proper Equipment",
                          description:
                              "Wearing the right gear (e.g., shoes, helmets) prevents unnecessary injuries.",
                          icon: Icons.sports_soccer,
                        ),
                        _buildInjuryPreventionCard(
                          title: "Stay Hydrated & Maintain Nutrition",
                          description:
                              "Hydration and a balanced diet improve muscle function and recovery.",
                          icon: Icons.local_drink,
                        ),
                        _buildInjuryPreventionCard(
                          title: "Listen to Your Body",
                          description:
                              "Avoid overtraining; rest when needed to prevent stress injuries.",
                          icon: Icons.health_and_safety,
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

  Widget _buildInjuryPreventionCard({
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
