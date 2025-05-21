// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:umair_liaqat/models/job_history.dart';
import 'package:umair_liaqat/models/project_model.dart';
import 'package:umair_liaqat/models/qualification_model.dart';

class UserModel {
  final String? name;
  final String? email;
  final String? profilePicture;
  final String? headline1;
  final String? headline2;
  final String? phoneNumber;
  final String? linkedIn;
  final String? github;
  final List<QualificationModel> qualifications;
  final List<ProjectModel> projects;
  final List<JobHistory> jobs;
  UserModel({
    this.name,
    this.email,
    this.profilePicture,
    this.headline1,
    this.headline2,
    this.phoneNumber,
    this.linkedIn,
    this.github,
    required this.qualifications,
    required this.projects,
    required this.jobs,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? profilePicture,
    String? headline1,
    String? headline2,
    String? phoneNumber,
    String? linkedIn,
    String? github,
    List<QualificationModel>? qualifications,
    List<ProjectModel>? projects,
    List<JobHistory>? jobs,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      profilePicture: profilePicture ?? this.profilePicture,
      headline1: headline1 ?? this.headline1,
      headline2: headline2 ?? this.headline2,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      linkedIn: linkedIn ?? this.linkedIn,
      github: github ?? this.github,
      qualifications: qualifications ?? this.qualifications,
      projects: projects ?? this.projects,
      jobs: jobs ?? this.jobs,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'profilePicture': profilePicture,
      'headline1': headline1,
      'headline2': headline2,
      'phoneNumber': phoneNumber,
      'linkedIn': linkedIn,
      'github': github,
      'qualifications': qualifications.map((x) => x.toMap()).toList(),
      'projects': projects.map((x) => x.toMap()).toList(),
      'jobs': jobs.map((x) => x.toMap()).toList(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      profilePicture: map['profilePicture'] != null
          ? map['profilePicture'] as String
          : null,
      headline1: map['headline1'] != null ? map['headline1'] as String : null,
      headline2: map['headline2'] != null ? map['headline2'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      linkedIn: map['linkedIn'] != null ? map['linkedIn'] as String : null,
      github: map['github'] != null ? map['github'] as String : null,
      qualifications: List<QualificationModel>.from(
        (map['qualifications'] as List<int>).map<QualificationModel>(
          (x) => QualificationModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      projects: List<ProjectModel>.from(
        (map['projects'] as List<int>).map<ProjectModel>(
          (x) => ProjectModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      jobs: List<JobHistory>.from(
        (map['jobs'] as List<int>).map<JobHistory>(
          (x) => JobHistory.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
