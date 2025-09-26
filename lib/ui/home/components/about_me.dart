import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:umair_liaqat/models/user_model.dart';
import 'package:umair_liaqat/ui/widgets/common_widgets/my_photo.dart';
import 'package:umair_liaqat/utils/app_extensions.dart';
import 'package:umair_liaqat/utils/app_sizes.dart';
import 'package:umair_liaqat/utils/app_strings.dart';
import 'package:umair_liaqat/utils/app_theme.dart';
import 'package:universal_html/html.dart' as html;

class AboutMe extends StatelessWidget {
  final UserModel? userModel;
  const AboutMe({
    super.key,
    this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      bool isMobile = constraints.maxWidth < 600;
      if (isMobile) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const MyPhoto(),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.helloIAm,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: PortfolioAppTheme.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  SizedBox(height: context.height * 0.01),
                  Text(
                    userModel?.name ?? "",
                    style: context.width > 456
                        ? Theme.of(context).textTheme.displayLarge!.copyWith(
                            color: PortfolioAppTheme.nameColor,
                            fontWeight: FontWeight.w700)
                        : Theme.of(context).textTheme.displayMedium!.copyWith(
                            color: PortfolioAppTheme.nameColor,
                            fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: context.height * 0.01),
                  AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [
                      TyperAnimatedText(
                        userModel?.headline1 ?? "",
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                        speed: const Duration(milliseconds: 120),
                      ),
                      TyperAnimatedText(
                        userModel?.headline2 ?? "",
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                        speed: const Duration(milliseconds: 100),
                      ),
                    ],
                    isRepeatingAnimation: true,
                  ),
                  SizedBox(height: context.height * 0.02),
                  SizedBox(
                    height: context.height * 0.042,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        html.window.open(AppConstants.resume, "pdf");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PortfolioAppTheme.white,
                      ),
                      icon: const Icon(Icons.download,
                          color: PortfolioAppTheme.nameColor),
                      label: FittedBox(
                        child: Text(
                          AppStrings.downloadResume,
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: PortfolioAppTheme.greyButtonColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: context.height * 0.03),
                  Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      width: context.width * 0.6,
                      child:
                          //  context.width > 550?
                          Text(
                        userModel?.description ?? "",
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.white,
                                ),
                        // softWrap: true,
                      ),
                      // : const SizedBox(),
                    ),
                  )
                ],
              ),
              // SizedBox(width: context.width * 0.03),
            ],
          ),
        );
      } else {
        return Padding(
          padding: AppSizes.appPadding(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.helloIAm,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: PortfolioAppTheme.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    SizedBox(height: context.height * 0.01),
                    Text(
                      userModel?.name ?? "",
                      style: context.width > 456
                          ? Theme.of(context).textTheme.displayLarge!.copyWith(
                              color: PortfolioAppTheme.nameColor,
                              fontWeight: FontWeight.w700)
                          : Theme.of(context).textTheme.displayMedium!.copyWith(
                              color: PortfolioAppTheme.nameColor,
                              fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: context.height * 0.01),
                    AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: [
                        TyperAnimatedText(
                          userModel?.headline1 ?? "",
                          textStyle: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.w400),
                          speed: const Duration(milliseconds: 120),
                        ),
                        TyperAnimatedText(
                          userModel?.headline2 ?? "",
                          textStyle: Theme.of(context).textTheme.titleMedium,
                          speed: const Duration(milliseconds: 100),
                        ),
                      ],
                      isRepeatingAnimation: true,
                    ),
                    SizedBox(height: context.height * 0.02),
                    SizedBox(
                      height: context.height * 0.042,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          html.window.open(AppConstants.resume, "pdf");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PortfolioAppTheme.white,
                        ),
                        icon: const Icon(Icons.download,
                            color: PortfolioAppTheme.nameColor),
                        label: FittedBox(
                          child: Text(
                            AppStrings.downloadResume,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: PortfolioAppTheme.greyButtonColor,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: context.height * 0.03),
                    Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                        width: context.width * 0.6,
                        child: context.width > 550
                            ? Text(
                                userModel?.description ?? "",
                                style: Theme.of(context).textTheme.titleMedium,
                                // softWrap: true,
                              )
                            : const SizedBox(),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(width: context.width * 0.03),
              MyPhoto(
                picture: userModel?.profilePicture,
              ),
              SizedBox(width: context.width * 0.11)
            ],
          ),
        );
      }
    });
  }
}
