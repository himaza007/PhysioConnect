import 'package:flutter/material.dart';

class MuscleSelectionPage extends StatefulWidget {
  final List<String> muscles;
  final Function(List<String>) onSelectionComplete;

  const MuscleSelectionPage({
    Key? key,
    required this.muscles,
    required this.onSelectionComplete,
    required String bodyPart,
    required bool isDarkMode,
  }) : super(key: key);

  @override
  State<MuscleSelectionPage> createState() => _MuscleSelectionPageState();
}

class _MuscleSelectionPageState extends State<MuscleSelectionPage> {
  List<String> selectedMuscles = [];

  void toggleMuscleSelection(String muscle) {
    setState(() {
      if (selectedMuscles.contains(muscle)) {
        selectedMuscles.remove(muscle);
      } else {
        selectedMuscles.add(muscle);
      }
    });
  }

  void finalizeSelection() {
    widget.onSelectionComplete(selectedMuscles);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF06130D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F5F3A),
        elevation: 5,
        title: const Text(
          'Select Muscles',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, // Increased size by reducing items per row
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1.2, // Adjusted for bigger images
                ),
                itemCount: widget.muscles.length,
                itemBuilder: (context, index) {
                  return _buildMuscleGridItem(widget.muscles[index]);
                },
              ),
            ),
            const SizedBox(height: 20),
            if (selectedMuscles.isNotEmpty)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1F5F3D),
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 5,
                ),
                onPressed: finalizeSelection,
                child: const Text(
                  "Finalize Selection",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  Widget _buildMuscleGridItem(String muscle) {
    final Map<String, String> muscleImages = {
      "Clavicular Head of Sternocleidomastoid Muscle": "1.avif",
      "Depressor Anguli Oris Muscle": "2.avif",
      "Depressor Labii Inferioris Muscle": "3.avif",
      "Frontal Belly of Epicranius Muscle (Frontalis Muscle)": "4.avif",
      "Galea Aponeurotica": "5.avif",
      "Levator Labii Superioris Alaeque Nasi Muscle": "6.avif",
      "Levator Labii Superioris Muscle": "7.avif",
      "Masseter Muscle": "8.avif",
      "Mentalis Muscle": "9.avif",
      "Nasalis Muscle": "10.avif"
    };

    String imagePath = 'assets/body_parts/head/muscles/${muscleImages[muscle] ?? "placeholder.png"}';

    return GestureDetector(
      onTap: () => toggleMuscleSelection(muscle),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: selectedMuscles.contains(muscle) ? const Color(0xFF1A8D50) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 12,
              offset: const Offset(4, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Enlarged Image Section (FULLY VISIBLE)
            Expanded(
              flex: 4,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF1F5F3D), width: 2),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.contain, // Ensures full visibility without distortion
                    width: double.infinity,
                  ),
                ),
              ),
            ),

            // Text & Checkbox Section
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      muscle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16, // Bigger text
                        fontWeight: FontWeight.bold,
                        color: selectedMuscles.contains(muscle) ? Colors.white : const Color(0xFF083D10),
                      ),
                    ),
                    Transform.scale(
                      scale: 1.4, // Enlarged checkbox for better usability
                      child: Checkbox(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                        checkColor: Colors.white,
                        activeColor: const Color(0xFF1F5F3D),
                        value: selectedMuscles.contains(muscle),
                        onChanged: (bool? value) {
                          toggleMuscleSelection(muscle);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
