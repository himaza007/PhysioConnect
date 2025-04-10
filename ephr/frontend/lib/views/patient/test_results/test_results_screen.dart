import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/theme.dart';
import '../../../config/routes.dart';
import '../../../services/auth_service.dart';
import '../../../services/ephr_service.dart';
import '../../../services/storage_service.dart';
import '../../../widgets/app_bar.dart';
import '../../../widgets/navigation_drawer.dart';
import '../../../widgets/ephr_card.dart';

/// Test Results Screen
/// Displays list of test results and medical reports
/// Allows viewing and managing documents like X-rays, MRIs, blood tests, etc.

class TestResultsScreen extends StatefulWidget {
  const TestResultsScreen({Key? key}) : super(key: key);

  @override
  State<TestResultsScreen> createState() => _TestResultsScreenState();
}

class _TestResultsScreenState extends State<TestResultsScreen> {
  bool _isLoading = true;
  List<Map<String, dynamic>> _testResults = [];
  String? _error;
  String _searchQuery = '';
  String? _selectedCategory;
  
  @override
  void initState() {
    super.initState();
    _loadTestResults();
  }
  
  /// Load test results from API
  Future<void> _loadTestResults() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    
    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      final storageService = Provider.of<StorageService>(context, listen: false);
      
      // Set auth token
      storageService.setAuthToken(authService.authToken ?? '');
      
      // In a real app, these would come from API calls
      // For now, using mock data
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock test results
      _testResults = [
        {
          'id': '1',
          'title': 'Lumbar Spine MRI',
          'type': 'Imaging',
          'category': 'MRI',
          'date': DateTime.now().subtract(const Duration(days: 14)),
          'providerName': 'City General Hospital',
          'providerType': 'Hospital',
          'orderedBy': 'Dr. Michael Chen',
          'summary': 'Mild disc herniation at L4-L5 level. No nerve compression observed.',
          'documentUrl': 'https://example.com/documents/mri_report.pdf',
          'isImportant': true,
        },
        {
          'id': '2',
          'title': 'Complete Blood Count (CBC)',
          'type': 'Laboratory',
          'category': 'Blood Test',
          'date': DateTime.now().subtract(const Duration(days: 30)),
          'providerName': 'LifeLabs Medical Laboratory',
          'providerType': 'Laboratory',
          'orderedBy': 'Dr. Sarah Johnson',
          'summary': 'All values within normal range. No abnormalities detected.',
          'documentUrl': 'https://example.com/documents/cbc_results.pdf',
          'isImportant': false,
        },
        {
          'id': '3',
          'title': 'X-Ray Right Knee',
          'type': 'Imaging',
          'category': 'X-Ray',
          'date': DateTime.now().subtract(const Duration(days: 60)),
          'providerName': 'Ortho Imaging Center',
          'providerType': 'Imaging Center',
          'orderedBy': 'Dr. Sarah Johnson',
          'summary': 'No fracture or dislocation. Mild joint space narrowing consistent with early osteoarthritis.',
          'documentUrl': 'https://example.com/documents/knee_xray.pdf',
          'isImportant': false,
        },
        {
          'id': '4',
          'title': 'Vitamin D Level',
          'type': 'Laboratory',
          'category': 'Blood Test',
          'date': DateTime.now().subtract(const Duration(days: 90)),
          'providerName': 'LifeLabs Medical Laboratory',
          'providerType': 'Laboratory',
          'orderedBy': 'Dr. Sarah Johnson',
          'summary': 'Vitamin D level slightly below normal range. Supplementation recommended.',
          'documentUrl': 'https://example.com/documents/vitamin_d.pdf',
          'isImportant': true,
        },
        {
          'id': '5',
          'title': 'Physical Therapy Initial Assessment',
          'type': 'Assessment',
          'category': 'Evaluation',
          'date': DateTime.now().subtract(const Duration(days: 45)),
          'providerName': 'City Physiotherapy Clinic',
          'providerType': 'Clinic',
          'orderedBy': 'Dr. Sarah Johnson',
          'summary': 'Comprehensive evaluation of lower back pain. Treatment plan created for 8 weeks of therapy.',
          'documentUrl': 'https://example.com/documents/pt_assessment.pdf',
          'isImportant': true,
        },
      ];
      
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = e.toString();
      });
      
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading test results: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
  
  /// Get unique categories from test results
  List<String> _getCategories() {
    final categories = _testResults.map((result) => result['category'] as String).toSet().toList();
    categories.sort();
    return categories;
  }
  
  /// Get filtered test results based on search and category filters
  List<Map<String, dynamic>> _getFilteredResults() {
    return _testResults.where((result) {
      // Apply search filter
      final title = result['title'].toString().toLowerCase();
      final type = result['type'].toString().toLowerCase();
      final category = result['category'].toString().toLowerCase();
      final provider = result['providerName'].toString().toLowerCase();
      final summary = result['summary'].toString().toLowerCase();
      
      final searchLower = _searchQuery.toLowerCase();
      final matchesSearch = searchLower.isEmpty || 
          title.contains(searchLower) ||
          type.contains(searchLower) ||
          category.contains(searchLower) ||
          provider.contains(searchLower) ||
          summary.contains(searchLower);
      
      // Apply category filter
      final matchesCategory = _selectedCategory == null || 
          result['category'] == _selectedCategory;
      
      return matchesSearch && matchesCategory;
    }).toList();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EPHRAppBar(
        title: 'Test Results & Reports',
      ),
      drawer: NavigationDrawer(currentRoute: AppRoutes.testResults),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.uploadDocument)
              .then((_) => _loadTestResults());
        },
        backgroundColor: AppTheme.midnightTeal,
        child: const Icon(Icons.upload_file),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppTheme.midnightTeal),
              ),
            )
          : _error != null
              ? _buildErrorView()
              : _testResults.isEmpty
                  ? _buildEmptyView()
                  : _buildTestResultsList(),
    );
  }
  
  /// Build the error view
  Widget _buildErrorView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            'Error: $_error',
            style: const TextStyle(
              color: Colors.red,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _loadTestResults,
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }
  
  /// Build empty view
  Widget _buildEmptyView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.description,
            color: Colors.grey[400],
            size: 80,
          ),
          const SizedBox(height: 16),