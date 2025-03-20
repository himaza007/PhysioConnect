import 'package:flutter/material.dart';
import 'muscle_selection_page.dart';

class InteractiveHumanBody extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  const InteractiveHumanBody({Key? key, required this.toggleTheme, required this.isDarkMode})
      : super(key: key);

  @override
  State<InteractiveHumanBody> createState() => _InteractiveHumanBodyState();
}

class _InteractiveHumanBodyState extends State<InteractiveHumanBody> {
  String currentView = 'front';
  bool isMale = true;
  List<String> selectedParts = [];

  void changeView(String view) {
    setState(() {
      currentView = view;
      selectedParts.clear();
    });
  }

  void toggleGender() {
    setState(() {
      isMale = !isMale;
      selectedParts.clear();
    });
  }

  void proceedToMuscleSelection(String bodyPart) {
    List<String> muscles = _muscles[bodyPart] ?? [];

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MuscleSelectionPage(
          bodyPart: bodyPart,
          muscles: muscles,
          isDarkMode: widget.isDarkMode,
          onSelectionComplete: (selectedMuscles) {
            print("Muscle selection completed for $bodyPart: $selectedMuscles");
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String imagePath = 'assets/images/';
    imagePath += isMale
        ? (currentView == 'front'
            ? 'front.png'
            : currentView == 'back'
                ? 'back.png'
                : 'side_right.png')
        : (currentView == 'front'
            ? 'front_female.png'
            : currentView == 'back'
                ? 'back_female.png'
                : 'side_female.png');

    List<String> bodyParts = _bodyParts[currentView] ?? [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF33724B),
        title: Text(
          'PhysioConnect: Human Body',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode, color: Colors.white),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20), // Increased spacing
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildModernButton("Front", () => changeView('front')),
                SizedBox(width: 20),
                _buildModernButton("Back", () => changeView('back')),
                SizedBox(width: 20),
                _buildModernButton("Side", () => changeView('side_right')),
                SizedBox(width: 20),
                _buildModernButton(isMale ? "Female View" : "Male View", toggleGender),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                _buildSideBodyPartList(bodyParts),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Image.asset(imagePath, width: 420),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF33724B),
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
    );
  }

  Widget _buildSideBodyPartList(List<String> parts) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: parts.map((part) => _buildBodyPartButton(part)).toList(),
        ),
      ),
    );
  }

  Widget _buildBodyPartButton(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        onPressed: () => proceedToMuscleSelection(text),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF33724B),
          padding: EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }

  final Map<String, List<String>> _bodyParts = {
    'front': ['Head', 'Chest', 'Abdomen', 'Arms', 'Legs'],
    'back': ['Upper Back', 'Lower Back', 'Shoulders', 'Glutes', 'Hamstrings'],
  };

  final Map<String, List<String>> _muscles = {
    'Head': [
      'Clavicular Head of Sternocleidomastoid Muscle',
      'Depressor Anguli Oris Muscle',
      'Depressor Labii Inferioris Muscle',
      'Frontal Belly of Epicranius Muscle (Frontalis Muscle)',
      'Galea Aponeurotica',
      'Levator Labii Superioris Alaeque Nasi Muscle',
      'Levator Labii Superioris Muscle',
      'Masseter Muscle',
      'Mentalis Muscle',
      'Nasalis Muscle'
    ],
  };
}
