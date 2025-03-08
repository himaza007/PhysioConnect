import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_consult/messaging_screen.dart';
import 'package:animations/animations.dart';
import 'dart:math' as math;
import 'therapist_selection_screen.dart';
import 'video_consultation_screen.dart';
import 'emergency_session_screen.dart';
import 'support_chat_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Color> _gradientColors = [
    Colors.green.shade100,
    Colors.green.shade50,
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    // Add haptic feedback when the screen loads
    HapticFeedback.mediumImpact();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.green.withOpacity(0.2),
            ),
          ),
        ),
        title: Row(
          children: [
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: Duration(seconds: 1),
              curve: Curves.elasticOut,
              builder: (context, double value, child) {
                return Transform.scale(
                  scale: value,
                  child: child,
                );
              },
              child: Icon(
                Icons.medical_services,
                color: Colors.green.shade700,
              ),
            ),
            SizedBox(width: 8),
            Text(
              'Physio Connect',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade800,
              ),
            ),
          ],
        ),
        actions: [
          _buildBouncingButton(
            icon: Icons.message,
            onTap: () {
              HapticFeedback.lightImpact();
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      MessagingScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                ),
              );
            },
            tooltip: 'Messages',
          ),
          _buildBouncingButton(
            icon: Icons.person,
            onTap: () {
              HapticFeedback.lightImpact();
              _showProfileDialog(context);
            },
            tooltip: 'Profile',
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: _gradientColors,
                transform: GradientRotation(_controller.value * 2 * math.pi),
              ),
            ),
            child: child,
          );
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 30),
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: Duration(milliseconds: 800),
                  curve: Curves.easeOut,
                  builder: (context, double value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 20 * (1 - value)),
                        child: child,
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.3),
                          blurRadius: 15,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade800,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'How are you feeling today?',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildMoodButton('😊', 'Great'),
                            _buildMoodButton('😐', 'Okay'),
                            _buildMoodButton('😣', 'In Pain'),
                            _buildMoodButton('😞', 'Bad'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildAnimatedMenuButton(
                          title: 'Select Therapist',
                          description: 'Find the right specialist for you',
                          icon: Icons.people,
                          color: Colors.green.shade600,
                          onTap: () => _navigateTo(TherapistSelectionScreen()),
                          delay: 100,
                        ),
                        SizedBox(height: 20),
                        _buildAnimatedMenuButton(
                          title: 'Video Consultation',
                          description: 'Connect with your therapist remotely',
                          icon: Icons.video_call,
                          color: Colors.blue.shade600,
                          onTap: () => _navigateTo(VideoConsultationScreen()),
                          delay: 200,
                        ),
                        SizedBox(height: 20),
                        _buildAnimatedMenuButton(
                          title: 'Emergency Session',
                          description: 'Get immediate assistance',
                          icon: Icons.emergency,
                          color: Colors.red.shade600,
                          onTap: () => _navigateTo(EmergencySessionScreen()),
                          delay: 300,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: 1),
        duration: Duration(milliseconds: 1000),
        curve: Curves.elasticOut,
        builder: (context, double value, child) {
          return Transform.scale(
            scale: value,
            child: child,
          );
        },
        child: FloatingActionButton.extended(
          onPressed: () {
            HapticFeedback.mediumImpact();
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    SupportChatScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return SharedAxisTransition(
                    animation: animation,
                    secondaryAnimation: secondaryAnimation,
                    transitionType: SharedAxisTransitionType.horizontal,
                    child: child,
                  );
                },
              ),
            );
          },
          backgroundColor: Colors.green.shade700,
          icon: Icon(Icons.support_agent),
          label: Text('Support Chat'),
          elevation: 4,
        ),
      ),
    );
  }

  Widget _buildMoodButton(String emoji, String label) {
    return InkWell(
      onTap: () {
        HapticFeedback.lightImpact();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Feeling $label today. Thanks for sharing!'),
            backgroundColor: Colors.green.shade700,
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.green.shade200),
            ),
            child: Text(
              emoji,
              style: TextStyle(fontSize: 24),
            ),
          ),
          SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.green.shade800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBouncingButton({
    required IconData icon,
    required VoidCallback onTap,
    required String tooltip,
  }) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.green.shade800,
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedMenuButton({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    required int delay,
  }) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 800),
      curve: Curves.easeOut,
      // delay: Duration(milliseconds: delay),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(100 * (1 - value), 0),
            child: child,
          ),
        );
      },
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            HapticFeedback.mediumImpact();
            onTap();
          },
          borderRadius: BorderRadius.circular(15),
          splashColor: color.withOpacity(0.1),
          highlightColor: color.withOpacity(0.05),
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color, color.withOpacity(0.8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.4),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _navigateTo(Widget screen) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SharedAxisTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.scaled,
            child: child,
          );
        },
      ),
    );
  }

  void _showProfileDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
      transitionBuilder: (context, animation1, animation2, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation1,
          curve: Curves.easeInOut,
        );

        return ScaleTransition(
          scale: Tween<double>(begin: 0.8, end: 1.0).animate(curvedAnimation),
          child: FadeTransition(
            opacity:
                Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Text(
                'Profile',
                style: TextStyle(
                  color: Colors.green.shade800,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.green.shade100,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.green.shade700,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'John Doe',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Next appointment: Tomorrow, 10:00 AM',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Close',
                    style: TextStyle(
                      color: Colors.green.shade700,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Edit Profile'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
