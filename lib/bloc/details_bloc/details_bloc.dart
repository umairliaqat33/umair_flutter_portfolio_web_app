import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umair_liaqat/bloc/details_bloc/details_events.dart';
import 'package:umair_liaqat/bloc/details_bloc/details_state.dart';
import 'package:umair_liaqat/models/user_model.dart';
import 'package:umair_liaqat/services/media_service.dart';
import 'package:umair_liaqat/utils/app_strings.dart';

class DetailsBloc extends Bloc<DetailsEvents, DetailsState> {
  DetailsBloc() : super(DetailInitial()) {
    on<ImagePickEvent>(_imagePick);
    on<PickProjectFilesEvent>(_selectProjectFiles);
    on<UserDataUpdateEvent>(_updateUserProfile);
  }

  Future<void> _imagePick(
      ImagePickEvent event, Emitter<DetailsState> emit) async {
    try {
      final value = await MediaService.selectFile(imageExtensions);
      emit(
        state.copyWith(
          pf: value,
        ),
      );
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

  Future<String> _uploadImage(PlatformFile image) async {
    try {
      String fileName = image.name;

      Reference ref =
          FirebaseStorage.instance.ref().child('profiles/$fileName');

      UploadTask uploadTask = ref.putData(
        image.bytes!,
        SettableMetadata(contentType: 'image/jpeg'),
      );

      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      log("Error while uploading image: $e");
      rethrow;
    }
  }

  Future<void> _updateUserProfile(
      UserDataUpdateEvent event, Emitter<DetailsState> emit) async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      final String url = await _uploadImage(event.profilePicture);
      final UserModel userModel = UserModel(
        name: event.name,
        description: event.description,
        headline1: event.headline1,
        headline2: event.headline2,
        profilePicture: url,
        github: event.github,
        linkedIn: event.linkedIn,
        phoneNumber: event.phoneNumber,
      );
      FirebaseFirestore.instance
          .collection(DatabaseCollections.user)
          .doc(user!.uid)
          .update(
            userModel.toMap(),
          );
    } catch (e) {
      log("Error while picking file: $e");
    }
  }
}
