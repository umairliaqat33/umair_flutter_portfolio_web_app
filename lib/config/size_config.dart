import 'package:flutter/material.dart';

class SizeConfig {
  static double? _screenWidth;
  static double? _screenHeight;
  static double? _blockWidth;
  static double? _blockHeight;

  static double? _safeBlockWidth;
  static double? _safeBlockHeight;

  static void init(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;

    // Blocks for relative size calculation
    _blockWidth = _screenWidth! / 100;
    _blockHeight = _screenHeight! / 100;

    // Safe area handling (for devices with notches, etc.)
    final double safeAreaHorizontal =
        mediaQuery.padding.left + mediaQuery.padding.right;
    final double safeAreaVertical =
        mediaQuery.padding.top + mediaQuery.padding.bottom;

    _safeBlockWidth = (_screenWidth! - safeAreaHorizontal) / 100;
    _safeBlockHeight = (_screenHeight! - safeAreaVertical) / 100;
  }

  // Screen width and height access
  static double width(BuildContext context) {
    init(context);
    return _screenWidth ?? 0;
  }

  static double height(BuildContext context) {
    init(context);
    return _screenHeight ?? 0;
  }

  // Relative to screen height (for vertical space)
  static double heightPercentage(BuildContext context, double percentage) =>
      _blockHeight! * percentage;

  // Relative to screen width (for horizontal space)
  static double widthPercentage(BuildContext context, double percentage) =>
      _blockWidth! * percentage;

  // Font sizes (based on width for better scaling)
  static double fontSize(BuildContext context, double percentage) =>
      _safeBlockWidth! * percentage;

  // Responsive paddings and margins
  static double padding(BuildContext context, double percentage) =>
      _safeBlockHeight! * percentage;

  // Examples of predefined sizes
  static double height1(BuildContext context) => heightPercentage(context, 1);
  static double height3(BuildContext context) => heightPercentage(context, 3);
  static double height5(BuildContext context) => heightPercentage(context, 5);
  static double height8(BuildContext context) => heightPercentage(context, 8);
  static double height10(BuildContext context) => heightPercentage(context, 10);
  static double height15(BuildContext context) => heightPercentage(context, 15);
  static double height20(BuildContext context) => heightPercentage(context, 20);
  static double height25(BuildContext context) => heightPercentage(context, 25);
  static double height30(BuildContext context) => heightPercentage(context, 30);
  static double height35(BuildContext context) => heightPercentage(context, 35);
  static double height40(BuildContext context) => heightPercentage(context, 40);
  static double height45(BuildContext context) => heightPercentage(context, 45);
  static double height50(BuildContext context) => heightPercentage(context, 50);

  //width
  static double width5(BuildContext context) => widthPercentage(context, 5);
  static double width8(BuildContext context) => widthPercentage(context, 8);
  static double width10(BuildContext context) => widthPercentage(context, 10);
  static double width15(BuildContext context) => widthPercentage(context, 15);
  static double width20(BuildContext context) => widthPercentage(context, 20);
  static double width25(BuildContext context) => widthPercentage(context, 25);
  static double width30(BuildContext context) => widthPercentage(context, 30);
  static double width35(BuildContext context) => widthPercentage(context, 35);
  static double width40(BuildContext context) => widthPercentage(context, 40);
  static double width45(BuildContext context) => widthPercentage(context, 45);
  static double width50(BuildContext context) => widthPercentage(context, 50);

  // Example of predefined font sizes
  static double font4(BuildContext context) => fontSize(context, 1);
  static double font6(BuildContext context) => fontSize(context, 1.5);
  static double font8(BuildContext context) => fontSize(context, 2);
  static double font10(BuildContext context) => fontSize(context, 2.5);
  static double font12(BuildContext context) => fontSize(context, 3);
  static double font14(BuildContext context) => fontSize(context, 3.5);
  static double font16(BuildContext context) => fontSize(context, 4);
  static double font20(BuildContext context) => fontSize(context, 5);
  static double font22(BuildContext context) => fontSize(context, 5.5);
  static double font24(BuildContext context) => fontSize(context, 6);
  static double font26(BuildContext context) => fontSize(context, 6.5);
  static double font28(BuildContext context) => fontSize(context, 7);
  static double font30(BuildContext context) => fontSize(context, 7.5);
  static double font32(BuildContext context) => fontSize(context, 8);
  static double font34(BuildContext context) => fontSize(context, 8.5);

  static double headingFont(BuildContext context) => fontSize(context, 2.5);
  static double normalFont(BuildContext context) => fontSize(context, 1.5);

  // Example of predefined paddings
  static double pad8(BuildContext context) => padding(context, 2);
  static double pad12(BuildContext context) => padding(context, 3);
}
