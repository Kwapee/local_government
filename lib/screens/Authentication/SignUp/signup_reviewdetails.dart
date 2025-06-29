import 'dart:convert';

import 'package:flutter/material.dart'; // Import your model
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_government_app/models/verification_results.dart';
import 'package:local_government_app/screens/Authentication/signin_screen.dart';
import 'package:local_government_app/utils/app_theme.dart';
import 'package:local_government_app/utils/colors.dart';
import 'package:local_government_app/utils/typography.dart';
import 'package:local_government_app/widgets/auth_header.dart';
import 'package:local_government_app/widgets/components/buttons/primary_button.dart';
import 'package:local_government_app/widgets/components/inputfields/custom_text_field.dart';
import 'package:local_government_app/widgets/expandlistwidget.dart';
import 'package:local_government_app/widgets/progress_stepper.dart';
import 'package:local_government_app/widgets/scrollbar.dart';

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
  final _confirmpasswordController = TextEditingController();
  final _phoneController = TextEditingController();
  //final _addressController = TextEditingController();

  Map<String, dynamic> regionsAndAssembliesData = {};

  // Lists to hold the data for the dropdowns
  List<String> _regionsList = [];
  List<String> _assembliesForSelectedRegion = [];

  // State for selected values
  String? _selectedRegion;
  String? _selectedAssembly;

  bool isRegionStrechedDropDown = false;
  bool isAssemblyStrechedDropDown = false;

  String RegionType = 'Select Region';
  String AssemblyType = 'Select Assembly';

  @override
  void initState() {
    super.initState();
    // 2. Populate the controllers with the data passed to the widget
    _firstNameController.text = widget.verificationResult.firstName ?? '';
    _surnameController.text = widget.verificationResult.lastName ?? '';
    _emailController.text = widget.verificationResult.email ?? '';
    _phoneController.text = widget.verificationResult.phoneNumber ?? '';

    _loadRegionsData();
  }

  // 3. New asynchronous method to load and parse the JSON
  Future<void> _loadRegionsData() async {
    final String response = await rootBundle.loadString(
      'assets/data/regions_and_assemblies.json',
    );
    final data = await json.decode(response);

    setState(() {
      regionsAndAssembliesData = data;
      _regionsList = regionsAndAssembliesData.keys.toList();
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    _phoneController.dispose();
   // _addressController.dispose();
    super.dispose();
  }

  // In your _SignupReviewDetailsState class

Widget _buildDropdown({
  required String hintText,
  required String? selectedValue,
  required List<String> items,
  required bool isExpanded,
  required ValueChanged<bool> onToggle,
  required ValueChanged<String?> onSelect,
}) {
  bool isDisabled = (hintText == 'Select Assembly' && _selectedRegion == null);

  return Column(
    children: [
      GestureDetector(
        onTap: () {
          if (!isDisabled) {
            onToggle(!isExpanded);
          }
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: isDisabled ? Colors.grey.shade200 : AppTheme.white,
            border: Border.all(color: isDisabled ? Colors.grey.shade400 : ColorPack.darkGray),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedValue ?? hintText,
                style: tTextStyleRegular.copyWith(
                  fontSize: 16,
                  color: selectedValue == null
                      ? Colors.grey.shade600
                      : ColorPack.black,
                ),
              ),
              Icon(
                isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                color: isDisabled ? Colors.grey.shade400 : ColorPack.black,
              ),
            ],
          ),
        ),
      ),
      if (!isDisabled)
        ExpandedSection(
          expand: isExpanded,
          height: 150,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10)
            ),
            child: MyScrollbar(
              builder: (context, scrollController) => ListView.builder(
                padding: EdgeInsets.zero,
                controller: scrollController,
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                   return ListTile(
                    title: Text(
                      item,
                      style: tTextStyleRegular.copyWith(
                        fontSize: 16,
                        // Make text white when selected for better contrast
                        color: selectedValue == item ? Colors.white : ColorPack.darkGray,
                      ),
                    ),
                    // Set the selected state to highlight the correct item
                    selected: selectedValue == item,
                    // Define the color for the highlight
                    selectedTileColor: ColorPack.iconOrange,
                    // The onTap action now handles the selection
                    onTap: () {
                      onSelect(item); // This calls the setState logic from the parent
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)
                    ),
                  );
                },
              ),
            ),
          ),
        ),
    ],
  );
}

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppTheme.secondary,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             IconButton(onPressed: () => Navigator.pop(context), icon: Icon(FontAwesomeIcons.arrowLeft, size: size.width * 0.05)),
            // Using a simple header text for this screen
            const AuthHeader(
              title: 'Review Details',
              subtitle:
                  'Please confirm your details and complete registration.',
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
                        /* _buildSectionHeader('Verified Information'),
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
                        ),*/
                        const SizedBox(height: 5),
                        _buildSectionHeader('Complete Your Profile'),
                        CustomTextField(
                          controller: _emailController,
                          hintText: 'Email Address',
                          icon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          readOnly: false,
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          controller: _passwordController,
                          hintText: 'Create a Password',
                          icon: Icons.lock_outline,
                          isPassword: true,
                          readOnly: false,
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          controller: _confirmpasswordController,
                          hintText: 'Confirm Password',
                          icon: Icons.lock_outline,
                          isPassword: true,
                          readOnly: false,
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          controller: _phoneController,
                          hintText: 'Phone Number',
                          icon: Icons.phone_outlined,
                          keyboardType: TextInputType.phone,
                          readOnly: false,
                        ),
                        const SizedBox(height: 16),

                        _buildDropdown(
                          hintText: 'Select Region',
                          selectedValue: _selectedRegion,
                          items: _regionsList,
                          isExpanded: isRegionStrechedDropDown,
                          onToggle: (isExpanded) {
                            setState(() {
                              isRegionStrechedDropDown = isExpanded;
                              isAssemblyStrechedDropDown =
                                  false; // Close other dropdown
                            });
                          },
                          onSelect: (newValue) {
                            setState(() {
                              _selectedRegion = newValue;
                              _selectedAssembly =
                                  null; // IMPORTANT: Reset assembly when region changes
                              _assembliesForSelectedRegion = List<String>.from(
                                regionsAndAssembliesData[newValue!] ?? [],
                              );
                              isRegionStrechedDropDown = false;
                            });
                          },
                        ),

                        const SizedBox(height: 16),
                        _buildDropdown(
                          hintText: 'Select Assembly',
                          selectedValue: _selectedAssembly,
                          items: _assembliesForSelectedRegion,
                          isExpanded: isAssemblyStrechedDropDown,
                          onToggle: (isExpanded) {
                            setState(() {
                              isAssemblyStrechedDropDown = isExpanded;
                              isRegionStrechedDropDown =
                                  false; // Close other dropdown
                            });
                          },
                          onSelect: (newValue) {
                            setState(() {
                              _selectedAssembly = newValue;
                              isAssemblyStrechedDropDown = false;
                            });
                          },
                        ),

                        const SizedBox(height: 32),

                        // --- 4. FINAL CALL-TO-ACTION BUTTON ---
                        PrimaryButton(
                          text: 'Create Account',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignIn(),
                              ),
                            );
                            // TODO: Implement FINAL registration logic
                            // 1. Validate all fields
                            // 2. Gather all data from controllers
                            // 3. Make API call to your backend to create the user
                            // 4. On success, navigate to the app's home screen or dashboard
                            print('Ghana Card: ${widget.ghanaCardNumber}');
                            print('First Name: ${_firstNameController.text}');
                            print('Surname: ${_surnameController.text}');
                            print('Email: ${_emailController.text}');
                            print('Password: ${_confirmpasswordController.text}');
                            print('Phone Number: ${_phoneController.text}');
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
