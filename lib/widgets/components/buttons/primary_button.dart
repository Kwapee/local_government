import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_government_app/utils/app_theme.dart';


class PrimaryButton extends StatelessWidget {
  final String text;
  final Color buttonColor;
  final VoidCallback onPressed;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.buttonColor,
    required this.onPressed,
    
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: AppTheme.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        child: Text(text),
      ),
    );
  }
}