import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/appointment.dart';
import '../widgets/call_control_button.dart';
import 'support_chat_screen.dart';

class VideoConsultationScreen extends StatefulWidget {
  const VideoConsultationScreen({Key? key}) : super(key: key);

  @override
  _VideoConsultationScreenState createState() =>
      _VideoConsultationScreenState();
}

class _VideoConsultationScreenState extends State<VideoConsultationScreen> {
  bool isPreviewActive = true;

  final List<Map<String, dynamic>> upcomingAppointments = [
    {
      'therapistName': 'Dr. John Doe',
      'specialty': 'Sports Injury',
      'date': DateTime.now().add(Duration(days: 1)),
      'time': '10:00',
      'image': 'assets/img/therapist1.jpg',
    },
    {
      'therapistName': 'Dr. Lisa Wilson',
      'specialty': 'Sports Rehabilitation',
      'date': DateTime.now().add(Duration(days: 3)),
      'time': '14:00',
      'image': 'assets/img/therapist2.jpg',
    },
    {
      'therapistName': 'Dr. Emily Johnson',
      'specialty': 'Pediatric',
      'date': DateTime.now().add(Duration(days: 5)),
      'time': '11:00',
      'image': 'assets/img/therapist3.jpg',
    },
  ];

  void _togglePreviewScreen(bool active) {
    setState(() {
      isPreviewActive = active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Consultation'),
        backgroundColor: Colors.green.shade700,
      ),
      body: isPreviewActive ? _buildPreviewScreen(context) : _buildCallScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SupportChatScreen()),
          );
        },
        backgroundColor: Colors.green.shade700,
        child: Icon(Icons.support_agent),
        tooltip: 'Contact Support',
      ),
    );
  }

  Widget _buildPreviewScreen(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Camera preview section
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          width: double.infinity,
          color: Colors.black87,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Mock camera preview
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  color: Colors.grey.shade800,
                  child: Center(
                    child: Icon(
                      Icons.person,
                      size: 120,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ),
              // Controls overlay
              Positioned(
                bottom: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 24,
                      child: IconButton(
                        icon: Icon(Icons.videocam_off, color: Colors.white),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: 24),
                    CircleAvatar(
                      backgroundColor: Colors.grey.shade700,
                      radius: 24,
                      child: IconButton(
                        icon: Icon(Icons.flip_camera_ios, color: Colors.white),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: 24),
                    CircleAvatar(
                      backgroundColor: Colors.grey.shade700,
                      radius: 24,
                      child: IconButton(
                        icon: Icon(Icons.mic_off, color: Colors.white),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Upcoming appointments section
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Upcoming Appointments',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: upcomingAppointments.length,
            itemBuilder: (context, index) {
              final appointment = upcomingAppointments[index];
              final formattedDate =
                  DateFormat('EEEE, MMMM d, yyyy').format(appointment['date']);

              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(appointment['image']),
                  ),
                  title: Text(appointment['therapistName']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(appointment['specialty']),
                      Text('$formattedDate at ${appointment['time']}'),
                    ],
                  ),
                  trailing: ElevatedButton(
                    onPressed: () => _togglePreviewScreen(false),
                    child: Text('Join'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade600,
                    ),
                  ),
                  contentPadding: EdgeInsets.all(16),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCallScreen() {
    return Stack(
      children: [
        // Full screen "other person" video
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black87,
          child: Center(
            child: Icon(
              Icons.person,
              size: 150,
              color: Colors.white38,
            ),
          ),
        ),

        // Self video small overlay
        Positioned(
          top: 16,
          right: 16,
          child: Container(
            width: 120,
            height: 180,
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(
                Icons.person,
                size: 60,
                color: Colors.white70,
              ),
            ),
          ),
        ),

        // Call controls
        Positioned(
          bottom: 40,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCallControlButton(Icons.videocam_off, Colors.grey.shade800),
              _buildCallControlButton(Icons.mic_off, Colors.grey.shade800),
              _buildCallControlButton(Icons.chat, Colors.grey.shade800),
              _buildCallControlButton(Icons.call_end, Colors.red,
                  onPressed: () => _togglePreviewScreen(true)),
            ],
          ),
        ),

        // Session time and info
        Positioned(
          top: 16,
          left: 16,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(Icons.timer, color: Colors.white, size: 16),
                SizedBox(width: 4),
                Text(
                  '00:15:32',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCallControlButton(IconData icon, Color color,
      {VoidCallback? onPressed}) {
    return CircleAvatar(
      backgroundColor: color,
      radius: 28,
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: onPressed ?? () {},
      ),
    );
  }
}
