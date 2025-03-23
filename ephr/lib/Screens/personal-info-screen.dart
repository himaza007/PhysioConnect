import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Account info screen will be the next screen in the patient registration flow
import 'account_info_screen.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({Key? key}) : super(key: key);

  @override
  _PersonalInfoScreenState createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _nationalIdController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _landlineController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressStreetController =
      TextEditingController();
  final TextEditingController _addressCityController = TextEditingController();
  final TextEditingController _addressStateController = TextEditingController();
  final TextEditingController _addressPostalController =
      TextEditingController();
  final TextEditingController _emergencyNameController =
      TextEditingController();
  final TextEditingController _emergencyRelationshipController =
      TextEditingController();
  final TextEditingController _emergencyPhoneController =
      TextEditingController();

  // Selected date of birth & gender
  DateTime _selectedDate = DateTime.now();
  String _selectedGender = '';

  // List of gender options
  final List<String> _genderOptions = ['Male', 'Female', 'Other'];

  @override
  void dispose() {
    // Clean up controllers when widget is disposed
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _nationalIdController.dispose();
    _mobileNumberController.dispose();
    _landlineController.dispose();
    _emailController.dispose();
    _addressStreetController.dispose();
    _addressCityController.dispose();
    _addressStateController.dispose();
    _addressPostalController.dispose();
    _emergencyNameController.dispose();
    _emergencyRelationshipController.dispose();
    _emergencyPhoneController.dispose();
    super.dispose();
  }

  // Show date picker when user taps on the date field
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF4CAF50), // Main green color
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Save personal info and navigate to next screen
  void _saveAndContinue() {
    if (_formKey.currentState!.validate()) {
      // Save personal information to a data model or shared preference
      final personalInfo = {
        'firstName': _firstNameController.text,
        'middleName': _middleNameController.text,
        'lastName': _lastNameController.text,
        'dateOfBirth': DateFormat('yyyy-MM-dd').format(_selectedDate),
        'gender': _selectedGender,
        'nationalId': _nationalIdController.text,
        'mobileNumber': _mobileNumberController.text,
        'landlineNumber': _landlineController.text,
        'email': _emailController.text,
        'addressStreet': _addressStreetController.text,
        'addressCity': _addressCityController.text,
        'addressState': _addressStateController.text,
        'addressPostal': _addressPostalController.text,
        'emergencyName': _emergencyNameController.text,
        'emergencyRelationship': _emergencyRelationshipController.text,
        'emergencyPhone': _emergencyPhoneController.text,
      };

      // Print for debugging
      print('Personal Info: $personalInfo');

      // Save to local storage or state management solution
      // e.g., using shared_preferences, hive, or provider

      // Navigate to next screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AccountInfoScreen(personalInfo: personalInfo),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CAF50),
        elevation: 0,
        title: const Text(
          'PhysioConnect',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header section
                  Center(
                    child: Column(
                      children: [
                        const Text(
                          'Personal Information',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E7D32),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F5E9),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Step 1 of 7',
                            style: TextStyle(
                              color: Color(0xFF2E7D32),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Name section
                  _buildSectionTitle('Name'),
                  _buildTextFormField(
                    controller: _firstNameController,
                    label: 'First Name',
                    hint: 'Enter your first name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                  ),
                  _buildTextFormField(
                    controller: _middleNameController,
                    label: 'Middle Name (Optional)',
                    hint: 'Enter your middle name',
                    validator: null,
                  ),
                  _buildTextFormField(
                    controller: _lastNameController,
                    label: 'Last Name',
                    hint: 'Enter your last name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // Personal details section
                  _buildSectionTitle('Personal Details'),
                  // Date of Birth Field
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Date of Birth',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () => _selectDate(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 15,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateFormat('dd/MM/yyyy').format(_selectedDate),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              const Icon(
                                Icons.calendar_today,
                                color: Color(0xFF4CAF50),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  // Gender Dropdown
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Gender',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButtonFormField<String>(
                          value:
                              _selectedGender.isEmpty ? null : _selectedGender,
                          hint: const Text('Select your gender'),
                          isExpanded: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Color(0xFF4CAF50),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select your gender';
                            }
                            return null;
                          },
                          items:
                              _genderOptions.map((String gender) {
                                return DropdownMenuItem<String>(
                                  value: gender,
                                  child: Text(gender),
                                );
                              }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              _selectedGender = newValue!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),

                  _buildTextFormField(
                    controller: _nationalIdController,
                    label: 'National ID / Passport Number',
                    hint: 'Enter your ID number',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your ID number';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // Contact information section
                  _buildSectionTitle('Contact Information'),
                  _buildTextFormField(
                    controller: _mobileNumberController,
                    label: 'Mobile Number',
                    hint: 'Enter your mobile number',
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your mobile number';
                      }
                      return null;
                    },
                  ),
                  _buildTextFormField(
                    controller: _landlineController,
                    label: 'Landline (Optional)',
                    hint: 'Enter your landline number',
                    keyboardType: TextInputType.phone,
                    validator: null,
                  ),
                  _buildTextFormField(
                    controller: _emailController,
                    label: 'Email Address',
                    hint: 'Enter your email address',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email address';
                      } else if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // Address section
                  _buildSectionTitle('Address'),
                  _buildTextFormField(
                    controller: _addressStreetController,
                    label: 'Street Address',
                    hint: 'Enter your street address',
                    maxLines: 2,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your street address';
                      }
                      return null;
                    },
                  ),
                  _buildTextFormField(
                    controller: _addressCityController,
                    label: 'City',
                    hint: 'Enter your city',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your city';
                      }
                      return null;
                    },
                  ),
                  _buildTextFormField(
                    controller: _addressStateController,
                    label: 'State/Province',
                    hint: 'Enter your state or province',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your state or province';
                      }
                      return null;
                    },
                  ),
                  _buildTextFormField(
                    controller: _addressPostalController,
                    label: 'Postal Code',
                    hint: 'Enter your postal code',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your postal code';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // Emergency contact section
                  _buildSectionTitle('Emergency Contact'),
                  _buildTextFormField(
                    controller: _emergencyNameController,
                    label: 'Name',
                    hint: 'Enter emergency contact name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter emergency contact name';
                      }
                      return null;
                    },
                  ),
                  _buildTextFormField(
                    controller: _emergencyRelationshipController,
                    label: 'Relationship',
                    hint: 'Enter your relationship',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your relationship';
                      }
                      return null;
                    },
                  ),
                  _buildTextFormField(
                    controller: _emergencyPhoneController,
                    label: 'Phone Number',
                    hint: 'Enter emergency contact number',
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter emergency contact number';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 30),

                  // Save & Continue button
                  Center(
                    child: ElevatedButton(
                      onPressed: _saveAndContinue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4CAF50),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Save & Continue',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build consistent section titles
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E7D32),
            ),
          ),
          const SizedBox(height: 5),
          Container(
            height: 3,
            width: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build consistent text form fields
  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF2E7D32),
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.shade400),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Color(0xFF4CAF50),
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.red.shade300),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.red.shade300, width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 15,
              ),
            ),
            keyboardType: keyboardType,
            maxLines: maxLines,
            validator: validator,
          ),
        ],
      ),
    );
  }
}
