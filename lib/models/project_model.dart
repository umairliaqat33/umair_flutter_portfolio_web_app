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
  String? userId;
  ProjectModel({
    this.name,
    this.description,
    this.link,
    this.id,
    this.filesLinks,
    this.files,
    this.userId,
  });

  ProjectModel copyWith({
    String? name,
    String? id,
    String? description,
    String? link,
    List<String>? filesLinks,
    List<PlatformFile>? files,
    String? userId,
  }) {
    return ProjectModel(
      name: name ?? this.name,
      id: id ?? this.id,
      description: description ?? this.description,
      link: link ?? this.link,
      filesLinks: filesLinks ?? this.filesLinks,
      files: files ?? this.files,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'description': description,
      'link': link,
      'userId': userId,
      'filesLinks': filesLinks,
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
      id: map['_id'] != null ? map['_id'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      link: map['link'] != null ? map['link'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
      filesLinks: map['filesLinks'] != null
          ? List<String>.from((map['filesLinks'] as List))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectModel.fromJson(String source) =>
      ProjectModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
