import 'package:flutter/material.dart'; // Import your model
import 'package:local_government_app/models/verification_results.dart';
import 'package:local_government_app/utils/app_theme.dart';
import 'package:local_government_app/widgets/auth_header.dart';
import 'package:local_government_app/widgets/components/buttons/primary_button.dart';
import 'package:local_government_app/widgets/components/inputfields/custom_text_field.dart';
import 'package:local_government_app/widgets/progress_stepper.dart';

class SignupReviewDetails extends StatefulWidget {
  // 1. Accepting verified data from the previous screen
  final VerificationResult verificationResult;
  final String ghanaCardNumber;

  const SignupReviewDetails({
    super.key,
    required this.verificationResult,
    required this.ghanaCardNumber,
  });

  @override
  State<SignupReviewDetails> createState() => _SignupReviewDetailsState();
}

class _SignupReviewDetailsState extends State<SignupReviewDetails> {
  // Create controllers for all fields
  final _firstNameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 2. Populate the controllers with the data passed to the widget
    _firstNameController.text = widget.verificationResult.firstName ?? '';
    _surnameController.text = widget.verificationResult.lastName ?? '';
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.secondary,
      appBar: AppBar(
        backgroundColor: AppTheme.secondary,
        elevation: 0,
        leading: const BackButton(color: AppTheme.darkGrey),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Using a simple header text for this screen
            const AuthHeader(
              title: 'Review Details',
              subtitle: 'Please confirm your details and complete registration.',
            ),
            const ProgressStepper(currentStep: 2), 
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                decoration: const BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- 3. FORM WITH ALL REQUIRED FIELDS ---
                        _buildSectionHeader('Verified Information'),
                        CustomTextField(
                          controller: _firstNameController,
                          hintText: 'First Name',
                          icon: Icons.person_outline, readOnly: true,
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          controller: _surnameController,
                          hintText: 'Surname',
                          icon: Icons.person_outline,
                           readOnly: true
                        ),
                        const SizedBox(height: 24),
                        _buildSectionHeader('Complete Your Profile'),
                        CustomTextField(
                          controller: _emailController,
                          hintText: 'Email Address',
                          icon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress, readOnly: false
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          controller: _passwordController,
                          hintText: 'Create a Password',
                          icon: Icons.lock_outline,
                          isPassword: true, readOnly: false
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          controller: _phoneController,
                          hintText: 'Phone Number',
                          icon: Icons.phone_outlined,
                          keyboardType: TextInputType.phone, readOnly: false
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          controller: _addressController,
                          hintText: 'Residential Address',
                          icon: Icons.home_outlined,
                          keyboardType: TextInputType.streetAddress, readOnly: false
                        ),
                        const SizedBox(height: 32),

                        // --- 4. FINAL CALL-TO-ACTION BUTTON ---
                        PrimaryButton(
                          text: 'Create Account',
                          onPressed: () {
                            // TODO: Implement FINAL registration logic
                            // 1. Validate all fields
                            // 2. Gather all data from controllers
                            // 3. Make API call to your backend to create the user
                            // 4. On success, navigate to the app's home screen or dashboard
                            print('Ghana Card: ${widget.ghanaCardNumber}');
                            print('First Name: ${_firstNameController.text}');
                            print('Surname: ${_surnameController.text}');
                            print('Email: ${_emailController.text}');
                            print('Password: ${_passwordController.text}');
                            // etc.
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget for section headers
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(title, style: AppTheme.h2.copyWith(fontSize: 18)),
    );
  }
}