import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

class DetailsState extends Equatable {
  final PlatformFile? profilePicturePlatform;
  final List<PlatformFile>? projectFiles;
  const DetailsState({
    this.profilePicturePlatform,
    this.projectFiles,
  });
  DetailsState copyWith({
    PlatformFile? pf,
    List<PlatformFile>? projectContent,
  }) {
    return DetailsState(
      profilePicturePlatform: pf ?? profilePicturePlatform,
      projectFiles: projectContent ?? projectContent,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        profilePicturePlatform,
        projectFiles,
      ];
}

class DetailInitial extends DetailsState {}
