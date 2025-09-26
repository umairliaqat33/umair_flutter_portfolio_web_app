import 'package:umair_liaqat/utils/app_strings.dart';

class ValidatorUtils {
  static String? emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.emailRequired;
    } else if (value.isEmpty) {
      return AppStrings.emailRequired;
    } else if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}\$")
        .hasMatch(value)) {
      return AppStrings.enterValidEmail;
    } else {
      return null;
    }
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.passwordRequired;
    } else if (value.isEmpty) {
      return AppStrings.passwordRequired;
    } else if (value.length < 8) {
      return AppStrings.passwordMinimumLength;
    } else {
      return null;
    }
  }

  static String? customValidatorValidator(
    String? value,
    String message,
  ) {
    if (value == null || value.trim().isEmpty) {
      return message;
    } else if (value.isEmpty) {
      return message;
    } else {
      return null;
    }
  }
}
