import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PortfolioAppTheme {
  static const Color primary = Color(0xFF2C2C2F);
  static const Color greyButtonColor = Color(0xFF5E5E60);
  static const Color nameColor = Color(0xFFf9a51f);
  static const white = Color(0xFFFFFFFF);
  static const blue = Colors.blue;

  static ThemeData baseTheme() {
    final themeData = ThemeData.dark();

    final theme = themeData.copyWith(
      primaryColor: primary,
      textTheme: GoogleFonts.poppinsTextTheme(),
    );
    return theme.copyWith(
        textTheme: theme.textTheme.copyWith(
            titleMedium: theme.textTheme.titleMedium!.copyWith(color: white)));
  }
}

extension ThemeExtras on ThemeData {
  Color get secondaryColor => const Color(0xFFFE53BB);
}
