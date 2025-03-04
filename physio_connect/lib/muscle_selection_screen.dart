import 'package:flutter/material.dart';

class MuscleSelectionScreen extends StatelessWidget {
  final List<String> selectedAreas;
  const MuscleSelectionScreen({super.key, required this.selectedAreas});

  // Muscle data is declared as a static constant with constant literals.
  static const Map<String, List<Map<String, String>>> muscleData = {
    "Shoulder": [
      {"name": "Deltoid", "image": "assets/muscles/deltoid.png"},
      {"name": "Trapezius", "image": "assets/muscles/trapezius.png"},
      {"name": "Rotator Cuff", "image": "assets/muscles/rotator_cuff.png"},
    ],
    "Elbow": [
      {"name": "Biceps Brachii", "image": "assets/muscles/biceps.png"},
      {"name": "Triceps Brachii", "image": "assets/muscles/triceps.png"},
    ],
    "Knee": [
      {"name": "Quadriceps", "image": "assets/muscles/quadriceps.png"},
      {"name": "Hamstrings", "image": "assets/muscles/hamstrings.png"},
    ],
    "Ankle": [
      {"name": "Gastrocnemius", "image": "assets/muscles/gastrocnemius.png"},
      {"name": "Soleus", "image": "assets/muscles/soleus.png"},
    ],
    "Head": [
      {"name": "Forehead", "image": "assets/muscles/forehead.png"},
      {"name": "Jaw", "image": "assets/muscles/jaw.png"},
    ],
  };

  @override
  Widget build(BuildContext context) {
    // Aggregate muscle data from all selected pain areas.
    List<Map<String, String>> muscles = [];
    for (var area in selectedAreas) {
      muscles.addAll(muscleData[area] ?? []);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Muscle"),
        backgroundColor: const Color.fromARGB(255, 1, 99, 45),
        elevation: 0,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image for a modern look.
          Image.asset("assets/images/bg.jpg", fit: BoxFit.cover),
          Container(color: Colors.black.withOpacity(0.4)),
          Column(
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: muscles.length,
                  itemBuilder: (context, index) {
                    final muscle = muscles[index];
                    return TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: const Duration(milliseconds: 500),
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: child,
                        );
                      },
                      child: GestureDetector(
                        onTap: () {
                          // Navigate to the remedies/first aid screen (handled by your friend)
                          Navigator.pushNamed(context, "/remedies", arguments: muscle["name"]);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.white.withOpacity(0.5), width: 1.5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 10,
                                spreadRadius: 3,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Hero(
                                  tag: muscle["name"]!,
                                  child: Image.asset(
                                    muscle["image"]!,
                                    width: 70,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  muscle["name"]!,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const Icon(Icons.arrow_forward_ios, color: Colors.white),
                              const SizedBox(width: 10),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
