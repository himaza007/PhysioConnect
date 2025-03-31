import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/custom_button.dart';

/// Home screen (dashboard) showing key metrics and navigation options
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.aliceBlue,
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          // Profile or settings icon
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () {
              // Would navigate to profile screen
            },
          ),
        ],
      ),

      // Drawer for navigation menu
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Drawer header with user info
            DrawerHeader(
              decoration: const BoxDecoration(color: AppTheme.midnightTeal),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: AppTheme.white,
                    child: Icon(
                      Icons.person,
                      color: AppTheme.midnightTeal,
                      size: 30,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Dr. Sarah Johnson',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppTheme.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'sarah.j@healthcare.com',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      // ignore: deprecated_member_use
                      color: AppTheme.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),

            // Menu items
            _buildDrawerItem(
              context,
              icon: Icons.dashboard_outlined,
              title: 'Dashboard',
              isSelected: true,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            _buildDrawerItem(
              context,
              icon: Icons.people_outline,
              title: 'Patients',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/patients');
              },
            ),
            _buildDrawerItem(
              context,
              icon: Icons.folder_outlined,
              title: 'Medical Records',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/records');
              },
            ),
            _buildDrawerItem(
              context,
              icon: Icons.assessment_outlined,
              title: 'Assessments',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/assessment');
              },
            ),
            _buildDrawerItem(
              context,
              icon: Icons.healing_outlined,
              title: 'Treatment Plans',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/treatment');
              },
            ),
            const Divider(),
            _buildDrawerItem(
              context,
              icon: Icons.settings_outlined,
              title: 'Settings',
              onTap: () {
                // Would navigate to settings
              },
            ),
            _buildDrawerItem(
              context,
              icon: Icons.exit_to_app,
              title: 'Logout',
              onTap: () {
                // Show confirmation dialog
                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: const Text('Logout'),
                        content: const Text('Are you sure you want to logout?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              // Navigate back to login
                              Navigator.pushReplacementNamed(context, '/login');
                            },
                            child: const Text('Logout'),
                          ),
                        ],
                      ),
                );
              },
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome message
            Text(
              'Welcome, Dr. Sarah',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Text(
              'Here\'s your daily overview',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),

            // Summary cards
            Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    context,
                    title: 'Today\'s Appointments',
                    value: '8',
                    icon: Icons.calendar_today,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildSummaryCard(
                    context,
                    title: 'Pending Reports',
                    value: '3',
                    icon: Icons.description_outlined,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    context,
                    title: 'Total Patients',
                    value: '145',
                    icon: Icons.people_outline,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildSummaryCard(
                    context,
                    title: 'New Messages',
                    value: '5',
                    icon: Icons.message_outlined,
                    color: Colors.purple,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Upcoming appointments section
            const Text(
              'Upcoming Appointments',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Appointment list
            _buildAppointmentItem(
              context,
              time: '09:00 AM',
              patientName: 'John Smith',
              reason: 'Follow-up Consultation',
              isNext: true,
            ),
            _buildAppointmentItem(
              context,
              time: '10:30 AM',
              patientName: 'Maria Garcia',
              reason: 'Annual Check-up',
            ),
            _buildAppointmentItem(
              context,
              time: '01:15 PM',
              patientName: 'Robert Johnson',
              reason: 'Blood Test Results',
            ),

            const SizedBox(height: 16),

            // View all button
            Center(
              child: CustomButton(
                text: 'View All Appointments',
                onPressed: () {
                  // Would navigate to appointments list
                },
                isFullWidth: false,
                isOutlined: true,
                icon: Icons.calendar_month_outlined,
              ),
            ),

            const SizedBox(height: 24),

            // Recent patients section
            const Text(
              'Recent Patients',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Patient list
            _buildPatientItem(
              context,
              name: 'Emily Wilson',
              age: 42,
              lastVisit: '2 days ago',
              condition: 'Hypertension',
            ),
            _buildPatientItem(
              context,
              name: 'Michael Brown',
              age: 35,
              lastVisit: '1 week ago',
              condition: 'Diabetes Type 2',
            ),
            _buildPatientItem(
              context,
              name: 'Jessica Martinez',
              age: 28,
              lastVisit: '2 weeks ago',
              condition: 'Pregnancy (2nd trimester)',
            ),

            const SizedBox(height: 16),

            // View all button
            Center(
              child: CustomButton(
                text: 'View All Patients',
                onPressed: () {
                  Navigator.pushNamed(context, '/patients');
                },
                isFullWidth: false,
                isOutlined: true,
                icon: Icons.people_outlined,
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),

      // FAB for quick actions
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.midnightTeal,
        child: const Icon(Icons.add),
        onPressed: () {
          // Show quick action menu
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Wrap(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person_add_outlined),
                    title: const Text('Add New Patient'),
                    onTap: () {
                      Navigator.pop(context);
                      // Would navigate to add patient screen
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.note_add_outlined),
                    title: const Text('Create Medical Record'),
                    onTap: () {
                      Navigator.pop(context);
                      // Would navigate to add record screen
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.calendar_today_outlined),
                    title: const Text('Schedule Appointment'),
                    onTap: () {
                      Navigator.pop(context);
                      // Would navigate to scheduling screen
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  // Helper method to build drawer items
  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isSelected = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? AppTheme.midnightTeal : AppTheme.textPrimary,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? AppTheme.midnightTeal : AppTheme.textPrimary,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      onTap: onTap,
    );
  }

  // Helper method to build summary cards
  Widget _buildSummaryCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 28),
                const Spacer(),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }

  // Helper method to build appointment items
  Widget _buildAppointmentItem(
    BuildContext context, {
    required String time,
    required String patientName,
    required String reason,
    bool isNext = false,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side:
            isNext
                ? const BorderSide(color: AppTheme.midnightTeal, width: 2)
                : BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Time column
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  time,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.midnightTeal,
                  ),
                ),
                if (isNext)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.midnightTeal,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'NEXT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 16),
            // Vertical divider
            Container(
              height: 40,
              width: 1,
              // ignore: deprecated_member_use
              color: Colors.grey.withOpacity(0.3),
            ),
            const SizedBox(width: 16),
            // Patient info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    patientName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(reason, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
            // Action button
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                // Show appointment options
              },
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build patient items
  Widget _buildPatientItem(
    BuildContext context, {
    required String name,
    required int age,
    required String lastVisit,
    required String condition,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 24,
              backgroundColor: AppTheme.aliceBlue,
              child: Text(
                name.substring(0, 1),
                style: const TextStyle(
                  color: AppTheme.midnightTeal,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Patient info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '$age years',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(width: 8),
                      const Text('•'),
                      const SizedBox(width: 8),
                      Text(
                        'Last visit: $lastVisit',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.aliceBlue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      condition,
                      style: const TextStyle(
                        color: AppTheme.midnightTeal,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // View profile button
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios, size: 16),
              onPressed: () {
                // Would navigate to patient details
              },
            ),
          ],
        ),
      ),
    );
  }
}
