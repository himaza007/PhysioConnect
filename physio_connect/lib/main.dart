import 'package:flutter/material.dart';

void main() {
  runApp(const PhysioConnectApp());
}

class PhysioConnectApp extends StatefulWidget {
  const PhysioConnectApp({Key? key}) : super(key: key);

  @override
  State<PhysioConnectApp> createState() => _PhysioConnectAppState();
}

class _PhysioConnectAppState extends State<PhysioConnectApp> {
  bool isDarkMode = true;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkMode
          ? ThemeData.dark().copyWith(
              scaffoldBackgroundColor: Color(0xFF06130D),
              textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.white)),
            )
          : ThemeData.light().copyWith(
              scaffoldBackgroundColor: Color(0xFFEAF7FF),
              textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.black)),
            ),
      home: InteractiveHumanBody(toggleTheme: toggleTheme, isDarkMode: isDarkMode),
    );
  }
}

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
  List<String> selectedMuscles = [];
  bool showingMuscles = false;

  void toggleSelection(String bodyPart) {
    setState(() {
      if (selectedParts.contains(bodyPart)) {
        selectedParts.remove(bodyPart);
      } else {
        selectedParts.add(bodyPart);
      }
    });
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

  void changeView(String view) {
    setState(() {
      currentView = view;
      selectedParts.clear();
      selectedMuscles.clear();
      showingMuscles = false;
    });
  }

  void toggleGender() {
    setState(() {
      isMale = !isMale;
      selectedParts.clear();
      selectedMuscles.clear();
      showingMuscles = false;
    });
  }

  void proceedToMuscleSelection() {
    setState(() {
      showingMuscles = true;
      selectedMuscles.clear();
    });
  }

  void finalizeSelection() {
    print("Final selection: $selectedMuscles");
  }

  @override
  Widget build(BuildContext context) {
    String imagePath = 'assets/images/';
    if (isMale) {
      if (currentView == 'front') imagePath += 'front.png';
      if (currentView == 'back') imagePath += 'back.png';
      if (currentView == 'side_right') imagePath += 'side_right.png';
    } else {
      if (currentView == 'front') imagePath += 'front_female.png';
      if (currentView == 'back') imagePath += 'back_female.png';
      if (currentView == 'side_right') imagePath += 'side_female.png';
    }

    List<String> bodyParts = _bodyParts[currentView] ?? [];
    List<String> muscles = showingMuscles ? (_muscles[selectedParts.first] ?? []) : [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF33724B),
        elevation: 0,
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
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildModernButton("Front", () => changeView('front')),
                SizedBox(width: 15),
                _buildModernButton("Back", () => changeView('back')),
                SizedBox(width: 15),
                _buildModernButton("Side", () => changeView('side_right')),
                SizedBox(width: 15),
                _buildModernButton(isMale ? "Female View" : "Male View", toggleGender),
              ],
            ),
          ),

          Expanded(
            child: Row(
              children: [
                showingMuscles ? _buildSideMuscleList(muscles) : _buildSideBodyPartList(bodyParts),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Image.asset(imagePath, width: 420),
                  ),
                ),
              ],
            ),
          ),

          if (!showingMuscles && selectedParts.isNotEmpty) _buildContinueButton("Continue", proceedToMuscleSelection),
          if (showingMuscles && selectedMuscles.isNotEmpty) _buildContinueButton("Finalize Selection", finalizeSelection),
        ],
      ),
    );
  }

  Widget _buildModernButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF33724B),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
    );
  }

  Widget _buildContinueButton(String text, VoidCallback onPressed) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF33724B),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: onPressed,
        child: Text(text, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }

  Widget _buildSideBodyPartList(List<String> parts) {
    return Expanded(
      flex: 1,
      child: ListView(
        children: parts.map((part) => _buildBodyPartButton(part)).toList(),
      ),
    );
  }

  Widget _buildSideMuscleList(List<String> muscles) {
    return Expanded(
      flex: 1,
      child: ListView(
        children: muscles.map((muscle) => _buildMuscleButton(muscle)).toList(),
      ),
    );
  }

  Widget _buildBodyPartButton(String text) {
    return _buildToggleButton(text, selectedParts.contains(text), () => toggleSelection(text));
  }

  Widget _buildMuscleButton(String text) {
    return _buildToggleButton(text, selectedMuscles.contains(text), () => toggleMuscleSelection(text));
  }

  Widget _buildToggleButton(String text, bool isSelected, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Color(0xFF33724B) : Colors.grey[700],
        padding: EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
    );
  }

  final Map<String, List<String>> _bodyParts = {
    'front': ['Head', 'Chest', 'Abdomen', 'Arms', 'Legs'],
    'back': ['Upper Back', 'Lower Back', 'Shoulders', 'Glutes', 'Hamstrings'],
  };

  final Map<String, List<String>> _muscles = {
    'Head': ['Frontalis', 'Temporalis'],
    'Arms': ['Biceps', 'Triceps'],
  };
}
