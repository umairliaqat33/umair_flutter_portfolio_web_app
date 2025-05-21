import 'package:umair_liaqat/utils/app_strings.dart';

class ValidatorUtils {
  static String? emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return Strings.emailRequired;
    } else if (value.isEmpty) {
      return Strings.emailRequired;
    } else if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}\$")
        .hasMatch(value)) {
      return Strings.enterValidEmail;
    } else {
      return null;
    }
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return Strings.passwordRequired;
    } else if (value.isEmpty) {
      return Strings.passwordRequired;
    } else if (value.length < 8) {
      return Strings.passwordMinimumLength;
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
