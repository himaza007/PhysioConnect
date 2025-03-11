import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'first_aid_details.dart';

class FirstAidTutorialScreen extends StatefulWidget {
  const FirstAidTutorialScreen({super.key});

  @override
  _FirstAidTutorialScreenState createState() => _FirstAidTutorialScreenState();
}

class _FirstAidTutorialScreenState extends State<FirstAidTutorialScreen> {
  final List<Map<String, String>> _tutorials = [
    {
      "title": "CPR - Chest Compressions",
      "videoId": "dQw4w9WgXcQ",
      "instructions":
          "Place both hands in the center of the chest and press **hard & fast**."
    },
    {
      "title": "How to Stop Severe Bleeding",
      "videoId": "9PXYGBdMsa4",
      "instructions":
          "Apply **firm pressure** with a clean cloth to stop the bleeding."
    },
    {
      "title": "Choking First Aid - Heimlich Maneuver",
      "videoId": "pN1E1-BVP4c",
      "instructions":
          "Perform **quick abdominal thrusts** to help a choking person."
    },
  ];

  void _showTutorialDialog(Map<String, String> tutorial) {
    YoutubePlayerController controller = YoutubePlayerController(
      initialVideoId: tutorial["videoId"] ?? "dQw4w9WgXcQ",
      flags: YoutubePlayerFlags(autoPlay: true, mute: false),
    );

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                child: YoutubePlayer(controller: controller),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      tutorial["title"] ?? "Unknown Title",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.teal),
                    ),
                    SizedBox(height: 10),
                    Text(
                      tutorial["instructions"] ?? "No instructions available.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: ElevatedButton.icon(
                  onPressed: () {
                    controller.pause();
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close, color: Colors.white),
                  label: Text("Close"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _navigateToFirstAidDetails(String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FirstAidDetailsScreen(title: title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      "First Aid Tutorials",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: _tutorials.length,
                itemBuilder: (context, index) {
                  final tutorial = _tutorials[index];
                  return GestureDetector(
                    onTap: () => _showTutorialDialog(tutorial),
                    onLongPress: () =>
                        _navigateToFirstAidDetails(tutorial["title"]!),
                    child: Card(
                      elevation: 5,
                      margin: EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: ListTile(
                        leading: Icon(Icons.play_circle_fill,
                            color: Colors.redAccent, size: 45),
                        title: Text(tutorial["title"]!,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        subtitle: Text("Tap to watch tutorial",
                            style: TextStyle(color: Colors.grey)),
                        trailing: Icon(Icons.info_outline, color: Colors.teal),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
