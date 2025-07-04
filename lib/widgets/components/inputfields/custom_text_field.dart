import 'package:flutter/material.dart';
import 'package:local_government_app/utils/app_theme.dart';
import 'package:local_government_app/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool isPassword;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    required bool readOnly,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon, color: AppTheme.grey),
        filled: true,
        fillColor: ColorPack.darkGray.withOpacity(0.07),
        contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          //borderSide: BorderSide.none,
          borderSide: BorderSide(color: ColorPack.darkGray.withOpacity(0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: AppTheme.black, width: 2.0),
        ),
      ),
    );
  }
}
