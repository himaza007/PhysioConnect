import 'package:flutter/material.dart';

class MuscleSelectionPage extends StatefulWidget {
  final String bodyPart;
  final bool isDarkMode;

  const MuscleSelectionPage({Key? key, required this.bodyPart, required this.isDarkMode})
      : super(key: key);

  @override
  _MuscleSelectionPageState createState() => _MuscleSelectionPageState();
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

  @override
  Widget build(BuildContext context) {
    List<String> muscles = _muscles[widget.bodyPart] ?? [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF33724B),
        title: Text(
          '${widget.bodyPart} Muscles',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemCount: muscles.length,
        itemBuilder: (context, index) {
          String muscle = muscles[index];
          return GestureDetector(
            onTap: () => toggleMuscleSelection(muscle),
            child: Card(
              color: selectedMuscles.contains(muscle) ? Color(0xFF33724B) : Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/body_parts/${widget.bodyPart.toLowerCase()}/muscles/${index + 1}.png', width: 80),
                  Text(muscle, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  final Map<String, List<String>> _muscles = {
    'Head': ['Frontalis', 'Temporalis'],
    'Arms': ['Biceps', 'Triceps'],
  };
}
