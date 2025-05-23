import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

class DetailsState extends Equatable {
  final String? profilePictureLink;
  final List<String>? projectFileLinks;
  final List<PlatformFile>? projectFiles;
  const DetailsState({
    this.profilePictureLink,
    this.projectFiles,
    this.projectFileLinks,
  });
  DetailsState copyWith({
    String? profilePictureLink,
    List<PlatformFile>? projectContent,
    List<String>? projectFilesLinks,
  }) {
    return DetailsState(
      profilePictureLink: profilePictureLink ?? this.profilePictureLink,
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
      ];
}

class DetailInitial extends DetailsState {}
