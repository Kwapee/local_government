// lib/models/payment_item.dart

// Using an enum is safer than strings for status
enum PaymentStatus { paid, pending, failed }

class PaymentItem {
  final String serviceName;
  final double amount;
  final DateTime date;
  final PaymentStatus status;

  PaymentItem({
    required this.serviceName,
    required this.amount,
    required this.date,
    required this.status,
  });
}