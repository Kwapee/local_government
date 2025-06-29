import 'package:flutter/material.dart';
import 'package:local_government_app/utils/colors.dart';
import 'package:local_government_app/utils/typography.dart';

class CustomRecentActivityCard extends StatelessWidget {

  final String title;
  final String description;
  final String date;
  final String image;

  const CustomRecentActivityCard({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          /*Text(
            "Recent Activity",
            // Give the title some style to stand out
            style: tTextStyleBold.copyWith(
              color: ColorPack.black,
              fontSize: size.width * 0.04,
            ),
          ),
          const SizedBox(
            height: 16,
          ), */// Space between title and the activity row
          // --- FIX IS HERE ---
          // The Row containing the activity item
          Row(
            // Use CrossAxisAlignment.center to vertically align the icon and the text column
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. Give the image a clear, fixed size.
              // Don't use SizedBox to size an image. Size the Image widget itself.
              Image.asset(
                image,
                width: 40, // A reasonable, fixed size for an icon
                height: 40,
              ),
              const SizedBox(width: 12), // Space between the icon and the text
              // 2. Wrap the text column in Expanded. This is the most important fix.
              // It tells the column to take up all remaining horizontal space.
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: tTextStyle500.copyWith(
                        color: ColorPack.black,
                        fontSize: size.width * 0.036,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ), // Small space between lines of text
                    Text(
                     description,
                      style: tTextStyle500.copyWith(
                        color: ColorPack.darkGray.withOpacity(0.7),
                        fontSize: size.width * 0.03,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      date,
                      style: tTextStyle500.copyWith(
                        color: ColorPack.darkGray.withOpacity(0.7),
                        fontSize: size.width * 0.03,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
    );
  }
}
