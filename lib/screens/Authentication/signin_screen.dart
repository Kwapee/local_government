import 'package:flutter/material.dart';
import 'package:local_government_app/screens/AuthenticatedUser/home.dart';
import 'package:local_government_app/utils/app_theme.dart';
import 'package:local_government_app/widgets/auth_header.dart';
import 'package:local_government_app/widgets/components/buttons/primary_button.dart';
import 'package:local_government_app/widgets/components/inputfields/custom_text_field.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // We no longer need the 'size' variable for this layout
    // final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      // Set the background color here, so it shows behind the header
      backgroundColor: AppTheme.secondary,
      body: SafeArea(
        // 1. The main layout is a Column that fills the screen.
        // The SingleChildScrollView has been removed from here.
        child: Column(
          children: [
            const AuthHeader(
              title: 'Welcome Back',
              subtitle: 'Sign in to your account',
            ),
            // 2. Use Expanded to make the white container fill ALL remaining space.
            Expanded(
              child: Container(
                // The horizontal padding is now part of the container.
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                decoration: const BoxDecoration(
                  color: AppTheme.white,
                  // We only want the top corners to be rounded.
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  // The shadow from your original code is great.
                
                ),
                // 3. Put the SingleChildScrollView INSIDE the container.
                // Now, only the form content will scroll.
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text('Login with email', style: AppTheme.h3),
                        ),
                        const SizedBox(height: 24),
                        CustomTextField(
                          controller: emailController,
                          hintText: 'Email/Username',
                          icon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                           readOnly: false
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          controller: passwordController,
                          hintText: 'Password',
                          icon: Icons.lock_outline,
                          isPassword: true,
                           readOnly: false
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Forgot Password?',
                                style: AppTheme.linkText,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        PrimaryButton(
                          text: 'Login',
                          onPressed: () {
                           Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
                          },
                        ),
                        const SizedBox(height: 24), // Spacing
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?",
                                style: AppTheme.bodyText),
                            TextButton(
                              onPressed: () =>
                                  Navigator.pushNamed(context, '/signup'),
                              child: Text('Sign Up', style: AppTheme.linkText),
                            ),
                          ],
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
}