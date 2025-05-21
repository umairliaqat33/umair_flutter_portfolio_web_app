class AppConstants {
  static const String resume =
      'https://drive.google.com/file/d/1ON4gsfxDJSGv6qJzI0CkDB65muAu5dik/view?usp=sharing';
  static const String cv =
      'https://drive.google.com/file/d/1hsqVAIV0WZTa5ZO5IWjfgX8qIF4yYycD/view?usp=sharing';
  static const String whatsapp =
      'https://api.whatsapp.com/send?phone=923134146206';
  static const String linkedIn =
      'https://www.linkedin.com/in/umair-liaqat-305450228/';
  static const String github = 'https://github.com/umairliaqat33';
}

class Strings {
  static String passwordRequired = "Password is required";

  static String passwordMinimumLength =
      "Minimum 8 character required in password";

  static String emailRequired = "Email required";
  static String password = "Password";
  static String email = "Email";
  static String headline1 = "Headline 1";
  static String headline2 = "Headline 2";
  static String description = "Description";
  static String institute = "Institute";
  static String degreeName = "Degree Name";
  static String completionYear = "Completion Year";
  static String sortingIndex = "Sorting Index (At what index will this show?)";
  static String profilePictureSize =
      "Picture's dimensions must be 2494 x 2494.";
  static String addADegree = "Add a degree";
  static String enterValidEmail = "Enter a valid email";
  static String addAProject = "Add a project";
  static String addWorkHistory = "Add work history";
  static String aDD = "Add";

  static String jobPosition = "Job Position";
  static String organization = "Organization";
  static String fromDate = "From Date";
  static String toDate = "To Date";
  static String jobDescription = "Job Description";
  static String projectName = "Project Name";
  static String projectDescription = "Project description";
  static String projectUrl = "Project link";
  static String phoneNumber = "Phone Number";
  static String gitHub = "Github";
  static String linkedIn = "LinkedIn";
  static String selectProjectFiles = "Select files to view (pictures only)";
  static String isRequired(String value) {
    return "$value is required";
  }

  static String enterValue(String value) {
    return "Enter $value";
  }
}

const List<String> imageExtensions = ['jpg', 'jpeg', 'png'];
