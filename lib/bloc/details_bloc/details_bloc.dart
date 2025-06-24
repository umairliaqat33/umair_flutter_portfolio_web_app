import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:umair_liaqat/bloc/details_bloc/details_events.dart';
import 'package:umair_liaqat/bloc/details_bloc/details_state.dart';
import 'package:umair_liaqat/models/job_history.dart';
import 'package:umair_liaqat/models/project_model.dart';
import 'package:umair_liaqat/models/qualification_model.dart';
import 'package:umair_liaqat/models/user_model.dart';
import 'package:umair_liaqat/services/media_service.dart';
import 'package:umair_liaqat/utils/app_strings.dart';
import 'package:umair_liaqat/utils/collections.dart';
import 'package:umair_liaqat/utils/toast_utils.dart';
import 'package:uuid/uuid.dart';

class DetailsBloc extends Bloc<DetailsEvents, DetailsState> {
  DetailsBloc() : super(DetailInitial()) {
    on<ImagePickEvent>(_imagePick);
    on<PickProjectFilesEvent>(_selectProjectFiles);
    on<UserDataUpdateEvent>(_updateUserProfile);
    on<UploadWorkHistory>(_uploadWorkHistory);
    on<UploadQualification>(_uploadQualification);
    on<DeleteQualification>(_deleteQualification);
    on<DeleteWorkHistory>(_deleteJobHistory);
    on<DeleteProject>(_deleteProject);
    on<UploadProjectEvent>(_uploadProject);
    on<UpdateProjectEvent>(_updateProject);
    on<UpdateQualification>(_updateQualification);
    on<UpdateWorkHistory>(_updateWorkHistory);
    on<DeleteProjectFilesEvent>(_deleteProjectImage);
    on<DeleteProjectAllFilesEvent>(_deleteAllProjectImages);
    on<LoadInitialDetailsEvent>(_loadInitialData);
  }
  final Uuid _uuid = Uuid();

  Future<void> _loadInitialData(
    LoadInitialDetailsEvent event,
    Emitter<DetailsState> emit,
  ) async {
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) {
        Fluttertoast.showToast(msg: "User not authenticated");
        return;
      }

      final userResponse = await Supabase.instance.client
          .from(Collections.users)
          .select()
          .limit(1)
          .maybeSingle();

      final projectsResponse =
          await Supabase.instance.client.from(Collections.projects).select();

      final jobsResponse =
          await Supabase.instance.client.from(Collections.jobHistory).select();

      final qualificationsResponse = await Supabase.instance.client
          .from(Collections.qualifications)
          .select()
          .order('sortingIndex', ascending: true);

      final userModel =
          userResponse != null ? UserModel.fromMap(userResponse) : null;

      final projects = (projectsResponse as List)
          .map((e) => ProjectModel.fromMap(e))
          .toList();

      final jobs =
          (jobsResponse as List).map((e) => JobHistory.fromMap(e)).toList();

      final qualifications = (qualificationsResponse as List)
          .map((e) => QualificationModel.fromMap(e))
          .toList();

      emit(
        state.copyWith(
          jobHistories: jobs,
          qualificationsList: qualifications,
          projectList: projects,
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
      final client = Supabase.instance.client;
      final userEmail = client.auth.currentUser?.email;

      if (userEmail == null) {
        throw Exception("User not authenticated");
      }
      final UserModel userModel = UserModel(
        name: event.name,
        description: event.description,
        email: userEmail,
        headline1: event.headline1,
        headline2: event.headline2,
        profilePicture: event.profilePicture,
        github: event.github,
        linkedIn: event.linkedIn,
        phoneNumber: event.phoneNumber,
        skills: event.skills,
      );
      final userResponse = await Supabase.instance.client
          .from(Collections.users)
          .select()
          .limit(1)
          .maybeSingle();
      if (userResponse == null) {
        final updateResponse = await client
            .from('users')
            .insert(userModel.toMapSimpleUser())
            .eq('email', userEmail);
        if (updateResponse != null) {
          debugPrint(updateResponse);
        }
      } else {
        final updateResponse = await client
            .from('users')
            .update(userModel.toMapSimpleUser())
            .eq('email', userEmail);
        if (updateResponse != null) {
          debugPrint(updateResponse);
        }
      }

      Navigator.of(event.context).pop();

      Fluttertoast.showToast(
        msg: Strings.valueUpdated(
          Strings.userDetails,
        ),
      );
    } catch (e) {
      Navigator.of(event.context).pop();

      Fluttertoast.showToast(msg: e.toString());

      log("Error while updating User: $e");
    }
  }

  Future<void> _uploadWorkHistory(
      UploadWorkHistory event, Emitter<DetailsState> emit) async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) {
      Fluttertoast.showToast(msg: "User not authenticated");
      return;
    }

    String id = _uuid.v4();
    try {
      ToastUtils.showLoader(event.context);

      JobHistory jobHistory = JobHistory(
        id: id,
        fromDate: event.fromDate,
        toDate: event.toDate,
        jobDescription: event.description,
        organization: event.organization,
        position: event.jobPosition,
        sortIndex: event.sortIndex,
        userId: userId, // Make sure your model has this
      );

      await Supabase.instance.client
          .from(Collections.jobHistory)
          .insert(jobHistory.toMap());

      List<JobHistory> updatedList = [...state.jobHistories ?? [], jobHistory];

      emit(state.copyWith(jobHistories: updatedList));
      Navigator.of(event.context).pop();
      Fluttertoast.showToast(msg: Strings.valueAdded(Strings.workHistory));
    } catch (e) {
      Navigator.of(event.context).pop();
      Fluttertoast.showToast(msg: e.toString());
      log("Error while uploading work history: $e");
    }
  }

  Future<void> _updateWorkHistory(
      UpdateWorkHistory event, Emitter<DetailsState> emit) async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) {
      Fluttertoast.showToast(msg: "User not authenticated");
      return;
    }

    try {
      ToastUtils.showLoader(event.context);

      await Supabase.instance.client
          .from(Collections.jobHistory)
          .update(event.jobHistory.toMap())
          .eq('id', event.jobHistory.id!)
          .eq('userId', userId); // ownership check

      Navigator.of(event.context).pop();
      Navigator.of(event.context).pop();

      Fluttertoast.showToast(msg: Strings.valueUpdated(Strings.workHistory));
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

      Fluttertoast.showToast(msg: Strings.fileRemoved);
    } catch (e) {
      Fluttertoast.showToast(msg: Strings.fileNotRemoved);

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
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) {
      Fluttertoast.showToast(msg: "User not authenticated");
      return;
    }

    final id = _uuid.v4();
    try {
      ToastUtils.showLoader(event.context);

      final qualificationModel = QualificationModel(
        id: id,
        completionYear: event.completionYear,
        degreeName: event.degreeName,
        instituteName: event.institute,
        sortingIndex: event.sortIndex,
      );

      final data = qualificationModel.toMap()..addAll({'userId': userId});

      await Supabase.instance.client
          .from(Collections.qualifications)
          .insert(data);
      List<QualificationModel> updatedList = [
        ...state.qualificationsList ?? [],
        qualificationModel
      ];

      emit(state.copyWith(qualificationsList: updatedList));
      Navigator.of(event.context).pop();
      Fluttertoast.showToast(msg: Strings.valueAdded(Strings.qualification));
    } catch (e) {
      Navigator.of(event.context).pop();
      Fluttertoast.showToast(msg: e.toString());
      log("Error while uploading qualification: $e");
    }
  }

  Future<void> _updateQualification(
      UpdateQualification event, Emitter<DetailsState> emit) async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) {
      Fluttertoast.showToast(msg: "User not authenticated");
      return;
    }

    try {
      ToastUtils.showLoader(event.context);

      event.qualificationModel =
          event.qualificationModel.copyWith(userId: userId);

      await Supabase.instance.client
          .from(Collections.qualifications)
          .update(event.qualificationModel.toMap())
          .eq('id', event.qualificationModel.id!)
          .eq('userId', userId);

      Navigator.of(event.context).pop();
      Navigator.of(event.context).pop();
      Fluttertoast.showToast(msg: Strings.valueUpdated(Strings.qualification));
    } catch (e) {
      Navigator.of(event.context).pop();
      Fluttertoast.showToast(msg: e.toString());
      log("Error while updating qualification: $e");
    }
  }

  Future<void> _deleteQualification(
      DeleteQualification event, Emitter<DetailsState> emit) async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) {
      Fluttertoast.showToast(msg: "User not authenticated");
      return;
    }

    try {
      ToastUtils.showLoader(event.context);

      await Supabase.instance.client
          .from(Collections.qualifications)
          .delete()
          .eq('id', event.id)
          .eq('userId', userId);

      Navigator.of(event.context).pop();
      Fluttertoast.showToast(msg: Strings.valueDeleted(Strings.qualification));
    } catch (e) {
      Navigator.of(event.context).pop();
      Fluttertoast.showToast(msg: e.toString());
      log("Error while deleting qualification: $e");
    }
  }

  Future<void> _deleteJobHistory(
      DeleteWorkHistory event, Emitter<DetailsState> emit) async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) {
      Fluttertoast.showToast(msg: "User not authenticated");
      return;
    }

    try {
      ToastUtils.showLoader(event.context);

      await Supabase.instance.client
          .from(Collections.jobHistory)
          .delete()
          .eq('id', event.id)
          .eq('userId', userId); // prevent deleting others' data

      Navigator.of(event.context).pop();
      Fluttertoast.showToast(msg: Strings.valueDeleted(Strings.jobHistory));
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

      await Supabase.instance.client
          .from('projects')
          .delete()
          .eq('id', event.id);

      Navigator.of(event.context).pop();
      Fluttertoast.showToast(msg: Strings.valueDeleted(Strings.project));
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
    final id = _uuid.v4();
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) {
        Fluttertoast.showToast(msg: "User not authenticated");
        return;
      }
      ToastUtils.showLoader(event.context);

      List<String> linksList = [];

      if (event.projectModel.files != null &&
          event.projectModel.files!.isNotEmpty) {
        for (PlatformFile file in event.projectModel.files!) {
          String? link = await MediaService.uploadPlatformFile(file);
          if (link != null && link.isNotEmpty) {
            linksList.add(link);
          }
        }
      }

      ProjectModel projectModel = event.projectModel.copyWith(
        id: id,
        filesLinks: linksList,
        userId: userId,
      );

      await Supabase.instance.client
          .from('projects')
          .insert(projectModel.toMap());
      List<ProjectModel> updatedList = [
        ...state.projectList ?? [],
        projectModel
      ];

      emit(state.copyWith(projectList: updatedList));
      Navigator.of(event.context).pop();
      Fluttertoast.showToast(msg: Strings.valueAdded(Strings.project));
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
      Fluttertoast.showToast(msg: Strings.valueUpdated(Strings.project));
    } catch (e) {
      Navigator.of(event.context).pop();
      Fluttertoast.showToast(msg: e.toString());
      log("Error while updating project: $e");
    }
  }
}
