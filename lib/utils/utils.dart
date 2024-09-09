import 'package:umair_liaqat_portfolio/constants/constants.dart';

class Utils {
  static String? emailValidator(String? value) {
    if (value!.isEmpty) {
      return "Email required";
    } else if (!RegExp(emailPatter).hasMatch(value)) {
      return "Enter a valid email";
    } else {
      return null;
    }
  }

  static String? passwordValidator(String? value) {
    if (value!.isEmpty) {
      return "Password required";
    } else if (value.length < 8) {
      return "Minimum 8 character required in password";
    } else {
      return null;
    }
  }

  static String? nameValidator(String? value) {
    if (value!.isEmpty) {
      return "Name required";
    } else {
      return null;
    }
  }

  static String? locationValidator(String? value) {
    if (value!.isEmpty) {
      return "Location is required";
    } else {
      return null;
    }
  }

  static String? rateValidator(String? value) {
    if (value!.isEmpty) {
      return "Rate is required";
    } else {
      return null;
    }
  }

  static String? simpleValidator(String? value) {
    if (value!.isEmpty) {
      return "This field is required";
    } else {
      return null;
    }
  }

  static String? subjectValidator(String? value) {
    if (value!.isEmpty) {
      return "Subject is required";
    } else {
      return null;
    }
  }

  static String? phoneNumberValidator(String? value) {
    if (value!.isEmpty) {
      return "Phone number required";
    }
    if (!RegExp(
            r'^(?:\+1\s?)?\(?([2-9][0-9]{2})\)?[\s.-]?([2-9][0-9]{2})[\s.-]?([0-9]{4})$')
        .hasMatch(value)) {
      return "Enter a valid phone";
    }
    return null;
  }

  static String? messageValidator(String? value) {
    if (value!.isEmpty) {
      return "Message is required";
    } else {
      return null;
    }
  }
}
