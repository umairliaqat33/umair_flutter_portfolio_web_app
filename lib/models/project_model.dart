import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProjectModel {
  final String? name;
  final String? description;
  final String? link;
  final List<String> links;
  ProjectModel({
    this.name,
    this.description,
    this.link,
    required this.links,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'link': link,
      'links': links,
    };
  }

  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    return ProjectModel(
      name: map['name'] != null ? map['name'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      link: map['link'] != null ? map['link'] as String : null,
      links: List<String>.from(
        (map['links'] as List<String>),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectModel.fromJson(String source) =>
      ProjectModel.fromMap(json.decode(source) as Map<String, dynamic>);

  ProjectModel copyWith({
    String? name,
    String? description,
    String? link,
    List<String>? links,
  }) {
    return ProjectModel(
      name: name ?? this.name,
      description: description ?? this.description,
      link: link ?? this.link,
      links: links ?? this.links,
    );
  }
}
