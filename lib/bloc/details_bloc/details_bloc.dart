import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:umair_liaqat/bloc/details_bloc/details_events.dart';
import 'package:umair_liaqat/bloc/details_bloc/details_state.dart';
import 'package:umair_liaqat/config/app_configurations.dart';
import 'package:umair_liaqat/models/job_history.dart';
import 'package:umair_liaqat/models/project_model.dart';
import 'package:umair_liaqat/models/qualification_model.dart';
import 'package:umair_liaqat/models/user_model.dart';
import 'package:umair_liaqat/repositories/job_history_repository.dart';
import 'package:umair_liaqat/repositories/projects_repository.dart';
import 'package:umair_liaqat/repositories/qualification_repository.dart';
import 'package:umair_liaqat/repositories/user_repository.dart';
import 'package:umair_liaqat/services/media_service.dart';
import 'package:umair_liaqat/utils/app_strings.dart';
import 'package:umair_liaqat/utils/toast_utils.dart';

class DetailsBloc extends Bloc<DetailsEvents, DetailsState> {
  DetailsBloc() : super(DetailInitial()) {
    on<ImagePickEvent>(_imagePick);
    on<PickProjectFilesEvent>(_selectProjectFiles);
    on<UserDataUpdateEvent>(_updateUserProfile);
    on<UploadWorkHistory>(_uploadJobHistory);
    on<UploadQualification>(_uploadQualification);
    on<DeleteQualification>(_deleteQualification);
    on<DeleteWorkHistory>(_deleteJobHistory);
    on<DeleteProject>(_deleteProject);
    on<UploadProjectEvent>(_uploadProject);
    on<UpdateProjectEvent>(_updateProject);
    on<UpdateQualification>(_updateQualification);
    on<UpdateWorkHistory>(_updateJobHistory);
    on<DeleteProjectFilesEvent>(_deleteProjectImage);
    on<DeleteProjectAllFilesEvent>(_deleteAllProjectImages);
    on<LoadInitialDetailsEvent>(_loadInitialData);
  }
  final UserRepository userRepository = UserRepository();
  final JobHistoryRepository jobHistoryRepository = JobHistoryRepository();
  final ProjectRepository projectRepository = ProjectRepository();
  final QualificationRepository qualificationRepository =
      QualificationRepository();
  Future<void> _loadInitialData(
    LoadInitialDetailsEvent event,
    Emitter<DetailsState> emit,
  ) async {
    try {
      if (AppConfigurations.authToken.isEmpty) {
        Fluttertoast.showToast(msg: "User not authenticated");
        return;
      }

      final userModel = await userRepository.getUser();

      emit(
        state.copyWith(
          jobHistories: userModel?.jobs ?? [],
          qualificationsList: userModel?.qualifications ?? [],
          projectList: userModel?.projects ?? [],
          userModel: userModel,
        ),
      );
    } catch (e) {
      log("Error loading initial data: $e");
      Fluttertoast.showToast(msg: "Error loading data");
    }
  }

  Future<void> _imagePick(
      ImagePickEvent event, Emitter<DetailsState> emit) async {
    try {
      final value = await MediaService.selectFile(imageExtensions);
      if (value != null) {
        String? uploadedProfileLink = await MediaService.uploadPlatformFile(
          value,
          isForProfile: true,
        );

        emit(
          state.copyWith(
            profilePictureLink: uploadedProfileLink,
          ),
        );
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());

      log("Error while picking file: $e");
    }
  }

  Future<void> _selectProjectFiles(
      PickProjectFilesEvent event, Emitter<DetailsState> emit) async {
    try {
      final value = await MediaService.selectMultipleFile(imageExtensions);
      List<PlatformFile> files = [];
      if ((value?.isNotEmpty ?? false)) {
        if ((state.projectFiles?.isNotEmpty ?? false)) {
          files.addAll(state.projectFiles!);
          files.addAll(value!);
        } else {
          files = value!;
        }
      }
      emit(
        state.copyWith(
          projectContent: files.isEmpty ? state.projectFiles : files,
        ),
      );
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());

      log("Error while picking file: $e");
    }
  }

  Future<void> _updateUserProfile(
      UserDataUpdateEvent event, Emitter<DetailsState> emit) async {
    try {
      ToastUtils.showLoader(event.context);
      // final client = Supabase.instance.client;
      // final userEmail = client.auth.currentUser?.email;

      // if (userEmail == null) {
      //   throw Exception("User not authenticated");
      // }
      final UserModel userModel = UserModel(
        name: event.name,
        description: event.description,
        email: event.email,
        headline1: event.headline1,
        headline2: event.headline2,
        profilePicture: event.profilePicture,
        github: event.github,
        linkedIn: event.linkedIn,
        phoneNumber: event.phoneNumber,
        skills: event.skills,
        id: event.id,
      );

      await userRepository.updateUser(userModel);

      Navigator.of(event.context).pop();
    } catch (e) {
      Navigator.of(event.context).pop();

      Fluttertoast.showToast(msg: e.toString());

      log("Error while updating User: $e");
    }
  }

  Future<void> _uploadJobHistory(
      UploadWorkHistory event, Emitter<DetailsState> emit) async {
    try {
      ToastUtils.showLoader(event.context);

      JobHistory jobHistory = JobHistory(
        fromDate: event.fromDate,
        toDate: event.toDate,
        jobDescription: event.description,
        organization: event.organization,
        position: event.jobPosition,
        sortingIndex: event.sortIndex,
        userId: state.userModel?.id, // Make sure your model has this
      );

      final job = await jobHistoryRepository.addJobHistory(jobHistory);

      if (job != null) {
        List<JobHistory> updatedList = [...state.jobHistories ?? [], job];

        emit(state.copyWith(jobHistories: updatedList));
      }
      Navigator.of(event.context).pop();
      Fluttertoast.showToast(
          msg: AppStrings.valueAdded(AppStrings.workHistory));
    } catch (e) {
      Navigator.of(event.context).pop();
      Fluttertoast.showToast(msg: e.toString());
      log("Error while uploading work history: $e");
    }
  }

  Future<void> _updateJobHistory(
      UpdateWorkHistory event, Emitter<DetailsState> emit) async {
    try {
      ToastUtils.showLoader(event.context);

      await jobHistoryRepository.updateJobHistory(event.jobHistory);

      Navigator.of(event.context).pop();
      Navigator.of(event.context).pop();

      Fluttertoast.showToast(
          msg: AppStrings.valueUpdated(AppStrings.workHistory));
    } catch (e) {
      Navigator.of(event.context).pop();
      Fluttertoast.showToast(msg: e.toString());
      log("Error while updating work history: $e");
    }
  }

  Future<void> _deleteProjectImage(
      DeleteProjectFilesEvent event, Emitter<DetailsState> emit) async {
    try {
      state.projectFiles!.removeAt(event.index);
      emit(
        state.copyWith(
          projectContent: state.projectFiles,
        ),
      );

      Fluttertoast.showToast(msg: AppStrings.fileRemoved);
    } catch (e) {
      Fluttertoast.showToast(msg: AppStrings.fileNotRemoved);

      log("Error while deleting project file: $e");
    }
  }

  Future<void> _deleteAllProjectImages(
      DeleteProjectAllFilesEvent event, Emitter<DetailsState> emit) async {
    try {
      state.projectFiles?.clear();
      emit(
        state.copyWith(
          projectContent: state.projectFiles,
        ),
      );
    } catch (e) {
      log("Error while deleting all project files: $e");
    }
  }

  Future<void> _uploadQualification(
      UploadQualification event, Emitter<DetailsState> emit) async {
    try {
      ToastUtils.showLoader(event.context);

      final qualificationModel = QualificationModel(
        completionYear: event.completionYear,
        degreeName: event.degreeName,
        instituteName: event.institute,
        sortingIndex: event.sortIndex,
        userId: state.userModel?.id ?? "",
      );

      await qualificationRepository.addQualification(qualificationModel);

      List<QualificationModel> updatedList = [
        ...state.qualificationsList ?? [],
        qualificationModel
      ];

      emit(state.copyWith(qualificationsList: updatedList));
      Navigator.of(event.context).pop();
      Fluttertoast.showToast(
          msg: AppStrings.valueAdded(AppStrings.qualification));
    } catch (e) {
      Navigator.of(event.context).pop();
      Fluttertoast.showToast(msg: e.toString());
      log("Error while uploading qualification: $e");
    }
  }

  Future<void> _updateQualification(
      UpdateQualification event, Emitter<DetailsState> emit) async {
    try {
      ToastUtils.showLoader(event.context);

      event.qualificationModel = event.qualificationModel;
      await qualificationRepository
          .updateQualification(event.qualificationModel);

      Navigator.of(event.context).pop();
      Navigator.of(event.context).pop();
      Fluttertoast.showToast(
          msg: AppStrings.valueUpdated(AppStrings.qualification));
    } catch (e) {
      Navigator.of(event.context).pop();
      Fluttertoast.showToast(msg: e.toString());
      log("Error while updating qualification: $e");
    }
  }

  Future<void> _deleteQualification(
      DeleteQualification event, Emitter<DetailsState> emit) async {
    try {
      ToastUtils.showLoader(event.context);

      await qualificationRepository.deleteQualification(event.id);

      Navigator.of(event.context).pop();
      Fluttertoast.showToast(
          msg: AppStrings.valueDeleted(AppStrings.qualification));
    } catch (e) {
      Navigator.of(event.context).pop();
      Fluttertoast.showToast(msg: e.toString());
      log("Error while deleting qualification: $e");
    }
  }

  Future<void> _deleteJobHistory(
      DeleteWorkHistory event, Emitter<DetailsState> emit) async {
    try {
      ToastUtils.showLoader(event.context);

      await jobHistoryRepository.deleteJobHistory(event.id);

      Navigator.of(event.context).pop();
      Fluttertoast.showToast(
          msg: AppStrings.valueDeleted(AppStrings.jobHistory));
    } catch (e) {
      Navigator.of(event.context).pop();
      Fluttertoast.showToast(msg: e.toString());
      log("Error while deleting job history: $e");
    }
  }

  Future<void> _deleteProject(
    DeleteProject event,
    Emitter<DetailsState> emit,
  ) async {
    try {
      ToastUtils.showLoader(event.context);

      await projectRepository.deleteProject(event.id);

      Navigator.of(event.context).pop();
      Fluttertoast.showToast(msg: AppStrings.valueDeleted(AppStrings.project));
    } catch (e) {
      Navigator.of(event.context).pop();
      Fluttertoast.showToast(msg: e.toString());
      log("Error while deleting project: $e");
    }
  }

  Future<void> _uploadProject(
    UploadProjectEvent event,
    Emitter<DetailsState> emit,
  ) async {
    try {
      ToastUtils.showLoader(event.context);

      List<String>? linksList;

      if (event.projectModel.files != null &&
          event.projectModel.files!.isNotEmpty) {
        linksList = [];
        for (PlatformFile file in event.projectModel.files!) {
          String? link = await MediaService.uploadPlatformFile(file);
          if (link != null && link.isNotEmpty) {
            linksList.add(link);
          }
        }
      }

      ProjectModel projectModel = event.projectModel.copyWith(
        filesLinks: linksList,
        userId: state.userModel?.id,
      );

      final project = await projectRepository.addProject(projectModel);
      if (project != null) {
        List<ProjectModel> updatedList = [...state.projectList ?? [], project];

        emit(state.copyWith(projectList: updatedList));
      }
      Navigator.of(event.context).pop();
      Fluttertoast.showToast(msg: AppStrings.valueAdded(AppStrings.project));
    } catch (e) {
      Navigator.of(event.context).pop();
      Fluttertoast.showToast(msg: e.toString());
      log("Error while uploading project: $e");
    }
  }

  Future<void> _updateProject(
    UpdateProjectEvent event,
    Emitter<DetailsState> emit,
  ) async {
    try {
      ToastUtils.showLoader(event.context);
      List<String> newLinks = [];

      if (event.projectModel.files != null &&
          event.projectModel.files!.isNotEmpty) {
        for (PlatformFile file in event.projectModel.files!) {
          String? link = await MediaService.uploadPlatformFile(file);
          if (link != null && link.isNotEmpty) {
            newLinks.add(link);
          }
        }
      }

      ProjectModel updatedProject = event.projectModel.copyWith(
        filesLinks: [
          ...?event.projectModel.filesLinks,
          ...newLinks,
        ],
      );

      await Supabase.instance.client
          .from('projects')
          .update(updatedProject.toMap())
          .eq('id', updatedProject.id!);

      Navigator.of(event.context).pop();
      Fluttertoast.showToast(msg: AppStrings.valueUpdated(AppStrings.project));
    } catch (e) {
      Navigator.of(event.context).pop();
      Fluttertoast.showToast(msg: e.toString());
      log("Error while updating project: $e");
    }
  }
}
