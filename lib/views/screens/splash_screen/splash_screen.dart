import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:umair_liaqat_portfolio/config/size_config.dart';
import 'package:umair_liaqat_portfolio/utils/colors.dart';
import 'package:umair_liaqat_portfolio/views/screens/home_screen/home_screen.dart';
import 'package:umair_liaqat_portfolio/views/widgets/buttons/bouncy_button.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
            // Positioned circles
            Positioned(
              top: -150,
              left: -100,
              child: Container(
                height: SizeConfig.height(context) * 1.5,
                width: SizeConfig.height(context) * 1.5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: secondaryColor.withOpacity(0.5),
                ),
              ),
            ),
            Positioned(
              bottom: -20,
              right: -100,
              child: Container(
                height: SizeConfig.height20(context) * 1.5,
                width: SizeConfig.width20(context) * 1.5,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: secondaryColor.withOpacity(0.5),
                ),
              ),
            ),
            Positioned(
              top: -20,
              left: -100,
              child: Container(
                height: SizeConfig.height20(context) * 1.5,
                width: SizeConfig.width20(context) * 1.5,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: secondaryColor.withOpacity(0.5),
                ),
              ),
            ),
            Positioned(
              top: -200,
              right: -250,
              child: Container(
                height: SizeConfig.height(context),
                width: SizeConfig.height(context),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: secondaryColor.withOpacity(0.5),
                ),
              ),
            ),
            Positioned(
              bottom: -150,
              left: -150,
              child: Container(
                height: SizeConfig.height(context) * 1.2,
                width: SizeConfig.height(context) * 1.2,
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
                  AnimationConfiguration.synchronized(
                    duration: const Duration(milliseconds: 500),
                    child: FadeInAnimation(
                      child: Text(
                        "Umair Liaqat",
                        style: TextStyle(
                          fontSize: SizeConfig.font20(context),
                          fontWeight: FontWeight.bold,
                          color: whiteColor,
                        ),
                      ),
                    ),
                  ),
                  AnimationConfiguration.synchronized(
                    duration: const Duration(milliseconds: 500),
                    child: FadeInAnimation(
                      child: Text(
                        "A Flutter developer",
                        style: TextStyle(
                          fontSize: SizeConfig.font10(context),
                          fontWeight: FontWeight.bold,
                          color: whiteColor,
                        ),
                      ),
                    ),
                  ),
                  AnimationConfiguration.synchronized(
                    duration: const Duration(milliseconds: 500),
                    child: FadeInAnimation(
                      child: BouncyButton(
                        buttonWidget: Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: secondaryColor,
                          size: SizeConfig.height20(context),
                        ),
                        onTap: () => _switchPage(),
                      ),
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

  void _switchPage() {
    // Perform the fade transition to the next page
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const HomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween = Tween(begin: begin, end: end);
          var offsetAnimation =
              animation.drive(tween.chain(CurveTween(curve: curve)));
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(position: offsetAnimation, child: child),
          );
        },
      ),
    );
  }
}
