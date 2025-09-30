import 'package:supabase_flutter/supabase_flutter.dart';

class Collections {
  static final supabase = Supabase.instance.client;
  static String api = '/api/';
  static String supabaseUsers = "users";
  static String user = "${api}user";
  static String auth = "${api}auth";
  static String jobHistory = "job_history";
  static String qualifications = "${api}qualification";
  static String job = "${api}job";
  static String projects = "${api}project";
  static String storageBucketId = "portfolio";
}

class ApiEndpoints {
  static String login = "${Collections.auth}/login";
  static String getUser = "${Collections.user}/user";
  static String contactForm = "${Collections.user}/contact";
  static String getUserWithoutToken = "${Collections.user}/tokenLessUser";
  static String qualificationCrudRoute = "${Collections.qualifications}/";
  static String jobHistoryCrudRoute = "${Collections.job}/";
  static String projectCrudRoute = "${Collections.projects}/";
}
