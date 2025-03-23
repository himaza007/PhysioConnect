import 'package:flutter/material.dart';

class MuscleSelectionPage extends StatefulWidget {
  final String bodyPart;
  final List<String> muscles;
  final bool isDarkMode;
  final Function(List<String>) onSelectionComplete;

  const MuscleSelectionPage({
    super.key,
    required this.bodyPart,
    required this.muscles,
    required this.isDarkMode,
    required this.onSelectionComplete,
  });

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
        title: Text(
          'Select Muscles (${widget.bodyPart})',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontFamily: 'Montserrat',
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: widget.muscles.length,
                separatorBuilder: (_, __) => const SizedBox(height: 20),
                itemBuilder: (context, index) => _buildMuscleTile(widget.muscles[index]),
              ),
            ),
            const SizedBox(height: 10),
            if (selectedMuscles.isNotEmpty)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1F5F3D),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 5,
                ),
                onPressed: finalizeSelection,
                child: const Text(
                  "Finalize Selection",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildMuscleTile(String muscle) {
    final muscleImages = {
      "Clavicular Head of Sternocleidomastoid Muscle": "1.avif",
      "Depressor Anguli Oris Muscle": "2.avif",
      "Depressor Labii Inferioris Muscle": "3.avif",
      "Frontal Belly of Epicranius Muscle (Frontalis Muscle)": "4.avif",
      "Galea Aponeurotica": "5.avif",
      "Levator Labii Superioris Alaeque Nasi Muscle": "6.avif",
      "Levator Labii Superioris Muscle": "7.avif",
      "Masseter Muscle": "8.avif",
      "Mentalis Muscle": "9.avif",
      "Nasalis Muscle": "10.avif",
      "Occipital Belly of Epicranius Muscle (Occipitalis Muscle)": "11.avif",
      "Omohyoid Muscle": "12.avif",
      "Orbicularis Oculi Muscle": "13.avif",
      "Orbicularis Oris Muscle": "14.avif",
      "Platysma Muscle": "15.avif",
      "Risorius Muscle": "16.avif",
      "Scalene Muscles": "17.avif",
      "Semispinalis Capitis Muscle": "18.avif",
      "Splenius Capitis Muscle": "19.avif",
      "Sternal Head of Sternocleidomastoid Muscle": "20.avif",
      "Temporalis Muscle": "21.avif",
      "Zygomaticus Major Muscle": "22.avif",
      "Zygomaticus Minor Muscle": "23.avif",
    };

    String imagePath = 'assets/body_parts/head/muscles/${muscleImages[muscle] ?? "placeholder.png"}';

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: selectedMuscles.contains(muscle) ? const Color(0xFF1A8D50) : Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(2, 4),
          )
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imagePath,
              width: 90,
              height: 90,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              muscle,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: selectedMuscles.contains(muscle) ? Colors.white : const Color(0xFF083D10),
              ),
            ),
          ),
          Transform.scale(
            scale: 1.3,
            child: Checkbox(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              checkColor: Colors.white,
              activeColor: const Color(0xFF1F5F3D),
              value: selectedMuscles.contains(muscle),
              onChanged: (_) => toggleMuscleSelection(muscle),
            ),
          ),
        ],
      ),
    );
  }
}
