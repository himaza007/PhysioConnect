import 'package:flutter/material.dart';

class MuscleSelectionPage extends StatefulWidget {
  final String bodyPart;
  final bool isDarkMode;
  final Function(List<String>) onSelectionComplete;

  const MuscleSelectionPage({
    Key? key,
    required this.bodyPart,
    required this.isDarkMode,
    required this.onSelectionComplete,
  }) : super(key: key);

  @override
  State<MuscleSelectionPage> createState() => _MuscleSelectionPageState();
}

class _MuscleSelectionPageState extends State<MuscleSelectionPage> {
  List<String> selectedMuscles = [];

  final Map<String, List<String>> muscleData = {
    "Head": [
      "Clavicular Head of Sternocleidomastoid Muscle",
      "Depressor Anguli Oris Muscle",
      "Depressor Labii Inferioris Muscle",
      "Frontal Belly of Epicranius Muscle (Frontalis Muscle)",
      "Galea Aponeurotica",
      "Levator Labii Superioris Alaeque Nasi Muscle",
      "Levator Labii Superioris Muscle",
      "Masseter Muscle",
      "Mentalis Muscle",
      "Nasalis Muscle",
      "Occipital Belly of Epicranius Muscle (Occipitalis Muscle)",
      "Omohyoid Muscle",
      "Orbicularis Oculi Muscle",
      "Orbicularis Oris Muscle",
      "Platysma Muscle",
      "Risorius Muscle",
      "Scalene Muscles",
      "Semispinalis Capitis Muscle",
      "Splenius Capitis Muscle",
      "Sternal Head of Sternocleidomastoid Muscle",
      "Temporalis Muscle",
      "Zygomaticus Major Muscle",
      "Zygomaticus Minor Muscle",
    ],
    "Chest": [
      "Pectoralis Major",
      "Pectoralis Minor",
      "Serratus Anterior",
      "Subclavius",
      "Intercostal Muscles",
      "Costal Cartilage",
      "Manubrium",
      "Sternal Angle",
      "Xiphoid Process",
      "Thoracic Diaphragm",
      "External Oblique (Upper)",
    ],
    "Abdomen": [
      "Rectus Abdominis",
      "External Oblique",
      "Internal Oblique",
      "Transversus Abdominis",
    ],
    "Arms": [
      "Biceps Brachii",
      "Triceps Brachii",
      "Brachialis",
      "Coracobrachialis",
      "Deltoid",
      "Anconeus",
      "Flexor Carpi Radialis",
      "Palmaris Longus",
      "Flexor Carpi Ulnaris",
      "Flexor Digitorum Superficialis",
      "Flexor Digitorum Profundus",
      "Extensor Carpi Radialis",
      "Extensor Digitorum",
      "Extensor Carpi Ulnaris",
      "Pronator Teres",
      "Supinator",
      "Abductor Pollicis Longus",
      "Extensor Pollicis Brevis",
      "Extensor Indicis",
      "Thenar Muscles",
      "Hypothenar Muscles",
      "Brachioradialis",
      "Subscapularis",
      "Supraspinatus",
      "Infraspinatus",
      "Teres Major",
      "Teres Minor",
    ],
  };

  String getMuscleImagePath(String bodyPart, int index) {
    final folderMap = {
      "Head": "Head",
      "Chest": "Area2",
      "Abdomen": "abdomen",
      "Arms": "Area4",
    };

    final folder = folderMap[bodyPart] ?? "Head";
    return 'assets/body_parts/$folder/muscles/${index + 1}.avif';
  }

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
    final muscles = muscleData[widget.bodyPart] ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFF06130D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F5F3A),
        title: Text(
          '${widget.bodyPart} Muscles',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 14),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: muscles.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1.3,
                ),
                itemBuilder: (context, index) {
                  final muscle = muscles[index];
                  return _buildMuscleCard(muscle, getMuscleImagePath(widget.bodyPart, index));
                },
              ),
            ),
            const SizedBox(height: 10),
            if (selectedMuscles.isNotEmpty)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1F5F3D),
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 30),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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

  Widget _buildMuscleCard(String muscle, String imagePath) {
    final selected = selectedMuscles.contains(muscle);

    return GestureDetector(
      onTap: () => toggleMuscleSelection(muscle),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF1A8D50) : const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) => const Center(
                    child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      muscle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: selected ? Colors.white : const Color(0xFF06130D),
                      ),
                    ),
                    Transform.scale(
                      scale: 1.3,
                      child: Checkbox(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        checkColor: Colors.white,
                        activeColor: const Color(0xFF1F5F3D),
                        value: selected,
                        onChanged: (value) => toggleMuscleSelection(muscle),
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
