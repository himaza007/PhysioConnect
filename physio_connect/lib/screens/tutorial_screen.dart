import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TutorialScreen extends StatefulWidget {
  @override
  _TutorialScreenState createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  final List<Map<String, String>> _tutorials = [
    {
      "title": "Shoulder Mobility Exercise",
      "videoId": "dQw4w9WgXcQ", // Replace with actual YouTube Video ID
      "instructions":
          "Stand straight and raise your arms in a circular motion. Hold for 10 seconds."
    },
    {
      "title": "Lower Back Stretch",
      "videoId": "9PXYGBdMsa4", // Replace with actual YouTube Video ID
      "instructions":
          "Sit on the floor, reach forward to touch your toes. Hold for 15 seconds."
    }
  ];

  void _showTutorialDialog(Map<String, String> tutorial) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: tutorial["videoId"]!,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            tutorial["title"]!,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              YoutubePlayer(controller: _controller),
              SizedBox(height: 10),
              Text(
                tutorial["instructions"]!,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _controller.pause();
                Navigator.pop(context);
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kinesiology Tutorials")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _tutorials.length,
          itemBuilder: (context, index) {
            final tutorial = _tutorials[index];
            return GestureDetector(
              onTap: () => _showTutorialDialog(tutorial),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  contentPadding: EdgeInsets.all(12),
                  leading:
                      Icon(Icons.play_circle_fill, color: Colors.red, size: 40),
                  title: Text(
                    tutorial["title"]!,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("Tap to watch tutorial",
                      style: TextStyle(color: Colors.grey)),
                  trailing: Icon(Icons.chevron_right, color: Colors.black),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
