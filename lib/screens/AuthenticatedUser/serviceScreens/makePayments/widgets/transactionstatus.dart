import 'package:flutter/material.dart';
import 'package:local_government_app/utils/colors.dart';

// Define an enum for the status types for type-safety and clarity
enum TransactionStatus { paid, failed, pending }

class StatusChip extends StatelessWidget {
  final TransactionStatus status;

  const StatusChip({Key? key, required this.status}) : super(key: key);

  // Helper method to get the right text based on status
  String _getStatusText() {
    switch (status) {
      case TransactionStatus.paid:
        return "Paid";
      case TransactionStatus.failed:
        return "Failed";
      case TransactionStatus.pending:
        return "Pending";
    }
  }

  // Helper method to get the right color based on status
  Color _getStatusColor() {
    switch (status) {
      case TransactionStatus.paid:
        return const Color(0xFF2E7D32); // A nice, deep green
      case TransactionStatus.failed:
        return const Color(0xFFC62828); // A clear red
      case TransactionStatus.pending:
        return const Color(0xFFEF6C00); // An amber/orange
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getStatusColor(),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _getStatusText(),
        style: textTheme.bodyMedium?.copyWith(
          color: ColorPack.white,
          fontWeight: FontWeight.w500,
          fontSize: 10, // Using a fixed size for small chip text is often better
        ),
      ),
    );
  }
}