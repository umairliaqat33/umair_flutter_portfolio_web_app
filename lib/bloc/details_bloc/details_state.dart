import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:umair_liaqat/models/job_history.dart';
import 'package:umair_liaqat/models/project_model.dart';
import 'package:umair_liaqat/models/qualification_model.dart';
import 'package:umair_liaqat/models/user_model.dart';

class DetailsState extends Equatable {
  final String? profilePictureLink;
  final UserModel? userModel;
  final List<String>? projectFileLinks;
  final List<PlatformFile>? projectFiles;
  final List<JobHistory>? jobHistories;
  final List<ProjectModel>? projectList;
  final List<QualificationModel>? qualificationsList;

  const DetailsState({
    this.profilePictureLink,
    this.projectFiles,
    this.projectFileLinks,
    this.jobHistories,
    this.projectList,
    this.qualificationsList,
    this.userModel,
  });
  DetailsState copyWith({
    String? profilePictureLink,
    List<PlatformFile>? projectContent,
    List<String>? projectFilesLinks,
    List<JobHistory>? jobHistories,
    List<ProjectModel>? projectList,
    List<QualificationModel>? qualificationsList,
    UserModel? userModel,
  }) {
    return DetailsState(
      profilePictureLink: profilePictureLink ?? this.profilePictureLink,
      userModel: userModel ?? this.userModel,
      jobHistories: jobHistories ?? this.jobHistories,
      projectList: projectList ?? this.projectList,
      qualificationsList: qualificationsList ?? this.qualificationsList,
      projectFiles: projectContent ?? projectContent,
      projectFileLinks: projectFilesLinks ?? projectFileLinks,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        profilePictureLink,
        projectFiles,
        projectFileLinks,
        jobHistories,
        qualificationsList,
        projectList,
      ];
}

class DetailInitial extends DetailsState {}
