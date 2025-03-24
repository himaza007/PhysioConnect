import 'package:flutter/material.dart';
import 'main_body_part_page.dart';

class InteractiveHumanBody extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  const InteractiveHumanBody({super.key, required this.toggleTheme, required this.isDarkMode});

  @override
  State<InteractiveHumanBody> createState() => _InteractiveHumanBodyState();
}

class _InteractiveHumanBodyState extends State<InteractiveHumanBody> {
  String currentView = 'front';
  bool isMale = true;

  void changeView(String view) {
    setState(() {
      currentView = view;
    });
  }

  void toggleGender() {
    setState(() {
      isMale = !isMale;
    });
  }

  void navigateToMainBodyPart(String bodyPart) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainBodyPartPage(
          bodyPart: bodyPart,
          isDarkMode: widget.isDarkMode,
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
      backgroundColor: const Color(0xFF06130D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF33724B),
        title: const Text('PhysioConnect: Human Body',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white)),
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
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildViewButton("Front", () => changeView('front')),
              const SizedBox(width: 10),
              _buildViewButton("Back", () => changeView('back')),
              const SizedBox(width: 10),
              _buildViewButton("Side", () => changeView('side_right')),
              const SizedBox(width: 10),
              _buildViewButton(isMale ? "Female View" : "Male View", toggleGender),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Row(
              children: [
                _buildSidePartList(bodyParts),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
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

  Widget _buildViewButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF33724B),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(text,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
    );
  }

  Widget _buildSidePartList(List<String> parts) {
    return Expanded(
      flex: 1,
      child: ListView(
        children: parts
            .map((part) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: ElevatedButton(
                    onPressed: () => navigateToMainBodyPart(part),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF33724B),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(part,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ))
            .toList(),
      ),
    );
  }

  final Map<String, List<String>> _bodyParts = {
    'front': ['Head', 'Chest', 'Abdomen', 'Arms', 'Legs'],
    'back': ['Upper Back', 'Lower Back', 'Shoulders', 'Glutes', 'Hamstrings'],
  };
}
