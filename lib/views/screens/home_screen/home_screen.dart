import 'package:flutter/material.dart';
import 'package:umair_liaqat_portfolio/config/size_config.dart';
import 'package:umair_liaqat_portfolio/utils/assets.dart';
import 'package:umair_liaqat_portfolio/utils/colors.dart';
import 'package:umair_liaqat_portfolio/views/widgets/buttons/custom_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final ScrollController _scrollController =
  //     ScrollController(); // Create a ScrollController
  final GlobalKey _widgetBKey = GlobalKey();

  void _scrollToWidgetB() {
    final contextB = _widgetBKey.currentContext;
    if (contextB != null) {
      Scrollable.ensureVisible(
        contextB,
        duration: const Duration(seconds: 1), // Animate the scroll
        curve: Curves.easeInOut, // Add easing to the scroll
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(
            left: SizeConfig.width8(context),
            right: SizeConfig.width8(context),
          ),
          height: SizeConfig.height(context),
          width: SizeConfig.width(context),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                primaryColor,
                secondaryColor,
              ],
              end: Alignment.centerLeft,
              begin: Alignment.centerRight,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: SizeConfig.height(context),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: SizeConfig.width30(context) * 1.2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Hello, I'm",
                              style: TextStyle(
                                fontSize: SizeConfig.font10(context),
                                color: whiteColor,
                              ),
                            ),
                            Text(
                              "Umair Liaqat",
                              style: TextStyle(
                                fontSize: SizeConfig.font24(context),
                                fontWeight: FontWeight.bold,
                                color: whiteColor,
                              ),
                            ),
                            Text(
                              "A passionate Flutter developer more than 1.5 years. With hands-on experience in creating feature-rich, user-friendly apps. I specialize in crafting solutions that include firebase as database.",
                              style: TextStyle(
                                fontSize: SizeConfig.font6(context),
                                color: whiteColor,
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.height5(context),
                            ),
                            Center(
                              child: CustomButton(
                                onTap: () => _scrollToWidgetB(),
                                title: "My Projects",
                              ),
                            ),
                          ],
                        ),
                      ),
                      Image.asset(
                        height: SizeConfig.height50(context) * 2,
                        width: SizeConfig.width30(context),
                        Assets.profileImage,
                      ),
                    ],
                  ),
                ),
                Text(
                  "About Me",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: SizeConfig.headingFont(context),
                    color: whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.height3(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
