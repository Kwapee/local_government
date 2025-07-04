import 'package:flutter/material.dart';
import 'package:local_government_app/utils/app_theme.dart';


class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
     final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: EdgeInsets.only(left: size.width*0.02, right: size.width*0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           SizedBox(
            width: size.width*0.60,
            height: size.height*0.10,
            child: Image.asset("assets/images/gov_header_img.png")),
            const SizedBox(height: 20),
            Text(title, style: AppTheme.h1.copyWith(color: AppTheme.primary, fontSize: size.width*0.045),),
            const SizedBox(height: 8),
            Text(subtitle, style: AppTheme.bodyText.copyWith(fontSize: size.width*0.035) ),
          ],
        ),
      ),
    );
  }
}