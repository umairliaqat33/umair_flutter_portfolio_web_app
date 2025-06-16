import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:umair_liaqat/bloc/details_bloc/details_events.dart';
import 'package:umair_liaqat/bloc/details_bloc/details_state.dart';
import 'package:umair_liaqat/models/job_history.dart';
import 'package:umair_liaqat/models/project_model.dart';
import 'package:umair_liaqat/models/qualification_model.dart';
import 'package:umair_liaqat/models/user_model.dart';
import 'package:umair_liaqat/services/google_drive_service.dart';
import 'package:umair_liaqat/services/media_service.dart';
import 'package:umair_liaqat/utils/app_strings.dart';
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
  }
  final Uuid _uuid = Uuid();

  Future<void> _imagePick(
      ImagePickEvent event, Emitter<DetailsState> emit) async {
    try {
      final value = await MediaService.selectFile(imageExtensions);
      if (value != null) {
        String? uploadedProfileLink = await uploadPlatformFile(value);

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

      final User? user = FirebaseAuth.instance.currentUser;
      final UserModel userModel = UserModel(
        name: event.name,
        description: event.description,
        headline1: event.headline1,
        headline2: event.headline2,
        profilePicture: event.profilePicture,
        github: event.github,
        linkedIn: event.linkedIn,
        phoneNumber: event.phoneNumber,
      );
      await FirebaseFirestore.instance
          .collection(DatabaseCollections.user)
          .doc(user!.uid)
          .set(
            userModel.toMap(),
          );
      Navigator.of(event.context).pop();

      Fluttertoast.showToast(msg: Strings.valueAdded(Strings.workHistory));
    } catch (e) {
      Navigator.of(event.context).pop();

      Fluttertoast.showToast(msg: e.toString());

      log("Error while updating User: $e");
    }
  }

  Future<void> _uploadWorkHistory(
      UploadWorkHistory event, Emitter<DetailsState> emit) async {
    String id = _uuid.v4();
    try {
      ToastUtils.showLoader(event.context);
      JobHistory jobHistory = JobHistory(
        id: id,
        fromDate: event.fromDate,
        jobDescription: event.description,
        organization: event.organization,
        position: event.jobPosition,
        sortIndex: event.sortIndex,
        toDate: event.toDate,
      );
      await FirebaseFirestore.instance
          .collection(DatabaseCollections.jobHistory)
          .doc(id)
          .set(
            jobHistory.toMap(),
          );
      Navigator.of(event.context).pop();

      Fluttertoast.showToast(msg: Strings.valueAdded(Strings.workHistory));
    } catch (e) {
      Navigator.of(event.context).pop();

      Fluttertoast.showToast(msg: e.toString());

      log("Error while uploading work history: $e");
    }
  }

  Future<void> _uploadQualification(
      UploadQualification event, Emitter<DetailsState> emit) async {
    String id = _uuid.v4();
    try {
      ToastUtils.showLoader(event.context);

      QualificationModel qualificationModel = QualificationModel(
        id: id,
        completionYear: event.completionYear,
        degreeName: event.degreeName,
        instituteName: event.institute,
        sortingIndex: event.sortIndex,
      );
      await FirebaseFirestore.instance
          .collection(DatabaseCollections.qualifications)
          .doc(id)
          .set(
            qualificationModel.toMap(),
          );
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
    try {
      ToastUtils.showLoader(event.context);

      QualificationModel qualificationModel = QualificationModel(
        id: event.id,
        completionYear: event.completionYear,
        degreeName: event.degreeName,
        instituteName: event.institute,
        sortingIndex: event.sortIndex,
      );
      await FirebaseFirestore.instance
          .collection(DatabaseCollections.qualifications)
          .doc(event.id)
          .update(
            qualificationModel.toMap(),
          );
      Navigator.of(event.context).pop();

      Fluttertoast.showToast(msg: Strings.valueUpdated(Strings.qualification));
    } catch (e) {
      Navigator.of(event.context).pop();

      Fluttertoast.showToast(msg: e.toString());

      log("Error while uploading qualification: $e");
    }
  }

  Future<void> _deleteQualification(
      DeleteQualification event, Emitter<DetailsState> emit) async {
    try {
      ToastUtils.showLoader(event.context);

      await FirebaseFirestore.instance
          .collection(DatabaseCollections.qualifications)
          .doc(event.id)
          .delete();
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
    try {
      ToastUtils.showLoader(event.context);

      await FirebaseFirestore.instance
          .collection(DatabaseCollections.jobHistory)
          .doc(event.id)
          .delete();
      Navigator.of(event.context).pop();
      Fluttertoast.showToast(msg: Strings.valueDeleted(Strings.jobHistory));
    } catch (e) {
      Navigator.of(event.context).pop();
      Fluttertoast.showToast(msg: e.toString());
      log("Error while deleting job history: $e");
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> _deleteProject(
      DeleteProject event, Emitter<DetailsState> emit) async {
    try {
      ToastUtils.showLoader(event.context);

      await FirebaseFirestore.instance
          .collection(DatabaseCollections.projects)
          .doc(event.id)
          .delete();
      Navigator.of(event.context).pop();
      Fluttertoast.showToast(
        msg: Strings.valueDeleted(Strings.project),
      );
    } catch (e) {
      Navigator.of(event.context).pop();
      Fluttertoast.showToast(msg: e.toString());
      log("Error while deleting project: $e");
    }
  }

  Future<void> _uploadProject(
      UploadProjectEvent event, Emitter<DetailsState> emit) async {
    String id = _uuid.v4();
    try {
      ToastUtils.showLoader(event.context);
      List<String> linksList = [];
      if (event.projectModel.files != null &&
          event.projectModel.files!.isNotEmpty) {
        for (int i = 0; i < (event.projectModel.files?.length ?? 0); i++) {
          PlatformFile file = event.projectModel.files![i];
          String? link = await uploadPlatformFile(file);
          if (link != null && link.isNotEmpty) {
            linksList.add(link);
          }
        }
      }
      ProjectModel projectModel = event.projectModel.copyWith(
        id: id,
        filesLinks: linksList,
      );

      await FirebaseFirestore.instance
          .collection(DatabaseCollections.projects)
          .doc(id)
          .set(
            projectModel.toMap(),
          );
      Navigator.of(event.context).pop();
      Fluttertoast.showToast(
        msg: Strings.valueAdded(
          Strings.project,
        ),
      );
    } catch (e) {
      Navigator.of(event.context).pop();

      Fluttertoast.showToast(msg: e.toString());

      log("Error while uploading project: $e");
    }
  }

  Future<void> _updateProject(
      UpdateProjectEvent event, Emitter<DetailsState> emit) async {
    try {
      ToastUtils.showLoader(event.context);
      List<String> linksList = [];
      if (event.projectModel.files != null &&
          event.projectModel.files!.isNotEmpty) {
        for (int i = 0; i < (event.projectModel.files?.length ?? 0); i++) {
          PlatformFile file = event.projectModel.files![i];
          String? link = await uploadPlatformFile(file);
          if (link != null && link.isNotEmpty) {
            linksList.add(link);
          }
        }
      }
      ProjectModel projectModel = event.projectModel.copyWith(
        filesLinks: [
          ...event.projectModel.filesLinks ?? [],
          ...linksList,
        ],
      );

      await FirebaseFirestore.instance
          .collection(DatabaseCollections.projects)
          .doc(event.projectModel.id)
          .update(
            projectModel.toMap(),
          );
      Navigator.of(event.context).pop();
      Fluttertoast.showToast(
        msg: Strings.valueUpdated(
          Strings.project,
        ),
      );
    } catch (e) {
      Navigator.of(event.context).pop();

      Fluttertoast.showToast(msg: e.toString());

      log("Error while updating project: $e");
    }
  }
}
