import 'package:flutter/material.dart';
import 'package:umair_liaqat_portfolio/config/size_config.dart';
import 'package:umair_liaqat_portfolio/utils/colors.dart';

class HeadingTextWidget extends StatelessWidget {
  final String text;
  final Color? fontColor;
  final double? fontSize;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  const HeadingTextWidget(
    this.text, {
    super.key,
    this.fontColor = whiteColor,
    this.fontSize,
    this.textAlign = TextAlign.start,
    this.fontWeight = FontWeight.bold,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize ?? SizeConfig.headingFont(context),
        color: fontColor,
        fontWeight: fontWeight,
      ),
    );
  }
}
