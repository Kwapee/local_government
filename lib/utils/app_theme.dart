import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Constant Colors
  static const Color primary = Color(0xFF005A9C); // Professional Blue
  static const Color secondary = Color(0xFFE6F0F6); // Light background blue
  static const Color accent = Color(0xFFF5A623); // Accent color
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;
  static const Color darkGrey = Color(0xFF333333);
  static const Color buttonBackground = Color.fromARGB(255, 243, 3, 3);

  // Text Styles
  static final TextStyle h1 = GoogleFonts.inter(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: darkGrey,
  );
  static final TextStyle h2 = GoogleFonts.inter(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: darkGrey,
  );
  static final TextStyle h3 = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: darkGrey,
  );
  static final TextStyle bodyText = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: grey,
  );
  static final TextStyle linkText = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: primary,
  );

  // App-wide Theme
  static ThemeData get themeData {
    return ThemeData(
      primaryColor: primary,
      scaffoldBackgroundColor: secondary,
      colorScheme: const ColorScheme.light(primary: primary, secondary: accent),
      textTheme: GoogleFonts.interTextTheme(),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: darkGrey),
      ),
    );
  }
}
