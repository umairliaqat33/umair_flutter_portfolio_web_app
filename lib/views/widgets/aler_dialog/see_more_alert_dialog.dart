import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:umair_liaqat_portfolio/config/size_config.dart';
import 'package:umair_liaqat_portfolio/utils/colors.dart';
import 'package:umair_liaqat_portfolio/views/widgets/text_widgets/normal_text_widget.dart';
import 'package:umair_liaqat_portfolio/views/widgets/text_widgets/text_tile_widget.dart';
import 'package:umair_liaqat_portfolio/views/widgets/video_player_screen.dart';

class SeeMoreAlertDialog extends StatelessWidget {
  final String title;
  final bool isCarousel;
  final List<String>? imagesList;
  const SeeMoreAlertDialog({
    super.key,
    required this.title,
    required this.isCarousel,
    this.imagesList,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NormalTextWidget(
            title,
            fontColor: secondaryColor,
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close),
          )
        ],
      ),
      content: isCarousel
          ? InfiniteCarousel.builder(
              itemCount: imagesList!.length,
              itemExtent: SizeConfig.width40(context),
              itemBuilder:
                  (BuildContext context, int itemIndex, int realIndex) {
                return Image.asset(imagesList![itemIndex]);
              },
            )
          : SingleChildScrollView(
              child: SizedBox(
                width: SizeConfig.width50(context),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        width: SizeConfig.width20(context),
                        height: SizeConfig.height40(context) * 2,
                        child: const VideoPlayerScreen(),
                      ),
                      SizedBox(
                        height: SizeConfig.height5(context),
                      ),
                      SizedBox(
                        width: SizeConfig.width40(context),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const NormalTextWidget(
                                fontColor: blackColor,
                                "This app is designed to streamline the lives of freelancers by offering a comprehensive solution for managing bookings, tracking earnings, and organizing schedules—all in one place."),
                            const NormalTextWidget(
                              fontColor: blackColor,
                              "Key Features:",
                              fontWeight: FontWeight.w600,
                            ),
                            const TextTileWidget(
                              title: "Calendar Integration:",
                              subTitle:
                                  "Easily manage and view your freelance jobs, bookings, and important dates.",
                              icon: '📆 ',
                            ),
                            const TextTileWidget(
                              title: " Earnings Tracking: ",
                              subTitle:
                                  "Keep track of your income from different jobs, displayed in a user-friendly bar chart.",
                              icon: "💰",
                            ),
                            const TextTileWidget(
                              title: "Company_Management: ",
                              subTitle:
                                  "Manage your clients and companies, including per-hour rates and job details.",
                              icon: '🏢',
                            ),
                            const TextTileWidget(
                              title: "Localization: ",
                              subTitle:
                                  "The app supports multiple languages, making it accessible to a global audience.",
                              icon: "🌐",
                            ),
                            const TextTileWidget(
                              title: "Deep Linking: ",
                              subTitle:
                                  "Integrated deep linking to navigate seamlessly from the Contact screen directly to Gmail for quick communication with clients or support.",
                              icon: "📲",
                            ),
                            const TextTileWidget(
                              title: "State Management GETX: ",
                              subTitle:
                                  "Getx state management was used in it to make application less network consuming and to make it efficient and fast.",
                              icon: "👨🏻‍💼",
                            ),
                            const TextTileWidget(
                              title: "Secure Authentication: ",
                              subTitle:
                                  "Simple and secure email authentication using Firebase.",
                              icon: "🔒",
                            ),
                            const TextTileWidget(
                              title: "Data Storage: ",
                              subTitle:
                                  "Efficient data management with Firebase as the backend and local storage using SharedPreferences.",
                              icon: "☁️",
                            ),
                            const TextTileWidget(
                              title: "Media_Integration: ",
                              subTitle:
                                  "Easily upload and manage images for your job entries.",
                              icon: "📷",
                            ),
                            NormalTextWidget(
                              fontColor: blackColor,
                              "This project was a fantastic learning experience, from integrating deep linking to working with Firebase and handling localization.",
                              fontSize: SizeConfig.font4(context),
                            ),
                          ],
                        ),
                      ),
                      NormalTextWidget(
                          fontSize: SizeConfig.font4(context),
                          "#AppDevelopment #Flutter #Freelance #MobileApp #Firebase #Localization #DeepLinking #ProductivityTools #Fiverr #Dart#Freelancer #Getx #GETX"),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
