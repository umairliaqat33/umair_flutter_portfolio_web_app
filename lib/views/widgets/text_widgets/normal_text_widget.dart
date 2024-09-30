import 'package:flutter/material.dart';
import 'package:umair_liaqat_portfolio/config/size_config.dart';
import 'package:umair_liaqat_portfolio/utils/colors.dart';

class NormalTextWidget extends StatelessWidget {
  final String text;
  final Color? fontColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  const NormalTextWidget(
    this.text, {
    super.key,
    this.fontColor = whiteColor,
    this.fontSize,
    this.fontWeight = FontWeight.w300,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize ?? SizeConfig.normalFont(context),
        color: fontColor,
        fontWeight: fontWeight,
      ),
    );
  }
}
