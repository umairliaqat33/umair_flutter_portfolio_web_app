import 'package:equatable/equatable.dart';

class DetailsEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class ImagePickEvent extends DetailsEvents {}

class PickProjectFilesEvent extends DetailsEvents {}

class UserDataUpdateEvent extends DetailsEvents {
  final String name;
  final String description;
  final String headline1;
  final String headline2;
  final String linkedIn;
  final String github;
  final String profilePicture;
  final String phoneNumber;

  UserDataUpdateEvent({
    required this.name,
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
      ];
}

class UploadWorkHistory extends DetailsEvents {
  final String organization;
  final String jobPosition;
  final int sortIndex;
  final String fromDate;
  final String toDate;
  final String description;

  UploadWorkHistory({
    required this.organization,
    required this.jobPosition,
    required this.sortIndex,
    required this.fromDate,
    required this.toDate,
    required this.description,
  });
  @override
  List<Object?> get props => [
        organization,
        jobPosition,
        sortIndex,
        fromDate,
        toDate,
        description,
      ];
}

class UploadQualification extends DetailsEvents {
  final String institute;
  final String degreeName;
  final int sortIndex;
  final String completionYear;

  UploadQualification({
    required this.institute,
    required this.degreeName,
    required this.sortIndex,
    required this.completionYear,
  });
  @override
  List<Object?> get props => [
        institute,
        degreeName,
        sortIndex,
        completionYear,
      ];
}
