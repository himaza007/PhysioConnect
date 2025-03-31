import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

/// Assessment screen for creating and managing patient assessments
class AssessmentScreen extends StatefulWidget {
  const AssessmentScreen({super.key});

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  // Patient selection
  String? _selectedPatientId;

  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final _chiefComplaintController = TextEditingController();
  final _historyController = TextEditingController();
  final _examinationController = TextEditingController();
  final _diagnosisController = TextEditingController();
  final _planController = TextEditingController();

  // Vitals controllers
  final _temperatureController = TextEditingController();
  final _bpSystolicController = TextEditingController();
  final _bpDiastolicController = TextEditingController();
  final _pulseController = TextEditingController();
  final _respirationController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();

  // Dummy patient data
  final List<Map<String, dynamic>> _patients = [
    {'id': '001', 'name': 'John Smith', 'age': 45, 'gender': 'Male'},
    {'id': '002', 'name': 'Emily Wilson', 'age': 42, 'gender': 'Female'},
    {'id': '003', 'name': 'Michael Brown', 'age': 35, 'gender': 'Male'},
    {'id': '004', 'name': 'Jessica Martinez', 'age': 28, 'gender': 'Female'},
    {'id': '005', 'name': 'David Lee', 'age': 67, 'gender': 'Male'},
  ];

  // Pain score
  int _painScore = 0;

  // Assessment date
  DateTime _assessmentDate = DateTime.now();

  // Loading state
  bool _isLoading = false;

  @override
  void dispose() {
    // Dispose controllers
    _chiefComplaintController.dispose();
    _historyController.dispose();
    _examinationController.dispose();
    _diagnosisController.dispose();
    _planController.dispose();
    _temperatureController.dispose();
    _bpSystolicController.dispose();
    _bpDiastolicController.dispose();
    _pulseController.dispose();
    _respirationController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  // Handle saving the assessment
  void _saveAssessment() {
    if (_formKey.currentState!.validate()) {
      // Show loading indicator
      setState(() {
        _isLoading = true;
      });

      // Simulate a network request with a delay
      Future.delayed(const Duration(seconds: 2), () {
        // For demo purposes, just show a success message
        // In a real app, this would send data to a backend

        setState(() {
          _isLoading = false;
        });

        // Show success message
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Assessment saved successfully'),
            backgroundColor: Colors.green,
          ),
        );

        // Reset form
        _resetForm();
      });
    } else {
      // Show error message for validation
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Reset form fields
  void _resetForm() {
    setState(() {
      _selectedPatientId = null;
      _chiefComplaintController.clear();
      _historyController.clear();
      _examinationController.clear();
      _diagnosisController.clear();
      _planController.clear();
      _temperatureController.clear();
      _bpSystolicController.clear();
      _bpDiastolicController.clear();
      _pulseController.clear();
      _respirationController.clear();
      _weightController.clear();
      _heightController.clear();
      _painScore = 0;
      _assessmentDate = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Patient Assessment')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Assessment header card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'New Assessment',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Patient selection dropdown
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Select Patient',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: const Icon(Icons.person_outline),
                        ),
                        value: _selectedPatientId,
                        hint: const Text('Select patient'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a patient';
                          }
                          return null;
                        },
                        items:
                            _patients.map((patient) {
                              return DropdownMenuItem<String>(
                                value: patient['id'].toString(),
                                child: Text(
                                  '${patient['name']} (${patient['age']} yrs, ${patient['gender']})',
                                ),
                              );
                            }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedPatientId = value;
                          });
                        },
                      ),
                      const SizedBox(height: 16),

                      // Date selector
                      InkWell(
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: _assessmentDate,
                            firstDate: DateTime(2020),
                            lastDate: DateTime.now(),
                          );

                          if (date != null) {
                            setState(() {
                              _assessmentDate = date;
                            });
                          }
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppTheme.lightGrey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.calendar_today,
                                color: AppTheme.midnightTeal,
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Assessment Date',
                                    style: TextStyle(
                                      color: AppTheme.textSecondary,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${_assessmentDate.day}/${_assessmentDate.month}/${_assessmentDate.year}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Vitals section
              const Text(
                'Vitals',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          // Temperature
                          Expanded(
                            child: CustomTextField(
                              label: 'Temperature',
                              hint: '98.6',
                              controller: _temperatureController,
                              keyboardType: TextInputType.number,
                              suffixIcon: Icons.thermostat_outlined,
                            ),
                          ),
                          const SizedBox(width: 16),

                          // Blood pressure
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Blood Pressure',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: _bpSystolicController,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          hintText: 'Sys',
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                      child: Text(
                                        '/',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        controller: _bpDiastolicController,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          hintText: 'Dia',
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'mmHg',
                                      style: TextStyle(
                                        color: AppTheme.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      Row(
                        children: [
                          // Pulse
                          Expanded(
                            child: CustomTextField(
                              label: 'Pulse',
                              hint: '72',
                              controller: _pulseController,
                              keyboardType: TextInputType.number,
                              suffixIcon: Icons.favorite_outline,
                            ),
                          ),
                          const SizedBox(width: 16),

                          // Respiration
                          Expanded(
                            child: CustomTextField(
                              label: 'Respiration',
                              hint: '16',
                              controller: _respirationController,
                              keyboardType: TextInputType.number,
                              suffixIcon: Icons.air,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      Row(
                        children: [
                          // Weight
                          Expanded(
                            child: CustomTextField(
                              label: 'Weight (lbs)',
                              hint: '150',
                              controller: _weightController,
                              keyboardType: TextInputType.number,
                              suffixIcon: Icons.monitor_weight_outlined,
                            ),
                          ),
                          const SizedBox(width: 16),

                          // Height
                          Expanded(
                            child: CustomTextField(
                              label: 'Height (in)',
                              hint: '68',
                              controller: _heightController,
                              keyboardType: TextInputType.number,
                              suffixIcon: Icons.height,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Pain scale
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Pain Scale (0-10)',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                _painScore.toString(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Slider(
                                  value: _painScore.toDouble(),
                                  min: 0,
                                  max: 10,
                                  divisions: 10,
                                  activeColor: _getPainColor(_painScore),
                                  label: _painScore.toString(),
                                  onChanged: (value) {
                                    setState(() {
                                      _painScore = value.toInt();
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                _painScore < 4
                                    ? Icons.sentiment_satisfied_outlined
                                    : _painScore < 7
                                    ? Icons.sentiment_neutral_outlined
                                    : Icons
                                        .sentiment_very_dissatisfied_outlined,
                                color: _getPainColor(_painScore),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Assessment details section
              const Text(
                'Assessment Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Chief complaint
                      CustomTextField(
                        label: 'Chief Complaint',
                        hint: 'Enter the primary reason for visit',
                        controller: _chiefComplaintController,
                        maxLines: 2,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Chief complaint is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // History
                      CustomTextField(
                        label: 'History of Present Illness',
                        hint: 'Enter detailed history',
                        controller: _historyController,
                        maxLines: 4,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'History is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Physical examination
                      CustomTextField(
                        label: 'Physical Examination',
                        hint: 'Enter examination findings',
                        controller: _examinationController,
                        maxLines: 4,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Examination details are required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Diagnosis
                      CustomTextField(
                        label: 'Assessment/Diagnosis',
                        hint: 'Enter diagnosis or assessment',
                        controller: _diagnosisController,
                        maxLines: 2,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Diagnosis is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Plan
                      CustomTextField(
                        label: 'Plan',
                        hint: 'Enter treatment plan and recommendations',
                        controller: _planController,
                        maxLines: 4,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Treatment plan is required';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Reset',
                      isOutlined: true,
                      onPressed: _resetForm,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomButton(
                      text: 'Save Assessment',
                      isLoading: _isLoading,
                      onPressed: _saveAssessment,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper to get color based on pain score
  Color _getPainColor(int score) {
    if (score < 4) {
      return Colors.green;
    } else if (score < 7) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}
