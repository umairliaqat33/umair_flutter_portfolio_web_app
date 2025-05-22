import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

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
  final PlatformFile profilePicture;
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
