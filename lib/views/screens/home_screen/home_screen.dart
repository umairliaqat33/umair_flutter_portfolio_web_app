import 'package:flutter/material.dart';
import 'package:umair_liaqat_portfolio/config/size_config.dart';
import 'package:umair_liaqat_portfolio/utils/assets.dart';
import 'package:umair_liaqat_portfolio/utils/colors.dart';
import 'package:umair_liaqat_portfolio/views/widgets/buttons/custom_button.dart';
import 'package:umair_liaqat_portfolio/views/widgets/container_widgets.dart/project_container_widget.dart';
import 'package:umair_liaqat_portfolio/views/widgets/container_widgets.dart/service_container_widget.dart';
import 'package:umair_liaqat_portfolio/views/widgets/text_widgets/heading_text_widget.dart';
import 'package:umair_liaqat_portfolio/views/widgets/text_widgets/normal_text_widget.dart';

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
                            HeadingTextWidget(
                              'Hello I\'m,',
                              fontSize: SizeConfig.font10(context),
                              fontWeight: FontWeight.w300,
                            ),
                            HeadingTextWidget(
                              "Umair Liaqat",
                              fontSize: SizeConfig.font24(context),
                            ),
                            const NormalTextWidget(
                              "A passionate Flutter developer more than 1.5 years. With hands-on experience in creating feature-rich, user-friendly apps. I specialize in crafting solutions that include firebase as database.",
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
                const HeadingTextWidget(
                  "About me",
                ),
                SizedBox(
                  height: SizeConfig.height1(context),
                ),
                const NormalTextWidget(
                  "Greetings! I'm Umair Liaqat, a dedicated professional with over year of experience in flutter. My journey in the tech world began over a year ago, and I've been immersed in the exciting realm of Flutter ever since. I also have three years of experience in the dynamic call center industry, specializing in both Tele Sales and Customer Support.",
                ),
                SizedBox(
                  height: SizeConfig.height1(context),
                ),
                const HeadingTextWidget(
                  "Services i offer:",
                ),
                SizedBox(
                  height: SizeConfig.height1(context),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ServiceContainerWidget(
                      title: 'Mobile App',
                      iconData: Icons.flutter_dash_outlined,
                      child:
                          'I am a Junior Flutter developer. I can help you building your dream app. In my experience of a year i have worked on several succesfull applications',
                    ),
                    ServiceContainerWidget(
                      title: 'Customer Support',
                      iconData: Icons.headphones,
                      child:
                          'I have helped many organizations in building their customer base and generating their sales. I have also helped them to streamline their support processes.',
                    ),
                  ],
                ),
                ProjectContainerWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
