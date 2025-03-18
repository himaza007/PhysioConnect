import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: InteractiveHumanBody(),
  ));
}

class InteractiveHumanBody extends StatefulWidget {
  @override
  _InteractiveHumanBodyState createState() => _InteractiveHumanBodyState();
}

class _InteractiveHumanBodyState extends State<InteractiveHumanBody> {
  String selectedBodyPart = 'Tap a body part';
  String currentView = 'front'; // Default view
  bool isMale = true; // Toggle male/female images

  void updateSelection(String bodyPart) {
    setState(() {
      selectedBodyPart = bodyPart;
    });
  }

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

    return Scaffold(
      appBar: AppBar(title: Text('Interactive Human Body')),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: () => changeView('front'), child: Text('Front')),
              ElevatedButton(onPressed: () => changeView('back'), child: Text('Back')),
              ElevatedButton(onPressed: () => changeView('side_right'), child: Text('Side')),
              ElevatedButton(onPressed: toggleGender, child: Text(isMale ? 'Switch to Female' : 'Switch to Male')),
            ],
          ),
          Expanded(
            child: Stack(
              children: [
                // Display the current image
                Center(
                  child: Image.asset(imagePath, width: 300),
                ),

                // Tappable Regions (adjust based on image positioning)
                // Head
                Positioned(
                  top: 50, left: 160, width: 60, height: 60,
                  child: GestureDetector(
                    onTap: () => updateSelection('Head'),
                    child: Container(color: Colors.transparent),
                  ),
                ),
                // Shoulder
                Positioned(
                  top: 120, left: 140, width: 80, height: 50,
                  child: GestureDetector(
                    onTap: () => updateSelection('Shoulder'),
                    child: Container(color: Colors.transparent),
                  ),
                ),
                // Arm
                Positioned(
                  top: 180, left: 150, width: 60, height: 100,
                  child: GestureDetector(
                    onTap: () => updateSelection('Arm'),
                    child: Container(color: Colors.transparent),
                  ),
                ),
                // Abdomen
                Positioned(
                  top: 250, left: 140, width: 100, height: 80,
                  child: GestureDetector(
                    onTap: () => updateSelection('Abdomen'),
                    child: Container(color: Colors.transparent),
                  ),
                ),
                // Leg
                Positioned(
                  top: 350, left: 140, width: 60, height: 120,
                  child: GestureDetector(
                    onTap: () => updateSelection('Leg'),
                    child: Container(color: Colors.transparent),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              selectedBodyPart,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
