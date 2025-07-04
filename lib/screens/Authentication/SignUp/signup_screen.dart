import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_government_app/models/verification_results.dart';
import 'package:local_government_app/screens/Authentication/SignUp/signup_reviewdetails.dart';
import 'package:local_government_app/services/verification_api.dart';
import 'package:local_government_app/utils/app_theme.dart';
import 'package:local_government_app/utils/colors.dart';
import 'package:local_government_app/utils/typography.dart';
import 'package:local_government_app/widgets/auth_header.dart';
import 'package:local_government_app/widgets/components/inputfields/custom_text_field.dart';
import 'package:local_government_app/widgets/progress_stepper.dart';
import 'package:permission_handler/permission_handler.dart';

// Enum to manage the multi-step state of the screen
enum SignUpStep {
  initial, // Ready to take picture
  pictureTaken, // Picture is taken, ready to verify
  verifying, // API call in progress
  verificationSuccess, // API call succeeded
  verificationFailed, // API call failed
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // State Management Variables
  SignUpStep _currentStep = SignUpStep.initial;
  File? _imageFile;
  bool _isLoading = false;
  String? _errorMessage;
  VerificationResult? _verificationResult;
  bool _isPinEntered = false;

  // Controllers
  final _ghanacardController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final GhanaCardService _ghanaCardService = GhanaCardService();

  @override
  void initState() {
    super.initState();
    // --- NEW: Add a listener to the text controller ---
    // This will be called every time the text in the field changes.
    _ghanacardController.addListener(_validatePin);
  }

  @override
  void dispose() {
    _ghanacardController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  void _validatePin() {
    // A simple validation: check if the text is not empty.
    // You could add more complex validation here, like checking the format.
    final isPinValid = _ghanacardController.text.trim().isNotEmpty;

    // Only update the state if the validity has actually changed
    // to avoid unnecessary screen rebuilds.
    if (_isPinEntered != isPinValid) {
      setState(() {
        _isPinEntered = isPinValid;
      });
    }
  }

  // --- LOGIC FOR BUTTON PRESSES ---

  Future<void> _handlePrimaryButtonPress() async {
    // ... (This method is correct, no changes needed)
    switch (_currentStep) {
      case SignUpStep.initial:
        await _takePicture();
        break;
      case SignUpStep.pictureTaken:
      case SignUpStep.verificationFailed:
        await _verifyDetails();
        break;
      default:
        break;
    }
  }

  Future<void> _takePicture() async {
    // 1. Check for camera permission
    var status = await Permission.camera.request();
    if (status.isGranted) {
      // 2. Open camera to take a picture
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,

        // --- THESE ARE THE KEY CHANGES TO REDUCE FILE SIZE ---

        // Resize the image to a much more reasonable width.
        // 640px is a good starting point for verification photos.
        // It's large enough to be clear but small enough in file size.
        maxWidth: 640,

        // Compress the image to 80% of its original quality.
        // This is often visually indistinguishable but saves a lot of space.
        imageQuality: 80,

        // --- END OF KEY CHANGES ---
      );

      if (pickedFile != null) {
        // For debugging, let's check the new file size
        final file = File(pickedFile.path);
        final fileSize = await file.length();
        print("Image captured. New file size: ${fileSize / 1024} KB");

        setState(() {
          _imageFile = file;
          _currentStep = SignUpStep.pictureTaken;
          _errorMessage = null;
        });
      }
    } else {
      setState(() {
        _errorMessage = "Camera permission is required to continue.";
      });
    }
  }

  Future<void> _verifyDetails() async {
    // ... (This method is correct, no changes needed)
    setState(() {
      _isLoading = true;
      _currentStep = SignUpStep.verifying;
      _errorMessage = null;
    });
    try {
      final String? token = await _ghanaCardService.generateToken();
      if (token == null) {
        throw Exception(
          "Failed to connect to the server. Please check your internet and try again.",
        );
      }
      final VerificationResult? result = await _ghanaCardService
          .verifyGhanaCard(
            pin: _ghanacardController.text,
            imageFile: _imageFile!,
            token: token,
          );
      if (result != null && result.isValid) {
        setState(() {
          _verificationResult = result;
          _firstNameController.text = result.firstName ?? 'N/A';
          _lastNameController.text = result.lastName ?? 'N/A';
          _emailController.text = result.email ?? 'N/A';
          _phoneNumberController.text = result.phoneNumber ?? 'N/A';
          _currentStep = SignUpStep.verificationSuccess;
          _isLoading = false;
        });
      } else {
        throw Exception(
          "Verification failed. The picture may be unclear or details may not match. Please take a new picture.",
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceFirst("Exception: ", "");
        _currentStep = SignUpStep.initial;
        _imageFile = null;
        _isLoading = false;
      });
    }
  }

  // --- THE MISPLACED METHOD HAS BEEN DELETED FROM HERE ---

  // --- UI HELPER METHODS ---
  String _getButtonText() {
    // ... (This method is correct, no changes needed)
    switch (_currentStep) {
      case SignUpStep.initial:
        return 'Take Picture';
      case SignUpStep.pictureTaken:
      case SignUpStep.verificationFailed:
        return 'Verify';
      case SignUpStep.verifying:
        return 'Verifying...';
      case SignUpStep.verificationSuccess:
        return 'Verified';
    }
  }

  @override
  Widget build(BuildContext context) {
    // The entire build method is correct and does not need any changes.
    // ... (your existing build method code)
    final size = MediaQuery.of(context).size;
    final isPrimaryButtonDisabled =
        _currentStep == SignUpStep.verifying ||
        _currentStep == SignUpStep.verificationSuccess;
    final isNextButtonEnabled = _currentStep == SignUpStep.verificationSuccess;

    return Scaffold(
      backgroundColor: AppTheme.secondary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(FontAwesomeIcons.arrowLeft, size: size.width * 0.05),
              ),
              const AuthHeader(
                title: 'Create an Account',
                subtitle: 'Welcome!',
              ),
              //const SizedBox(height: 24),
              const ProgressStepper(currentStep: 1),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.03,
                    horizontal: size.width * 0.05,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Personal Information',
                          style: AppTheme.h2.copyWith(fontSize: 18),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Please enter your card number, take a picture, and click verify.',
                        style: tTextStyle600.copyWith(
                          color: ColorPack.darkGray.withOpacity(0.7),
                          fontSize: size.width * 0.035,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Ghana Card Number',
                        style: AppTheme.bodyText.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CustomTextField(
                        controller: _ghanacardController,
                        hintText: 'GHA-12345678-90',
                        icon: Icons.credit_card,
                        readOnly: false,
                      ),
                      const SizedBox(height: 24),
                      Center(
                        child: Container(
                          width: 280,
                          height: 180,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(11.0),
                            child:
                                _imageFile == null
                                    ? Image.asset(
                                      'assets/images/ghana_card.png',
                                      fit: BoxFit.contain,
                                    )
                                    : Image.file(
                                      _imageFile!,
                                      fit: BoxFit.cover,
                                    ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          // --- THIS IS THE KEY CHANGE ---
                          onPressed:
                              // First, check if the button should generally be disabled (e.g., during verification)
                              isPrimaryButtonDisabled
                                  ? null
                                  // If not, and if we are in the initial step, ALSO check if the PIN has been entered.
                                  : (_currentStep == SignUpStep.initial &&
                                      !_isPinEntered)
                                  ? null // <-- Disable button if in initial step AND PIN is not entered
                                  : _handlePrimaryButtonPress,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                _currentStep == SignUpStep.verificationSuccess
                                    ? Colors.green
                                    : ColorPack.red,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child:
                              _isLoading
                                  ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 3,
                                    ),
                                  )
                                  : Text(
                                    _getButtonText(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                        ),
                      ),
                      if (_errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Center(
                            child: Text(
                              _errorMessage!,
                              style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      if (_currentStep == SignUpStep.verificationSuccess &&
                          _verificationResult != null)
                        _buildResultsView(),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed:
                              isNextButtonEnabled
                                  ? () {
                                    if (_verificationResult != null) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => SignupReviewDetails(
                                                verificationResult:
                                                    _verificationResult!,
                                                ghanaCardNumber:
                                                    _ghanacardController.text,
                                              ),
                                        ),
                                      );
                                    }
                                  }
                                  : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorPack.red,
                            disabledBackgroundColor: Colors.grey.shade400,
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 24,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Next',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  // ... (Your _buildResultsView and _buildProgressStepper methods are correct and do not need changes)
  Widget _buildResultsView() {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          const SizedBox(height: 16),
          _buildReadOnlyTextField("First Name", _firstNameController),
          const SizedBox(height: 16),
          _buildReadOnlyTextField("Last Name", _lastNameController),
          const SizedBox(height: 16),
          _buildReadOnlyTextField("Email", _emailController),
          const SizedBox(height: 16),
          _buildReadOnlyTextField("Phone Number", _phoneNumberController),
        ],
      ),
    );
  }

  Widget _buildReadOnlyTextField(
    String label,
    TextEditingController controller,
  ) {
    return TextField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey.shade100,
        focusColor: ColorPack.black,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: ColorPack.black, width: 2.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.grey.shade300),

        ),
      ),
    );
  }

  Widget _buildProgressStepper() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF2C3E50),
                ),
                child: const Center(
                  child: Text('1', style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Create Account',
                style: AppTheme.bodyText.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkGrey,
                ),
              ),
            ],
          ),
          const Expanded(
            child: Divider(
              height: 2,
              color: Colors.grey,
              endIndent: 10,
              indent: 10,
            ),
          ),
          Column(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey),
                ),
                child: const Center(
                  child: Text('2', style: TextStyle(color: Colors.grey)),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Review Details',
                style: AppTheme.bodyText.copyWith(color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
