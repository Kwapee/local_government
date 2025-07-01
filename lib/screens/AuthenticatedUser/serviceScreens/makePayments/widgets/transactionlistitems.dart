import 'package:flutter/material.dart';
import 'package:local_government_app/screens/AuthenticatedUser/serviceScreens/makePayments/widgets/transactionstatus.dart';
import 'package:local_government_app/utils/colors.dart';
import 'package:local_government_app/utils/typography.dart';
// Make sure to import your StatusChip and other dependencies

class TransactionListItem extends StatelessWidget {
  // --- Parameters to make the widget configurable ---
  final String title;
  final String date;
  final String amount;
  final TransactionStatus status;
  final IconData icon;
  final VoidCallback onDownloadTap;

  const TransactionListItem({
    Key? key,
    required this.title,
    required this.date,
    required this.amount,
    required this.status,
    required this.icon,
    required this.onDownloadTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    // --- Define constants for spacing and styling to avoid magic numbers ---
    const double horizontalPadding = 16.0;
    const double verticalPadding = 12.0;
    const double iconSize = 20.0;
    const double spacing = 8.0;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 8.0,
      ),
      child: Container(
        padding: const EdgeInsets.all(verticalPadding),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          // Use CrossAxisAlignment.center for better vertical alignment
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // --- Left Section: Icon and Text ---
            Icon(icon, color: Colors.green.shade700, size: iconSize),
            const SizedBox(width: spacing),
            // Use Expanded to allow the title/date to take available space
            // and prevent text overflow.
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: tTextStyleBold.copyWith(
                      color: ColorPack.black,
                      fontSize: size.width * 0.03,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date,
                    style: tTextStyleBold.copyWith(
                      color: ColorPack.black,
                      fontSize: size.width * 0.03,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: spacing),

            // --- Right Section: Amount, Status, and Download Icon ---
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  amount,
                  style: tTextStyleBold.copyWith(
                    color: ColorPack.black,
                    fontSize: size.width * 0.03,
                  ),
                ),
                const SizedBox(width: 8),
                StatusChip(status: status),
              ],
            ),
            const SizedBox(width: spacing / 2),
            InkWell(
              onTap: onDownloadTap,
              customBorder: const CircleBorder(),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset(
                  "assets/images/download.png",
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
