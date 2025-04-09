import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

/// Login screen for user authentication
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers for the text fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // State variables
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    // Clean up controllers when widget is disposed
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Handle login button press
  void _handleLogin() {
    // Reset error messages
    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    // Validate form
    if (_formKey.currentState!.validate()) {
      // Show loading indicator
      setState(() {
        _isLoading = true;
      });

      // Simulate a network request with a delay
      Future.delayed(const Duration(seconds: 2), () {
        // For demo purposes, hardcode a successful login
        // In a real app, this would make an API call to a backend

        setState(() {
          _isLoading = false;
        });

        // Navigate to home screen
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, '/home');
      });
    }
  }

  // Email validation
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  // Password validation
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.aliceBlue,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // App logo or icon placeholder
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppTheme.midnightTeal,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.medical_services_outlined,
                      color: AppTheme.white,
                      size: 60,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // App name
                  Text(
                    'Healthcare App',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(height: 8),

                  // Tagline
                  Text(
                    'Manage your patients with ease',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 48),

                  // Email field
                  CustomTextField(
                    label: 'Email',
                    hint: 'Enter your email',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.email_outlined,
                    errorText: _emailError,
                    validator: _validateEmail,
                  ),
                  const SizedBox(height: 24),

                  // Password field
                  CustomTextField(
                    label: 'Password',
                    hint: 'Enter your password',
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    prefixIcon: Icons.lock_outline,
                    errorText: _passwordError,
                    validator: _validatePassword,
                  suffixIcon: _isPasswordVisible
                      ? Icon(Icons.visibility_off_outlined)
                      : Icon(Icons.visibility_outlined),

                    onSuffixIconPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  const SizedBox(height: 12),

                  // Forgot password link
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Would navigate to forgot password screen
                      },
                      child: const Text('Forgot Password?'),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Login button
                  CustomButton(
                    text: 'Login',
                    isLoading: _isLoading,
                    onPressed: _handleLogin,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
