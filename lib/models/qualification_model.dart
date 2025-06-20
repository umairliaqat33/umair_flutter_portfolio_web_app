import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class QualificationModel {
  String? id;
  String? instituteName;
  String? completionYear;
  String? degreeName;
  String? userId;
  int? sortingIndex;
  QualificationModel({
    this.id,
    this.instituteName,
    this.completionYear,
    this.degreeName,
    this.sortingIndex,
    this.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'instituteName': instituteName,
      'completionYear': completionYear,
      'degreeName': degreeName,
      'sortingIndex': sortingIndex,
      'userId': userId,
    };
  }

  factory QualificationModel.fromMap(Map<String, dynamic> map) {
    return QualificationModel(
      id: map['id'] != null ? map['id'] as String : null,
      instituteName:
          map['instituteName'] != null ? map['instituteName'] as String : null,
      completionYear: map['completionYear'] != null
          ? map['completionYear'] as String
          : null,
      degreeName:
          map['degreeName'] != null ? map['degreeName'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
      sortingIndex:
          map['sortingIndex'] != null ? map['sortingIndex'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory QualificationModel.fromJson(String source) =>
      QualificationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  QualificationModel copyWith({
    String? id,
    String? instituteName,
    String? completionYear,
    String? degreeName,
    String? userId,
    int? sortingIndex,
  }) {
    return QualificationModel(
      id: id ?? this.id,
      instituteName: instituteName ?? this.instituteName,
      completionYear: completionYear ?? this.completionYear,
      degreeName: degreeName ?? this.degreeName,
      sortingIndex: sortingIndex ?? this.sortingIndex,
      userId: userId ?? this.userId,
    );
  }
}
