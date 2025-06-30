import 'package:flutter/material.dart';
import 'package:local_government_app/utils/colors.dart';
import 'package:local_government_app/utils/typography.dart';

class CustomGovServiceCard extends StatelessWidget {
  final String title;
  final String image;
  final Color color;
  final VoidCallback? onTap;
  final String description;
  final String buttonTitle;
  final Color buttonColor;
  
  // Keep this as an Icon widget, as it gives more flexibility (size, color)
  // when you call the CustomGovServiceCard.
  final Icon buttonIcon; 

  const CustomGovServiceCard({
    super.key,
    required this.title,
    required this.image,
    required this.color,
    required this.description,
    required this.buttonTitle,
    required this.buttonColor,
    required this.buttonIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.47, // Use slightly less width for better grid spacing
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: ColorPack.white,
        borderRadius: BorderRadius.circular(10),
        
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              // Use the passed-in color for the icon background
              color: color.withOpacity(0.15), 
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              image,
              width: 28,
              height: 28,
              // You can also tint the icon with the passed color
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: tTextStyleBold.copyWith(
              color: ColorPack.black,
              fontSize: size.width * 0.04,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: tTextStyle500.copyWith(
              color: ColorPack.darkGray.withOpacity(0.3), // Use a slightly lighter color
              fontSize: size.width * 0.030,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onTap,
            // FIX 1: Use ElevatedButton.styleFrom for an ElevatedButton
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              // Remove shadow from the button itself to look cleaner on a card
              elevation: 0,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(buttonTitle, style: tTextStyleBold.copyWith(color: ColorPack.white, fontSize: size.width*0.03)),
                const SizedBox(width: 8),
                
                // --- FIX 2: USE THE WIDGET DIRECTLY ---
                // The `buttonIcon` variable is already a complete Icon widget.
                // You don't need to wrap it in another Icon() constructor.
                buttonIcon, 
              ],
            ),
          ),
        ],
      ),
    );
  }
}