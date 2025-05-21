import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umair_liaqat/bloc/details_bloc/details_events.dart';
import 'package:umair_liaqat/bloc/details_bloc/details_state.dart';
import 'package:umair_liaqat/services/media_service.dart';
import 'package:umair_liaqat/utils/app_strings.dart';

class DetailsBloc extends Bloc<DetailsEvents, DetailsState> {
  DetailsBloc() : super(DetailInitial()) {
    on<ImagePickEvent>(_imagePick);
    on<PickProjectFilesEvent>(_selectProjectFiles);
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
}
