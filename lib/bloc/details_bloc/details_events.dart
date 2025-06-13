// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:umair_liaqat/models/project_model.dart';

class DetailsEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class ImagePickEvent extends DetailsEvents {}

class PickProjectFilesEvent extends DetailsEvents {}

class UploadProjectEvent extends DetailsEvents {
  final ProjectModel projectModel;
  final BuildContext context;
  UploadProjectEvent({
    required this.projectModel,
    required this.context,
  });
  @override
  List<Object?> get props => [
        projectModel,
        context,
      ];
}

class UpdateProjectEvent extends DetailsEvents {
  final ProjectModel projectModel;
  final BuildContext context;
  UpdateProjectEvent({
    required this.projectModel,
    required this.context,
  });
  @override
  List<Object?> get props => [
        projectModel,
        context,
      ];
}

class UserDataUpdateEvent extends DetailsEvents {
  final String name;
  final BuildContext context;
  final String description;
  final String headline1;
  final String headline2;
  final String linkedIn;
  final String github;
  final String profilePicture;
  final String phoneNumber;

  UserDataUpdateEvent({
    required this.name,
    required this.context,
    required this.description,
    required this.headline1,
    required this.headline2,
    required this.linkedIn,
    required this.github,
    required this.phoneNumber,
    required this.profilePicture,
  });
  @override
  List<Object?> get props => [
        name,
        description,
        headline1,
        headline2,
        linkedIn,
        github,
        profilePicture,
        phoneNumber,
        context,
      ];
}

class UploadWorkHistory extends DetailsEvents {
  final String organization;
  final String jobPosition;
  final int sortIndex;
  final String fromDate;
  final String toDate;
  final String description;
  final BuildContext context;

  UploadWorkHistory({
    required this.organization,
    required this.jobPosition,
    required this.sortIndex,
    required this.fromDate,
    required this.toDate,
    required this.description,
    required this.context,
  });
  @override
  List<Object?> get props => [
        organization,
        jobPosition,
        sortIndex,
        fromDate,
        toDate,
        description,
        context,
      ];
}

class UploadQualification extends DetailsEvents {
  final BuildContext context;
  final String institute;
  final String degreeName;
  final int sortIndex;
  final String completionYear;

  UploadQualification({
    required this.institute,
    required this.degreeName,
    required this.context,
    required this.sortIndex,
    required this.completionYear,
  });
  @override
  List<Object?> get props =>
      [institute, degreeName, sortIndex, completionYear, context];
}

class UpdateQualification extends DetailsEvents {
  final BuildContext context;
  final String institute;
  final String id;
  final String degreeName;
  final int sortIndex;
  final String completionYear;

  UpdateQualification({
    required this.institute,
    required this.degreeName,
    required this.context,
    required this.sortIndex,
    required this.completionYear,
    required this.id,
  });
  @override
  List<Object?> get props => [
        institute,
        degreeName,
        sortIndex,
        completionYear,
        context,
        id,
      ];
}

class DeleteQualification extends DetailsEvents {
  final String id;
  final BuildContext context;

  DeleteQualification({
    required this.id,
    required this.context,
  });
  @override
  List<Object?> get props => [
        id,
        context,
      ];
}

class DeleteWorkHistory extends DetailsEvents {
  final String id;
  final BuildContext context;

  DeleteWorkHistory({
    required this.id,
    required this.context,
  });
  @override
  List<Object?> get props => [
        id,
        context,
      ];
}

class DeleteProject extends DetailsEvents {
  final String id;
  final BuildContext context;

  DeleteProject({
    required this.id,
    required this.context,
  });
  @override
  List<Object?> get props => [
        id,
        context,
      ];
}
