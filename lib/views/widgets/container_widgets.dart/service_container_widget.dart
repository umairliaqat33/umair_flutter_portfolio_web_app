import 'package:flutter/material.dart';
import 'package:umair_liaqat_portfolio/config/size_config.dart';
import 'package:umair_liaqat_portfolio/utils/colors.dart';
import 'package:umair_liaqat_portfolio/views/widgets/text_widgets/heading_text_widget.dart';
import 'package:umair_liaqat_portfolio/views/widgets/text_widgets/normal_text_widget.dart';

class ServiceContainerWidget extends StatefulWidget {
  final String title;
  final String child;
  final IconData iconData;
  const ServiceContainerWidget({
    super.key,
    required this.title,
    required this.child,
    required this.iconData,
  });

  @override
  State<ServiceContainerWidget> createState() => _ServiceContainerWidgetState();
}

class _ServiceContainerWidgetState extends State<ServiceContainerWidget> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => changeCententColor(true),
      onExit: (event) => changeCententColor(false),
      child: Container(
        height: SizeConfig.height30(context),
        width: SizeConfig.width30(context),
        padding: EdgeInsets.all(SizeConfig.pad12(context)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(
              SizeConfig.height3(context),
            ),
          ),
          border: Border.all(
            color: isHover ? secondaryColor : whiteColor,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  widget.iconData,
                  size: SizeConfig.height8(context),
                  color: isHover ? secondaryColor : whiteColor,
                ),
                SizedBox(
                  width: SizeConfig.height1(context),
                ),
                HeadingTextWidget(
                  widget.title,
                  textAlign: TextAlign.center,
                  fontColor: isHover ? secondaryColor : whiteColor,
                ),
              ],
            ),
            NormalTextWidget(
              widget.child,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              textAlign: TextAlign.left,
              fontColor: isHover ? secondaryColor : whiteColor,
            )
          ],
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
}
