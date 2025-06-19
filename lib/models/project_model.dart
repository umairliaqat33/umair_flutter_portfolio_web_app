import 'dart:convert';

import 'package:file_picker/file_picker.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProjectModel {
  String? name;
  String? id;
  String? description;
  String? link;
  List<String>? filesLinks;
  List<PlatformFile>? files;
  ProjectModel({
    this.name,
    this.description,
    this.link,
    this.id,
    this.filesLinks,
    this.files,
  });

  ProjectModel copyWith({
    String? name,
    String? id,
    String? description,
    String? link,
    List<String>? filesLinks,
    List<PlatformFile>? files,
  }) {
    return ProjectModel(
      name: name ?? this.name,
      id: id ?? this.id,
      description: description ?? this.description,
      link: link ?? this.link,
      filesLinks: filesLinks ?? this.filesLinks,
      files: files ?? this.files,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'description': description,
      'link': link,
      'files': filesLinks,
    };
  }

  Map<String, dynamic> toMapWithoutFiles() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'description': description,
      'link': link,
    };
  }

  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    return ProjectModel(
      name: map['name'] != null ? map['name'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      link: map['link'] != null ? map['link'] as String : null,
      filesLinks: map['files'] != null
          ? List<String>.from((map['files'] as List))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectModel.fromJson(String source) =>
      ProjectModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
