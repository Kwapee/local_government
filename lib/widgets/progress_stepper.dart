// lib/widgets/progress_stepper.dart
import 'package:flutter/material.dart';
import 'package:local_government_app/utils/app_theme.dart';

class ProgressStepper extends StatelessWidget {
  final int currentStep; // Will be 1 or 2

  const ProgressStepper({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    // Determine colors based on the current step
    final bool isStep1Active = currentStep >= 1;
    final bool isStep2Active = currentStep >= 2;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0,),
      child: Row(
        children: [
          // --- Step 1 ---
          _buildStep(
            number: '1',
            label: 'Create Account',
            isActive: isStep1Active,
          ),
          // --- Connecting Line ---
          Expanded(
            child: Divider(
              height: 2,
              color: isStep2Active ? AppTheme.darkGrey : Colors.grey,
              endIndent: 10,
              indent: 10,
            ),
          ),
          // --- Step 2 ---
          _buildStep(
            number: '2',
            label: 'Review Details',
            isActive: isStep2Active,
          ),
        ],
      ),
    );
  }

  // Helper widget to build a single step circle and label
  Widget _buildStep({
    required String number,
    required String label,
    required bool isActive,
  }) {
    return Column(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? AppTheme.darkGrey : Colors.transparent,
            border: Border.all(color: isActive ? AppTheme.darkGrey : Colors.grey),
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(color: isActive ? Colors.white : Colors.grey),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTheme.bodyText.copyWith(
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            color: isActive ? AppTheme.darkGrey : Colors.grey,
          ),
        ),
      ],
    );
  }
}