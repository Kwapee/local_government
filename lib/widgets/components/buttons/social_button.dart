import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_government_app/utils/app_theme.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton.icon(
        onPressed: () {
          // TODO: Implement Google Sign-In logic
        },
        icon: const FaIcon(FontAwesomeIcons.google, color: AppTheme.darkGrey),
        label: Text(
          'Continue with Google',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppTheme.darkGrey,
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppTheme.grey, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
    );
  }
}