import 'package:flutter/material.dart';
import 'package:umair_liaqat_portfolio/config/size_config.dart';
import 'package:umair_liaqat_portfolio/utils/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryColor.withOpacity(0.3),
                    secondaryColor,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Positioned(
              top: -150, // Position circle above the screen
              left: -100, // Position circle to the left
              child: Container(
                height:
                    SizeConfig.height(context) * 1.5, // Adjust size as needed
                width:
                    SizeConfig.height(context) * 1.5, // Adjust size as needed
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: secondaryColor.withOpacity(0.5),
                ),
              ),
            ),
            Positioned(
              bottom: -20, // Position circle below the screen
              right: -100, // Position circle to the right
              child: Container(
                height:
                    SizeConfig.height20(context) * 1.5, // Adjust size as needed
                width:
                    SizeConfig.width20(context) * 1.5, // Adjust size as needed
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: secondaryColor.withOpacity(0.5),
                ),
              ),
            ),
            Positioned(
              top: -20, // Position circle below the screen
              left: -100, // Position circle to the right
              child: Container(
                height:
                    SizeConfig.height20(context) * 1.5, // Adjust size as needed
                width:
                    SizeConfig.width20(context) * 1.5, // Adjust size as needed
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: secondaryColor.withOpacity(0.5),
                ),
              ),
            ),
            Positioned(
              top: -200, // Position circle above the screen
              right: -250, // Position circle to the right
              child: Container(
                height: SizeConfig.height(context), // Adjust size as needed
                width: SizeConfig.height(context), // Adjust size as needed
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: secondaryColor.withOpacity(0.5),
                ),
              ),
            ),
            Positioned(
              bottom: -150, // Position circle below the screen
              left: -150, // Position circle to the left
              child: Container(
                height:
                    SizeConfig.height(context) * 1.2, // Adjust size as needed
                width:
                    SizeConfig.height(context) * 1.2, // Adjust size as needed
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: secondaryColor.withOpacity(0.5),
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Umair Liaqat",
                    style: TextStyle(
                      fontSize: SizeConfig.font20(context),
                      fontWeight: FontWeight.bold,
                      color: whiteColor,
                    ),
                  ),
                  Text(
                    "A Flutter developer",
                    style: TextStyle(
                      fontSize: SizeConfig.font10(context),
                      fontWeight: FontWeight.bold,
                      color: whiteColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
