import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PortfolioAppTheme {
  static const Color primary = Color(0xFF2C2C2F);
  static const Color normalTextColor = Colors.white;
  static const Color greyButtonColor = Color(0xFF5E5E60);
  static const Color nameColor = Color(0xFFf9a51f);
  static const white = Color(0xFFFFFFFF);
  static const blue = Colors.blue;

  static ThemeData baseTheme() {
    final themeData = ThemeData.dark();

    final theme = themeData.copyWith(
      scaffoldBackgroundColor: PortfolioAppTheme.greyButtonColor,
      primaryColor: primary,
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          color: Colors.black,
        ),
        labelStyle: TextStyle(
          color: Colors.black,
        ),
        errorStyle: TextStyle(
          color: Colors.red,
        ),
      ),
      textTheme: GoogleFonts.poppinsTextTheme().copyWith(
        bodyLarge: TextStyle(
          color: Colors.black,
        ),
        bodyMedium: TextStyle(
          color: Colors.white,
        ),
        bodySmall: TextStyle(
          color: Colors.white,
        ),
        titleMedium: TextStyle(
          color: white,
        ),
      ),
    );
    return theme.copyWith();
  }
}

extension ThemeExtras on ThemeData {
  Color get secondaryColor => const Color(0xFFFE53BB);
}

InputDecoration textFieldDecoration = InputDecoration(
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.white,
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.white,
    ),
  ),
);
