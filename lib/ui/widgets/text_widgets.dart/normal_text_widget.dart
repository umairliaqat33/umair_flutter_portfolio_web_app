import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NormalTextWidget extends StatelessWidget {
  final String text;
  final Color? textColor;
  final double? fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final TextOverflow textOverflow;
  final FontStyle? fontStyle;
  final int? maxLines;
  final double? letterSpacing;
  const NormalTextWidget(
    this.text, {
    super.key,
    this.textColor,
    this.fontSize,
    this.fontWeight = FontWeight.w400,
    this.textAlign = TextAlign.start,
    this.textOverflow = TextOverflow.visible,
    this.fontStyle,
    this.maxLines,
    this.letterSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize ?? 16.sp,
        fontWeight: fontWeight,
        color: textColor,
        overflow: textOverflow,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
      ),
    );
  }
}
