import 'package:flutter/material.dart';
import 'package:umair_liaqat_portfolio/config/size_config.dart';
import 'package:umair_liaqat_portfolio/utils/assets.dart';
import 'package:umair_liaqat_portfolio/utils/colors.dart';
import 'package:umair_liaqat_portfolio/views/widgets/aler_dialog/see_more_alert_dialog.dart';
import 'package:umair_liaqat_portfolio/views/widgets/text_widgets/normal_text_widget.dart';

class ProjectContainerWidget extends StatefulWidget {
  const ProjectContainerWidget({super.key});

  @override
  State<ProjectContainerWidget> createState() => _ProjectContainerWidgetState();
}

class _ProjectContainerWidgetState extends State<ProjectContainerWidget> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => changeCententColor(true),
      onExit: (event) => changeCententColor(false),
      child: Container(
        width: SizeConfig.width30(context),
        padding: EdgeInsets.all(
          SizeConfig.pad8(context),
        ),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(
              SizeConfig.height3(context),
            ),
          ),
        ),
        child: Center(
          child: Stack(
            children: [
              isHover
                  ? ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5),
                        BlendMode.darken,
                      ),
                      child: Image.asset(
                        Assets.frelancersCalendar,
                        fit: BoxFit.cover, // Ensures the image fills the space
                      ),
                    )
                  : Image.asset(
                      Assets.frelancersCalendar,
                      fit: BoxFit.cover, // Ensures the image fills the space
                    ),
              isHover
                  ? Positioned(
                      top: SizeConfig.height40(context),
                      width: SizeConfig.width20(context),
                      child: GestureDetector(
                        onTap: () => _seeMoreTap(),
                        child: const Center(
                          child: NormalTextWidget(
                            "See more",
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  void changeCententColor(
    bool isHover,
  ) {
    this.isHover = isHover;
    setState(() {});
  }

  void _seeMoreTap() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const SeeMoreAlertDialog(
          title: "Freelancers Calendar",
          isCarousel: false,
        );
      },
    );
  }
}
