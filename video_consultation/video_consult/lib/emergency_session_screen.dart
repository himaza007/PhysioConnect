import 'package:flutter/material.dart';
import 'support_chat_screen.dart';

class EmergencySessionScreen extends StatefulWidget {
  @override
  _EmergencySessionScreenState createState() => _EmergencySessionScreenState();
}

class _EmergencySessionScreenState extends State<EmergencySessionScreen> {
  bool isConnecting = true;

  @override
  void initState() {
    super.initState();
    // Simulate connection delay
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          isConnecting = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Session'),
        backgroundColor: Colors.red.shade700,
      ),
      body: isConnecting ? _buildConnectingScreen() : _buildCallScreen(),
      floatingActionButton: isConnecting
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SupportChatScreen()),
                );
              },
              backgroundColor: Colors.green.shade700,
              child: Icon(Icons.support_agent),
              tooltip: 'Contact Support',
            )
          : null,
    );
  }

  Widget _buildConnectingScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.red.shade600),
          ),
          SizedBox(height: 24),
          Text(
            'Connecting to Emergency Therapist...',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Text(
            'Priority connection in progress',
            style: TextStyle(color: Colors.grey.shade700),
          ),
          SizedBox(height: 24),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.red.shade200),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.priority_high,
                  color: Colors.red.shade700,
                  size: 36,
                ),
                SizedBox(height: 8),
                Text(
                  'Emergency Protocol Activated',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade700,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'You will be connected to the next available emergency therapist',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  //   // Existing connecting screen implementation
  //   // ...
  // }

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

        // Emergency indicator
        Positioned(
          top: 16,
          left: 16,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.red.shade600,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(Icons.warning_amber, color: Colors.white, size: 16),
                SizedBox(width: 4),
                Text(
                  'EMERGENCY SESSION',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
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

        // Connected to info
        Positioned(
          top: 70,
          left: 16,
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/img/therapist5.jpg'),
                  radius: 16,
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. Emily Johnson',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'Emergency Specialist',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
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
                  onPressed: () {
                Navigator.of(context).pop();
              }),
            ],
          ),
        ),

        // Session time
        Positioned(
          top: 120,
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
                  '00:02:18',
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

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Video Consultation'),
      backgroundColor: Colors.green.shade700,
    ),
    body: Center(child: Text('Video Consultation Feature Coming Soon...')),
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
