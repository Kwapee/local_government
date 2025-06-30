import 'package:flutter/material.dart';
import 'package:local_government_app/utils/colors.dart';
import 'package:local_government_app/utils/typography.dart';

class CustomMakePaymentCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String icon;
  final Color containerColor;
  final String numDescription;
  final Color avatarColor;

  const CustomMakePaymentCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.containerColor,
    required this.numDescription,
    required this.avatarColor,
  });

  @override
  Widget build(BuildContext context) {
    // It's better to calculate this once and reuse it.
    final size = MediaQuery.of(context).size;

    return Container(
      // Use constraints instead of fixed height/width for more flexibility.
      // The child Column will determine the height.
      width: size.width * 0.47,
      height: size.height*0.15,
      padding: const EdgeInsets.all(12.0), // Consistent padding for all sides
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(8), // A slightly larger radius is often visually pleasing
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.7), // Softer shadow color
            blurRadius: 5.0,
            offset: const Offset(0, 2), // Standard bottom shadow
          ),
        ],
      ),
      child: Column(
        // Use MainAxisAlignment.spaceBetween to push the top and bottom rows apart.
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- TOP ROW (Title, Subtitle, and Icon) ---
          Row(
            crossAxisAlignment: CrossAxisAlignment.start, // Align items to the top
            children: [
              // Use Expanded to allow the text Column to take up available space
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: tTextStyleBold.copyWith(
                        color: ColorPack.black,
                        fontSize: 10, // Using fixed sizes is more reliable than screen percentage
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4), // Consistent spacing
                    Text(
                      subtitle,
                      style: tTextStyleBold.copyWith(
                        color: ColorPack.darkGray,
                        fontSize: 18, // Make the subtitle (the main number/data) larger
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8), // Space between text and icon
              // The icon wrapped in a colored circle
              CircleAvatar(
                radius: 15,
                backgroundColor: avatarColor, // Softer background
                child: Image.asset(
                  icon,
                  width: 16,
                  height: 16,
                  // Optional: if your icon assets are not all one color
                  // color: ColorPack.discoverBlue, 
                ),
              ),
            ],
          ),

          // --- BOTTOM ROW (Number and Description) ---
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Green up-arrow icon example

              Expanded(
                child: Text(
                  numDescription,
                  style: tTextStyle500.copyWith(
                    color: ColorPack.darkGray,
                    fontSize: 13,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}