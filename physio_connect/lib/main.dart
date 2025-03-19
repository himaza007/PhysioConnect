import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Color.fromARGB(255, 84, 145, 96),
      textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.white)),
    ),
    home: InteractiveHumanBody(),
  ));
}

class InteractiveHumanBody extends StatefulWidget {
  @override
  State<InteractiveHumanBody> createState() => InteractiveHumanBodyState();
}

class InteractiveHumanBodyState extends State<InteractiveHumanBody> {
  String currentView = 'front';
  bool isMale = true;
  List<String> selectedParts = [];

  void toggleSelection(String bodyPart) {
    setState(() {
      if (selectedParts.contains(bodyPart)) {
        selectedParts.remove(bodyPart);
      } else {
        selectedParts.add(bodyPart);
      }
    });
  }

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
z
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonTextSize = screenWidth * 0.055; // Scales dynamically

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

    List<String> bodyParts = _bodyParts[currentView]!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        elevation: 0,
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'PhysioConnect: Human Body',
            style: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // View & Gender Buttons
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildModernButton("Front", () => changeView('front'), buttonTextSize),
                SizedBox(width: 10),
                _buildModernButton("Back", () => changeView('back'), buttonTextSize),
                SizedBox(width: 10),
                _buildModernButton("Side", () => changeView('side_right'), buttonTextSize),
                SizedBox(width: 10),
                _buildModernButton(isMale ? "Female View" : "Male View", toggleGender, buttonTextSize),
              ],
            ),
          ),

          Expanded(
            child: Row(
              children: [
                // Left Side - List of Selectable Body Parts
                _buildSideBodyPartList(bodyParts, buttonTextSize),

                // Center - Enlarged Body Image
                Expanded(
                  flex: 5,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF33724B).withOpacity(0.5),
                            blurRadius: 20,
                            spreadRadius: 5,
                          )
                        ],
                      ),
                      child: Image.asset(imagePath, width: screenWidth * 0.75), // Responsive Image
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Selected Parts Horizontal List
          if (selectedParts.isNotEmpty)
            Container(
              height: 60,
              margin: EdgeInsets.symmetric(vertical: 8),
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: selectedParts.map((part) => _buildSelectedPartChip(part)).toList(),
              ),
            ),
        ],
      ),
    );
  }

  // Side List of Body Parts
  Widget _buildSideBodyPartList(List<String> parts, double textSize) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: ListView.builder(
          itemCount: parts.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: _buildBodyPartButton(parts[index], textSize),
            );
          },
        ),
      ),
    );
  }

  // Body Part Selection Button
  Widget _buildBodyPartButton(String text, double textSize) {
    return GestureDetector(
      onTap: () => toggleSelection(text),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: selectedParts.contains(text) ? Color(0xFF33724B) : Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 6,
              spreadRadius: 2,
            )
          ],
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            text,
            style: TextStyle(fontSize: textSize, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }

  // Selected Parts Horizontal Chip
  Widget _buildSelectedPartChip(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Chip(
        label: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            text,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        backgroundColor: Color(0xFFEAF7FF),
        deleteIcon: Icon(Icons.close, color: Colors.black),
        onDeleted: () => toggleSelection(text),
      ),
    );
  }

  // Modern High-End Button
  Widget _buildModernButton(String text, VoidCallback onPressed, double textSize) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              spreadRadius: 3,
            )
          ],
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            text,
            style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.05, // Increased for better visibility
            fontWeight: FontWeight.bold,
            color: Colors.white,
  )

          ),
        ),
      ),
    );
  }

  // Body Parts for Each View
  final Map<String, List<String>> _bodyParts = {
    'front': ['Head', 'Chest', 'Abdomen', 'Arms', 'Legs'],
    'back': ['Upper Back', 'Lower Back', 'Shoulders', 'Glutes', 'Hamstrings'],
    'side_right': ['Neck', 'Shoulders', 'Ribs', 'Hips', 'Thigh'],
  };
}
