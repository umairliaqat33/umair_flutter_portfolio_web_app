import 'package:flutter/material.dart';

class SizeConfig {
  static double? _screenWidth;
  static double? _screenHeight;

  static void init(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
  }

  static double width(BuildContext context) {
    init(context);
    return _screenWidth ?? 0;
  }

  static double height(BuildContext context) {
    init(context);
    return _screenHeight ?? 0;
  }

  static double height5(BuildContext context) => height(context) * 0.03;
  static double height8(BuildContext context) => height(context) * 0.05;
  static double height10(BuildContext context) => height(context) * 0.07;
  static double height12(BuildContext context) => height(context) * 0.09;
  static double height15(BuildContext context) => height(context) * 0.12;
  static double height20(BuildContext context) => height(context) * 0.15;

  static double width5(BuildContext context) => width(context) * 0.03;
  static double width8(BuildContext context) => width(context) * 0.05;
  static double width10(BuildContext context) => width(context) * 0.07;
  static double width12(BuildContext context) => width(context) * 0.09;
  static double width15(BuildContext context) => width(context) * 0.12;
  static double width20(BuildContext context) => width(context) * 0.15;

  static double font10(BuildContext context) => height(context) * 0.07;
  static double font12(BuildContext context) => height(context) * 0.09;
  static double font14(BuildContext context) => height(context) * 0.12;
  static double font16(BuildContext context) => height(context) * 0.15;
  static double font18(BuildContext context) => height(context) * 0.18;
  static double font20(BuildContext context) => height(context) * 0.21;
  static double font22(BuildContext context) => height(context) * 0.24;
  static double font24(BuildContext context) => height(context) * 0.27;
  static double font28(BuildContext context) => height(context) * 0.32;

  static double pad8(BuildContext context) => height(context) * 0.05;
  static double pad12(BuildContext context) => height(context) * 0.09;
  static double pad14(BuildContext context) => height(context) * 0.12;
  static double pad16(BuildContext context) => height(context) * 0.15;
  static double pad20(BuildContext context) => height(context) * 0.18;
  static double pad24(BuildContext context) => height(context) * 0.21;
}
