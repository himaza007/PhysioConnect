import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Color(0xFF0D1B2A),
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
  String selectedBodyPart = 'Tap a body part';
  String currentView = 'front';
  bool isMale = true;

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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Interactive Human Body', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Modern Buttons Row
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildModernButton("Front", () => changeView('front')),
                _buildModernButton("Back", () => changeView('back')),
                _buildModernButton("Side", () => changeView('side_right')),
                _buildModernButton(isMale ? "Switch to Female" : "Switch to Male", toggleGender),
              ],
            ),
          ),

          // 3D Human Body Section
          Expanded(
            child: Stack(
              children: [
                Center(
                  child: AnimatedOpacity(
                    duration: Duration(milliseconds: 400),
                    opacity: 1.0,
                    child: Image.asset(imagePath, width: 300),
                  ),
                ),

                // Modern Interactive Areas with Arrows
                for (var entry in _bodyParts.entries)
                  Positioned(
                    left: entry.value.dx,
                    top: entry.value.dy,
                    child: Column(
                      children: [
                        _buildArrow(), // Arrow pointing to body part
                        GestureDetector(
                          onTap: () => updateSelection(entry.key),
                          child: _buildBodyPartButton(entry.key),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          // Selected Body Part Info Panel
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white.withOpacity(0.1),
                border: Border.all(color: Colors.white.withOpacity(0.3)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 5,
                  )
                ],
              ),
              padding: EdgeInsets.all(16),
              child: Center(
                child: Text(
                  selectedBodyPart,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // High-End Modern Button
  Widget _buildModernButton(String text, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 6,
              spreadRadius: 2,
            )
          ],
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  // Arrow Widget
  Widget _buildArrow() {
    return Icon(Icons.arrow_downward, color: Colors.white, size: 24);
  }

  // Body Part Button
  Widget _buildBodyPartButton(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            spreadRadius: 1,
          )
        ],
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  // Body Parts with Coordinates
  final Map<String, Offset> _bodyParts = {
    'Head': Offset(160, 50),
    'Shoulder': Offset(140, 120),
    'Arm': Offset(150, 180),
    'Abdomen': Offset(140, 250),
    'Leg': Offset(140, 350),
  };
}
