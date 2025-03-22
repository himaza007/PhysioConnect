import 'package:flutter/material.dart';
import 'package:physioconnect/screens/first_aid_details.dart';

class FirstAidTutorialScreen extends StatelessWidget {
  const FirstAidTutorialScreen({super.key});

  final List<Map<String, String>> _tutorials = const [
    {"title": "Foot Pain Relief", "videoId": "8Sj8uUOeobI"},
    {"title": "Knee Pain Relief", "videoId": "1rHqj6oSmuI"},
    {"title": "Neck & Shoulders Pain Relief", "videoId": "ZKAWlKTSSPo"},
    {"title": "Full Knee Taping", "videoId": "gyWOYwawZo0"},
    {"title": "Heel Pain Relief", "videoId": "B7mel2bM-KE"},
    {"title": "Turf Toe Taping", "videoId": "wtKP4_JbeB8"},
    {"title": "Triceps Taping", "videoId": "yeI-6YGo5z4"},
    {"title": "Thumb Tendon", "videoId": "urZ8tB3WFtQ"},
    {"title": "Top of Foot", "videoId": "gKqgf9101EE"},
    {"title": "SI Joint", "videoId": "OTXhuOPHDo0"},
    {"title": "Tennis Elbow Taping", "videoId": "__tVu5gntqA"},
    {"title": "Wrist Taping", "videoId": "91DHdEeFokM"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF7FF),
      appBar: AppBar(
        title: const Text(
          "First Aid Tutorials",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF33724B),
        centerTitle: true,
        elevation: 4,
        shadowColor: Colors.black45,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _tutorials.length,
        itemBuilder: (context, index) {
          final tutorial = _tutorials[index];
          return AnimatedContainer(
            duration: Duration(milliseconds: 300 + index * 100),
            curve: Curves.easeInOut,
            child: Card(
              color: Colors.white,
              elevation: 6,
              margin: const EdgeInsets.only(bottom: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF33724B).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.play_circle_fill,
                      color: const Color(0xFF33724B), size: 30),
                ),
                title: Text(
                  tutorial["title"]!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    color: Color(0xFF06130D),
                  ),
                ),
                subtitle: const Text(
                  "Tap to watch tutorial",
                  style: TextStyle(color: Colors.grey),
                ),
                trailing:
                    const Icon(Icons.chevron_right, color: Color(0xFF33724B)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FirstAidDetailsScreen(
                        title: tutorial["title"]!,
                        videoId: tutorial["videoId"],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF33724B),
        onPressed: () {},
        icon: const Icon(Icons.explore, color: Colors.white),
        label: const Text(
          "Explore More",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
