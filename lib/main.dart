import 'package:flutter/material.dart';
import 'package:local_government_app/screens/Authentication/signin_screen.dart';
import 'package:local_government_app/screens/Authentication/SignUp/signup_screen.dart';
import 'package:local_government_app/utils/app_theme.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local Government App',
      theme: AppTheme.themeData,
      debugShowCheckedModeBanner: false,
      // Using named routes for clean navigation
      initialRoute: '/',
      routes: {
        '/': (context) => const SignIn(),
        '/signup': (context) => const SignUpScreen(),
      },
    );
  }
}