import 'package:supabase_flutter/supabase_flutter.dart';

class Collections {
  static final supabase = Supabase.instance.client;
  static String users = "users";
  static String jobHistory = "job_history";
  static String qualifications = "qualifications";
  static String storageBucketId = "portfolio";
  static String projects = "projects";
}
