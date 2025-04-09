// File: lib/screens/posture_detection_screen.dart
// Description: Screen for real-time posture detection and feedback
// Author: PhysioConnect Team
// Date: April 9, 2025

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../models/posture_model.dart';
import '../services/posture_detection_service.dart';
import '../services/api_service.dart'; // Added import for ApiService
import '../widgets/camera_overlay_widget.dart';
import '../widgets/posture_feedback_widget.dart';
import '../config/app_colors.dart';
import '../config/app_config.dart';

/// PostureDetectionScreen provides real-time posture analysis
class PostureDetectionScreen extends StatefulWidget {
  const PostureDetectionScreen({Key? key}) : super(key: key);

  @override
  State<PostureDetectionScreen> createState() => _PostureDetectionScreenState();
}

class _PostureDetectionScreenState extends State<PostureDetectionScreen> with WidgetsBindingObserver {
  // Services
  late final PostureDetectionService _postureService;
  
  // State
  bool _isCameraInitialized = false;
  bool _isCameraPermissionGranted = false;
  PostureSkeleton? _currentSkeleton;
  List<PostureIssue> _currentIssues = [];
  double _overallScore = 100.0;
  bool _showFeedback = false;
  bool _showGuides = true;
  Size _previewSize = const Size(1, 1);
  
  // Stream subscriptions
  late StreamSubscription<PostureSkeleton> _skeletonSubscription;
  late StreamSubscription<List<PostureIssue>> _issuesSubscription;
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    
    // Initialize services
    _initializeServices();
    
    // Request camera permission
    _requestCameraPermission();
  }
  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Handle app lifecycle changes to manage camera resource
    if (state == AppLifecycleState.inactive) {
      _postureService.stopDetection();
    } else if (state == AppLifecycleState.resumed) {
      if (_isCameraPermissionGranted) {
        _postureService.startDetection();
      }
    }
  }
  
  /// Initialize the posture detection service
  Future<void> _initializeServices() async {
    // Create ApiService instance first
    final apiService = ApiService();
    
    // Initialize PostureDetectionService with apiService
    _postureService = PostureDetectionService(
      apiService: apiService,
    );
    
    // Subscribe to skeleton updates
    _skeletonSubscription = _postureService.skeletonStream.listen((skeleton) {
      setState(() {
        _currentSkeleton = skeleton;
        
        // Update preview size first time we get a skeleton
        if (_previewSize == const Size(1, 1)) {
          _updatePreviewSize();
        }
      });
    });
    
    // Subscribe to posture issues
    _issuesSubscription = _postureService.issuesStream.listen((issues) {
      setState(() {
        _currentIssues = issues;
        
        // Calculate overall score based on issues
        _calculateOverallScore();
      });
    });
  }
  
  /// Request camera permission
  Future<void> _requestCameraPermission() async {
    try {
      await _postureService.initializeCamera();
      setState(() {
        _isCameraPermissionGranted = true;
        _isCameraInitialized = true;
      });
      
      // Start detection after camera is initialized
      _postureService.startDetection();
    } catch (e) {
      setState(() {
        _isCameraPermissionGranted = false;
        _isCameraInitialized = false;
      });
      
      // Show permission error dialog
      _showPermissionErrorDialog();
    }
  }
  
  /// Show error dialog for camera permission
  void _showPermissionErrorDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Camera Permission Required'),
        content: const Text(
          'PhysioConnect needs camera access to analyze your posture. '
          'Please grant camera permission in your device settings.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _requestCameraPermission();
            },
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }
  
  /// Update the preview size to match the camera preview
  void _updatePreviewSize() {
    if (_postureService.isRunning && _currentSkeleton != null) {
      // Find the extreme points from the skeleton to estimate the preview size
      double minX = double.infinity;
      double minY = double.infinity;
      double maxX = 0;
      double maxY = 0;
      
      for (final point in _currentSkeleton!.points) {
        if (point.x < minX) minX = point.x;
        if (point.y < minY) minY = point.y;
        if (point.x > maxX) maxX = point.x;
        if (point.y > maxY) maxY = point.y;
      }
      
      // Calculate size with a safety margin
      _previewSize = Size(maxX * 1.2, maxY * 1.2);
    }
  }
  
  /// Calculate overall posture score based on issues
  void _calculateOverallScore() {
    if (_currentIssues.isEmpty) {
      _overallScore = 100.0;
      return;
    }
    
    // Calculate score by subtracting severity percentages
    double totalDeduction = 0;
    for (final issue in _currentIssues) {
      totalDeduction += issue.severity * 40; // Each issue can deduct up to 40 points
    }
    
    // Ensure score is between 0 and 100
    _overallScore = 100 - totalDeduction;
    if (_overallScore < 0) _overallScore = 0;
    if (_overallScore > 100) _overallScore = 100;
  }
  
  /// Toggle feedback panel visibility
  void _toggleFeedback() {
    setState(() {
      _showFeedback = !_showFeedback;
    });
  }
  
  /// Toggle posture guides visibility
  void _toggleGuides() {
    setState(() {
      _showGuides = !_showGuides;
    });
  }
  
  /// Handle exercise selection
  void _onExerciseSelected(String issueId) {
    // Navigate to exercise screen for this issue
    Navigator.pushNamed(
      context,
      '/exercises',
      arguments: {'issueId': issueId},
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        title: const Text(
          'Posture Analysis',
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.midnightTeal,
        elevation: 0,
        actions: [
          // Toggle guides button
          IconButton(
            icon: Icon(
              _showGuides ? Icons.visibility : Icons.visibility_off,
              color: AppColors.white,
            ),
            onPressed: _toggleGuides,
            tooltip: 'Toggle Posture Guides',
          ),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleFeedback,
        backgroundColor: AppColors.midnightTeal,
        child: Icon(
          _showFeedback ? Icons.close : Icons.feedback_outlined,
          color: AppColors.white,
        ),
      ),
    );
  }
  
  /// Build the main body of the screen
  Widget _buildBody() {
    if (!_isCameraPermissionGranted) {
      return _buildPermissionRequest();
    }
    
    if (!_isCameraInitialized) {
      return _buildLoadingIndicator();
    }
    
    return Stack(
      children: [
        // Camera preview
        _buildCameraPreview(),
        
        // Posture overlay
        _buildPostureOverlay(),
        
        // Feedback panel (conditional)
        if (_showFeedback) _buildFeedbackPanel(),
      ],
    );
  }
  
  /// Build the camera permission request widget
  Widget _buildPermissionRequest() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.camera_alt,
            size: 80,
            color: AppColors.midnightTeal,
          ),
          const SizedBox(height: 24),
          const Text(
            'Camera Permission Required',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'PhysioConnect needs camera access to analyze your posture.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: _requestCameraPermission,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.midnightTeal,
              foregroundColor: AppColors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Grant Permission',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  /// Build loading indicator
  Widget _buildLoadingIndicator() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(
            color: AppColors.midnightTeal,
          ),
          SizedBox(height: 16),
          Text(
            'Initializing camera...',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
  
  /// Build camera preview widget
  Widget _buildCameraPreview() {
    return Container(
      color: AppColors.backgroundPrimary,
      child: Center(
        child: AspectRatio(
          aspectRatio: 3 / 4, // Typical portrait aspect ratio
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            // Fixed: Using CameraPreview as a widget, not a method
            child: _postureService.cameraController != null
                ? CameraPreview(_postureService.cameraController!)
                : Container(
                    color: Colors.black,
                    child: const Center(
                      child: Text(
                        'Camera not available',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
  
  /// Build posture overlay widget
  Widget _buildPostureOverlay() {
    if (_currentSkeleton == null) {
      return Container();
    }
    
    return IgnorePointer(
      ignoring: true,
      child: CameraOverlayWidget(
        skeleton: _currentSkeleton,
        issues: _currentIssues,
        cameraPreviewSize: _previewSize,
        showSkeleton: true,
        showJointLabels: false,
        highlightIssues: _showGuides,
        pointSize: 8.0,
        lineWidth: 2.0,
      ),
    );
  }
  
  /// Build feedback panel widget
  Widget _buildFeedbackPanel() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        margin: const EdgeInsets.all(16),
        child: PostureFeedbackWidget(
          issues: _currentIssues,
          overallScore: _overallScore,
          onExerciseSelected: _onExerciseSelected,
          enableHaptic: AppConfig.enableHapticFeedback,
          enableSound: true,
        ),
      ),
    );
  }
  
  @override
  void dispose() {
    // Dispose resources
    _skeletonSubscription.cancel();
    _issuesSubscription.cancel();
    _postureService.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}