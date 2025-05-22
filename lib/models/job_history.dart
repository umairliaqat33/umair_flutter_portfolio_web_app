import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class JobHistory {
  String? id;
  String? position;
  String? jobDescription;
  String? organization;
  String? fromDate;
  String? toDate;
  int? sortIndex;
  JobHistory({
    this.position,
    this.jobDescription,
    this.organization,
    this.fromDate,
    this.toDate,
    this.sortIndex,
    this.id,
  });

  JobHistory copyWith({
    String? position,
    String? jobDescription,
    String? organization,
    String? fromDate,
    String? toDate,
    int? sortIndex,
    String? id,
  }) {
    return JobHistory(
      position: position ?? this.position,
      jobDescription: jobDescription ?? this.jobDescription,
      organization: organization ?? this.organization,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      sortIndex: sortIndex ?? this.sortIndex,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'position': position,
      'jobDescription': jobDescription,
      'organization': organization,
      'fromDate': fromDate,
      'toDate': toDate,
      'sortIndex': sortIndex,
      'id': id,
    };
  }

  factory JobHistory.fromMap(Map<String, dynamic> map) {
    return JobHistory(
      position: map['position'] != null ? map['position'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
      jobDescription: map['jobDescription'] != null
          ? map['jobDescription'] as String
          : null,
      organization:
          map['organization'] != null ? map['organization'] as String : null,
      fromDate: map['fromDate'] != null ? map['fromDate'] as String : null,
      toDate: map['toDate'] != null ? map['toDate'] as String : null,
      sortIndex: map['sortIndex'] != null ? map['sortIndex'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory JobHistory.fromJson(String source) =>
      JobHistory.fromMap(json.decode(source) as Map<String, dynamic>);
}
