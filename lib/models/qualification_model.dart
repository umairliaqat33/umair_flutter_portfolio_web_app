import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class QualificationModel {
  final String? instituteName;
  final String? completionYear;
  final String? degreeName;
  final int? sortingIndex;
  QualificationModel({
    this.instituteName,
    this.completionYear,
    this.degreeName,
    this.sortingIndex,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'instituteName': instituteName,
      'completionYear': completionYear,
      'degreeName': degreeName,
      'sortingIndex': sortingIndex,
    };
  }

  factory QualificationModel.fromMap(Map<String, dynamic> map) {
    return QualificationModel(
      instituteName:
          map['instituteName'] != null ? map['instituteName'] as String : null,
      completionYear: map['completionYear'] != null
          ? map['completionYear'] as String
          : null,
      degreeName:
          map['degreeName'] != null ? map['degreeName'] as String : null,
      sortingIndex:
          map['sortingIndex'] != null ? map['sortingIndex'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory QualificationModel.fromJson(String source) =>
      QualificationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  QualificationModel copyWith({
    String? instituteName,
    String? completionYear,
    String? degreeName,
    int? sortingIndex,
  }) {
    return QualificationModel(
      instituteName: instituteName ?? this.instituteName,
      completionYear: completionYear ?? this.completionYear,
      degreeName: degreeName ?? this.degreeName,
      sortingIndex: sortingIndex ?? this.sortingIndex,
    );
  }
}
