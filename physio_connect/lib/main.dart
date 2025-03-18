import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Color.fromARGB(255, 75, 109, 87),
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

    List<String> bodyParts = _bodyParts[currentView]!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        elevation: 0,
        title: Text(
          'PhysioConnect: Human Body',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
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
                // Left Side - List of Selectable Body Parts
                _buildSideBodyPartList(bodyParts),

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
                      child: Image.asset(imagePath, width: 420),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Selected Parts Horizontal List
          if (selectedParts.isNotEmpty)
            Container(
              height: 70,
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 10),
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
  Widget _buildSideBodyPartList(List<String> parts) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: ListView.builder(
          itemCount: parts.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: _buildBodyPartButton(parts[index]),
            );
          },
        ),
      ),
    );
  }

  // Body Part Selection Button
  Widget _buildBodyPartButton(String text) {
    return GestureDetector(
      onTap: () => toggleSelection(text),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
        decoration: BoxDecoration(
          color: selectedParts.contains(text) ? Color(0xFF33724B) : Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 6,
              spreadRadius: 2,
            )
          ],
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  // Selected Parts Horizontal Chip
  Widget _buildSelectedPartChip(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Chip(
        label: Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
        backgroundColor: Color(0xFFEAF7FF),
        deleteIcon: Icon(Icons.close, color: Colors.black),
        onDeleted: () => toggleSelection(text),
      ),
    );
  }

  // Modern High-End Button
  Widget _buildModernButton(String text, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
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
        child: Text(
          text,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
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
