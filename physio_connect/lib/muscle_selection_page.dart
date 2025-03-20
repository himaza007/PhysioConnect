import 'package:flutter/material.dart';

class MuscleSelectionPage extends StatefulWidget {
  final List<String> muscles;
  final Function(List<String>) onSelectionComplete;

  const MuscleSelectionPage({
    Key? key,
    required this.muscles,
    required this.onSelectionComplete, required String bodyPart, required bool isDarkMode,
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
      appBar: AppBar(
        backgroundColor: const Color(0xFF33724B),
        elevation: 0,
        title: const Text(
          'Select Muscles',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemCount: widget.muscles.length,
                itemBuilder: (context, index) {
                  return _buildMuscleGridItem(widget.muscles[index], index);
                },
              ),
            ),
            const SizedBox(height: 10),
            if (selectedMuscles.isNotEmpty)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF33724B),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: finalizeSelection,
                child: const Text(
                  "Finalize Selection",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMuscleGridItem(String muscle, int index) {
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
      child: Card(
        color: selectedMuscles.contains(muscle) ? Colors.teal[700] : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover, // Ensures the image fills the grid box
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    muscle,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  Checkbox(
                    value: selectedMuscles.contains(muscle),
                    onChanged: (bool? value) {
                      toggleMuscleSelection(muscle);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}