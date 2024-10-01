import 'package:flutter/material.dart';
import 'package:umair_liaqat_portfolio/config/size_config.dart';
import 'package:umair_liaqat_portfolio/utils/colors.dart';
import 'package:umair_liaqat_portfolio/views/widgets/text_widgets/normal_text_widget.dart';

class TextTileWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final String icon;
  const TextTileWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          icon,
          style: TextStyle(
            fontSize: SizeConfig.font4(context),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: SizeConfig.font4(context),
            fontWeight: FontWeight.bold,
          ),
        ),
        Flexible(
          child: NormalTextWidget(
            subTitle,
            fontColor: blackColor,
            fontSize: SizeConfig.font4(context),
          ),
        ),
      ],
    );
  }
}
