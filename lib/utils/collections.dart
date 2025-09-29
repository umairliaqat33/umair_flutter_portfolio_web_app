import 'package:supabase_flutter/supabase_flutter.dart';

class Collections {
  static final supabase = Supabase.instance.client;
  static String api = '/api/';
  static String supabaseUsers = "users";
  static String user = "${api}user";
  static String auth = "${api}auth";
  static String jobHistory = "job_history";
  static String qualifications = "${api}qualification";
  static String storageBucketId = "portfolio";
  static String projects = "projects";
}

class ApiEndpoints {
  static String login = "${Collections.auth}/login";
  static String getUser = "${Collections.user}/user";
  static String getUserWithoutToken = "${Collections.user}/tokenLessUser";
  static String addQualification = "${Collections.qualifications}/";
  static String updateQualification = "${Collections.qualifications}/";
}
