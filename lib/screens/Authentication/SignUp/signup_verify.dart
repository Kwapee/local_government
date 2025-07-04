import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_government_app/screens/Authentication/signin_screen.dart';
import 'package:local_government_app/utils/app_theme.dart';
import 'package:local_government_app/utils/colors.dart';
import 'package:local_government_app/utils/typography.dart';
import 'package:local_government_app/widgets/auth_header.dart';
import 'package:local_government_app/widgets/components/buttons/primary_button.dart';
import 'package:local_government_app/widgets/progress_stepper.dart';

class SignUpOtpVerification extends StatefulWidget {
  const SignUpOtpVerification({super.key});

  @override
  State<SignUpOtpVerification> createState() => _SignUpOtpVerificationState();
}

class _SignUpOtpVerificationState extends State<SignUpOtpVerification> {
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  final List<TextEditingController> _controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  final bool _isLoading = false;

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
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
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(FontAwesomeIcons.arrowLeft, size: size.width * 0.05),
            ),
            // Using a simple header text for this screen
            const AuthHeader(
              title: 'Verify Email/Phone Number',
              subtitle:
                  'Please you will recieve an otp through your email/phone number',
            ),
            const ProgressStepper(currentStep: 3),
            SizedBox(height: size.height * 0.02),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.02,),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.02,),
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
                          //const SizedBox(height: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: size.width * 0.02),
                              Center(
                                child: Text(
                                  'Verification',
                                  style: GoogleFonts.poppins(
                                    color: ColorPack.black,
                                    fontSize: size.width*0.045,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                
                              /*Padding(
                          padding: EdgeInsets.only(left: size.width * 0.85),
                          child: Text(
                            "2/3",
                            style: GoogleFonts.poppins(
                                color: ColorPack.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),*/
                              Padding(
                                padding: EdgeInsets.only(
                                  left: size.width * 0.04,
                                  right: size.width * 0.04,
                                  top: size.height * 0.02,
                                ),
                                child: Text(
                                  'Enter the six digit code sent to your email',
                                  style: GoogleFonts.poppins(
                                    color: ColorPack.black,
                                    fontSize: size.width * 0.039,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: size.width * 0.02,
                                  top: size.height * 0.03,
                                  right: size.width * 0.02,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: List.generate(6, (index) {
                                    return SizedBox(
                                      width: size.width * 0.12,
                                      height: 60,
                                      child: TextField(
                                        controller: _controllers[index],
                                        focusNode: _focusNodes[index],
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        maxLength: 1,
                                        cursorColor: ColorPack.black,
                                        style: GoogleFonts.poppins(
                                          fontSize: 22,
                                          color: ColorPack.black,
                                        ),
                                        decoration: InputDecoration(
                                          counterText: "",
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey.shade400,
                                              width: 1,
                                            ),
                                          ),
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.black,
                                                  width: 2,
                                                ),
                                              ),
                                        ),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                        ],
                                        onChanged: (value) {
                                          if (value.isNotEmpty) {
                                            if (index < 5) {
                                              FocusScope.of(context).requestFocus(
                                                _focusNodes[index + 1],
                                              );
                                            } else {
                                              FocusScope.of(
                                                context,
                                              ).unfocus(); // Hide keyboard on last digit
                                            }
                                          } else {
                                            if (index > 0) {
                                              FocusScope.of(context).requestFocus(
                                                _focusNodes[index - 1],
                                              );
                                            }
                                          }
                                        },
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: size.width * 0.04,
                                  top: size.height * 0.02,
                                ),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    "Send code again",
                                    style: GoogleFonts.poppins(
                                      color: ColorPack.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  
                                  top: size.height * 0.08,
                                ),
                                child: PrimaryButton(
                                  buttonColor: ColorPack.red,
                                  text: _isLoading ? '' : "Verify",
                                  onPressed: () {
                                    String otp =
                                        _controllers.map((c) => c.text).join();
                                    print("OTP is: $otp");
                
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const SignIn(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              if (_isLoading)
                                const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                ),
                              SizedBox(height: size.height * 0.25),
                            ],
                          ),
                        ],
                      ),
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
}
