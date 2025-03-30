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

  // User login state
  bool _isLoggedIn = false;
  String _userName = "Azeez";

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
              _isLoggedIn
                  ? _showProfileDialog(context)
                  : _showLoginDialog(context);
            },
            tooltip: _isLoggedIn ? 'Profile' : 'Login',
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
                          _isLoggedIn
                              ? 'Welcome back, ${_userName.split(" ")[0]}!'
                              : 'Welcome!',
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

  // Login Dialog
  void _showLoginDialog(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

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
                'Login',
                style: TextStyle(
                  color: Colors.green.shade800,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.green.shade100,
                      child: Icon(
                        Icons.lock_outline,
                        size: 40,
                        color: Colors.green.shade700,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your email',
                        prefixIcon:
                            Icon(Icons.email, color: Colors.green.shade600),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Colors.green.shade600, width: 2),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        prefixIcon:
                            Icon(Icons.lock, color: Colors.green.shade600),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Colors.green.shade600, width: 2),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // Show forgot password dialog
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Password reset email sent!'),
                              backgroundColor: Colors.green.shade700,
                            ),
                          );
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.green.shade700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    // Navigate to registration screen
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Registration form will appear here'),
                        backgroundColor: Colors.green.shade700,
                      ),
                    );
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.green.shade700,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Perform login
                    Navigator.pop(context);
                    setState(() {
                      _isLoggedIn = true;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Successfully logged in!'),
                        backgroundColor: Colors.green.shade700,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Login'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Enhanced Profile Dialog
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
              content: SingleChildScrollView(
                child: Column(
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
                      _userName,
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
                    Divider(height: 25),
                    _buildProfileOption(
                      icon: Icons.calendar_today,
                      title: 'My Bookings',
                      onTap: () {
                        Navigator.pop(context);
                        _showBookingsDialog(context);
                      },
                    ),
                    _buildProfileOption(
                      icon: Icons.add_circle_outline,
                      title: 'Book New Appointment',
                      onTap: () {
                        Navigator.pop(context);
                        _showAvailableTimeslotsDialog(context);
                      },
                    ),
                    _buildProfileOption(
                      icon: Icons.settings,
                      title: 'Edit Profile',
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    _buildProfileOption(
                      icon: Icons.logout,
                      title: 'Logout',
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          _isLoggedIn = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Successfully logged out'),
                            backgroundColor: Colors.green.shade700,
                          ),
                        );
                      },
                    ),
                  ],
                ),
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
              ],
            ),
          ),
        );
      },
    );
  }

  // Helper widget for profile options
  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.green.shade700),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      tileColor: Colors.transparent,
      hoverColor: Colors.green.shade50,
    );
  }

  // Show bookings dialog
  void _showBookingsDialog(BuildContext context) {
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
                'My Bookings',
                style: TextStyle(
                  color: Colors.green.shade800,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Container(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildBookingCard(
                      therapistName: 'Dr. Sarah Johnson',
                      specialty: 'Physical Therapist',
                      date: 'Tomorrow',
                      time: '10:00 AM',
                      isUpcoming: true,
                    ),
                    SizedBox(height: 10),
                    _buildBookingCard(
                      therapistName: 'Dr. Michael Chen',
                      specialty: 'Sports Medicine',
                      date: 'March 25, 2025',
                      time: '2:30 PM',
                      isUpcoming: true,
                    ),
                    SizedBox(height: 10),
                    _buildBookingCard(
                      therapistName: 'Dr. Emily Rivera',
                      specialty: 'Rehabilitation Specialist',
                      date: 'March 15, 2025',
                      time: '11:15 AM',
                      isUpcoming: false,
                    ),
                  ],
                ),
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
              ],
            ),
          ),
        );
      },
    );
  }

  // Helper widget for booking cards
  Widget _buildBookingCard({
    required String therapistName,
    required String specialty,
    required String date,
    required String time,
    required bool isUpcoming,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: isUpcoming ? Colors.green.shade200 : Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor:
                      isUpcoming ? Colors.green.shade100 : Colors.grey.shade200,
                  child: Icon(
                    Icons.person,
                    color: isUpcoming
                        ? Colors.green.shade700
                        : Colors.grey.shade700,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        therapistName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        specialty,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isUpcoming
                        ? Colors.green.shade100
                        : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isUpcoming ? 'Upcoming' : 'Past',
                    style: TextStyle(
                      color: isUpcoming
                          ? Colors.green.shade800
                          : Colors.grey.shade700,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.calendar_today,
                    size: 16, color: Colors.grey.shade600),
                SizedBox(width: 5),
                Text(
                  date,
                  style: TextStyle(
                    color: Colors.grey.shade800,
                  ),
                ),
                SizedBox(width: 15),
                Icon(Icons.access_time, size: 16, color: Colors.grey.shade600),
                SizedBox(width: 5),
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
            if (isUpcoming) ...[
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Appointment rescheduled'),
                          backgroundColor: Colors.blue.shade600,
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      side: BorderSide(color: Colors.blue.shade600),
                    ),
                    child: Text(
                      'Reschedule',
                      style: TextStyle(
                        color: Colors.blue.shade600,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Appointment cancelled'),
                          backgroundColor: Colors.red.shade600,
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      side: BorderSide(color: Colors.red.shade600),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.red.shade600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Show available time slots dialog
  void _showAvailableTimeslotsDialog(BuildContext context) {
    final List<String> therapists = [
      'Dr. Sarah Johnson',
      'Dr. Michael Chen',
      'Dr. Emily Rivera',
      'Dr. James Wilson',
      'Dr. Maria Rodriguez'
    ];
    String selectedTherapist = therapists[0];

    // Create a date range for the next 7 days
    final List<DateTime> dates = List.generate(
        7, (index) => DateTime.now().add(Duration(days: index + 1)));
    DateTime selectedDate = dates[0];

    // Available time slots
    final List<String> morningSlots = ['9:00 AM', '10:00 AM', '11:00 AM'];
    final List<String> afternoonSlots = [
      '1:00 PM',
      '2:00 PM',
      '3:00 PM',
      '4:00 PM'
    ];
    String? selectedTimeSlot;

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

        return StatefulBuilder(builder: (context, setState) {
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
                  'Book New Appointment',
                  style: TextStyle(
                    color: Colors.green.shade800,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: Container(
                  width: double.maxFinite,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select Therapist',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade800,
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.green.shade200),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: selectedTherapist,
                              items: therapists.map((String therapist) {
                                return DropdownMenuItem<String>(
                                  value: therapist,
                                  child: Text(therapist),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    selectedTherapist = newValue;
                                    selectedTimeSlot =
                                        null; // Reset time slot when therapist changes
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Select Date',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade800,
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          height: 80,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: dates.length,
                            itemBuilder: (context, index) {
                              final date = dates[index];
                              final isSelected = date.day == selectedDate.day &&
                                  date.month == selectedDate.month;

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedDate = date;
                                    selectedTimeSlot =
                                        null; // Reset time slot when date changes
                                  });
                                },
                                child: Container(
                                  width: 60,
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? Colors.green.shade600
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: isSelected
                                          ? Colors.green.shade600
                                          : Colors.green.shade200,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        [
                                          'Mon',
                                          'Tue',
                                          'Wed',
                                          'Thu',
                                          'Fri',
                                          'Sat',
                                          'Sun'
                                        ][date.weekday - 1],
                                        style: TextStyle(
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.grey.shade800,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        date.day.toString(),
                                        style: TextStyle(
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.grey.shade800,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        [
                                          'Jan',
                                          'Feb',
                                          'Mar',
                                          'Apr',
                                          'May',
                                          'Jun',
                                          'Jul',
                                          'Aug',
                                          'Sep',
                                          'Oct',
                                          'Nov',
                                          'Dec'
                                        ][date.month - 1],
                                        style: TextStyle(
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.grey.shade800,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Select Time',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade800,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Morning',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(height: 5),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: morningSlots.map((time) {
                            final isSelected = selectedTimeSlot == time;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedTimeSlot = time;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 8),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.green.shade600
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: isSelected
                                        ? Colors.green.shade600
                                        : Colors.green.shade200,
                                  ),
                                ),
                                child: Text(
                                  time,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.grey.shade800,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 15),
                        Text(
                          'Afternoon',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(height: 5),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: afternoonSlots.map((time) {
                            final isSelected = selectedTimeSlot == time;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedTimeSlot = time;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 8),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.green.shade600
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: isSelected
                                        ? Colors.green.shade600
                                        : Colors.green.shade200,
                                  ),
                                ),
                                child: Text(
                                  time,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.grey.shade800,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Appointment Type',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade800,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: _buildAppointmentTypeCard(
                                icon: Icons.videocam,
                                title: 'Video Session',
                                isSelected: true,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: _buildAppointmentTypeCard(
                                icon: Icons.person,
                                title: 'In-Person',
                                isSelected: false,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: selectedTimeSlot == null
                        ? null
                        : () {
                            Navigator.pop(context);
                            HapticFeedback.mediumImpact();

                            // Format the date for display
                            final String formattedDate =
                                '${selectedDate.day} ${[
                              'Jan',
                              'Feb',
                              'Mar',
                              'Apr',
                              'May',
                              'Jun',
                              'Jul',
                              'Aug',
                              'Sep',
                              'Oct',
                              'Nov',
                              'Dec'
                            ][selectedDate.month - 1]}, ${selectedDate.year}';

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Appointment booked with $selectedTherapist on $formattedDate at $selectedTimeSlot'),
                                backgroundColor: Colors.green.shade700,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade600,
                      disabledBackgroundColor: Colors.grey.shade300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('Book Appointment'),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

// Helper widget for appointment type selection
  Widget _buildAppointmentTypeCard({
    required IconData icon,
    required String title,
    required bool isSelected,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
        color: isSelected ? Colors.green.shade50 : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isSelected ? Colors.green.shade600 : Colors.grey.shade300,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.green.shade600 : Colors.grey.shade600,
            size: 24,
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.green.shade800 : Colors.grey.shade800,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
