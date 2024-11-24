import 'package:flutter/material.dart';

class WebSizeConfig {
  static double screenWidth = 0;
  static double screenHeight = 0;
  static double blockSizeHorizontal = 0;
  static double blockSizeVertical = 0;

  static double textMultiplier = 0;
  static double imageSizeMultiplier = 0;
  static double heightMultiplier = 0;
  static double widthMultiplier = 0;

  static void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    // Define a base design size (e.g., typical desktop width and height)
    double designWidth = 1440; // Base width for a web app (can be adjusted)
    double designHeight = 1024; // Base height for a web app (can be adjusted)

    blockSizeHorizontal = screenWidth / designWidth;
    blockSizeVertical = screenHeight / designHeight;

    textMultiplier = blockSizeVertical;
    imageSizeMultiplier = blockSizeHorizontal;
    heightMultiplier = blockSizeVertical;
    widthMultiplier = blockSizeHorizontal;
  }

  // Padding helpers
  static hPad(double value) => heightMultiplier * value;
  static wPad(double value) => widthMultiplier * value;

  // Dynamic height helpers
  static height(double value) => heightMultiplier * value;

  // Dynamic width helpers
  static width(double value) => widthMultiplier * value;

  // Font size helpers
  static fontSize(double value) => textMultiplier * value;

  // Common values for consistent design
  static const double smallBorderRadius = 8;
  static const double mediumBorderRadius = 16;
  static const double largeBorderRadius = 24;

  static const double defaultAppBarHeight = 56;
  static const double defaultBottomNavBarHeight = 64;

  // Get keyboard height for input responsiveness
  static double getKeyboardBottomPadding(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom;
  }
}
