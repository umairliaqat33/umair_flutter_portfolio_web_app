import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umair_liaqat/bloc/details_bloc/details_events.dart';
import 'package:umair_liaqat/bloc/details_bloc/details_state.dart';
import 'package:umair_liaqat/models/job_history.dart';
import 'package:umair_liaqat/models/qualification_model.dart';
import 'package:umair_liaqat/models/user_model.dart';
import 'package:umair_liaqat/services/google_drive_service.dart';
import 'package:umair_liaqat/services/media_service.dart';
import 'package:umair_liaqat/utils/app_strings.dart';
import 'package:uuid/uuid.dart';

class DetailsBloc extends Bloc<DetailsEvents, DetailsState> {
  DetailsBloc() : super(DetailInitial()) {
    on<ImagePickEvent>(_imagePick);
    on<PickProjectFilesEvent>(_selectProjectFiles);
    on<UserDataUpdateEvent>(_updateUserProfile);
    on<UploadWorkHistory>(_uploadWorkHistory);
    on<UploadQualification>(_uploadQualification);
  }
  final Uuid _uuid = Uuid();

  Future<void> _imagePick(
      ImagePickEvent event, Emitter<DetailsState> emit) async {
    try {
      final value = await MediaService.selectFile(imageExtensions);
      if (value != null) {
        String? uploadedProfileLink = await uploadPlatformFileToDrive(value);

        emit(
          state.copyWith(
            profilePictureLink: uploadedProfileLink,
          ),
        );
      }
    } catch (e) {
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
      log("Error while picking file: $e");
    }
  }

  Future<void> _updateUserProfile(
      UserDataUpdateEvent event, Emitter<DetailsState> emit) async {
    try {
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
    } catch (e) {
      log("Error while updatingUser: $e");
    }
  }

  Future<void> _uploadWorkHistory(
      UploadWorkHistory event, Emitter<DetailsState> emit) async {
    String id = _uuid.v4();
    try {
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
    } catch (e) {
      log("Error while uploading work history: $e");
    }
  }

  Future<void> _uploadQualification(
      UploadQualification event, Emitter<DetailsState> emit) async {
    String id = _uuid.v4();
    try {
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
    } catch (e) {
      log("Error while uploading qualification: $e");
    }
  }
}
