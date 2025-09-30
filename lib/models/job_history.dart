import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class JobHistory {
  String? id;
  String? position;
  String? jobDescription;
  String? organization;
  String? fromDate;
  String? toDate;
  String? userId;
  int? sortingIndex;
  JobHistory({
    this.position,
    this.jobDescription,
    this.organization,
    this.fromDate,
    this.toDate,
    this.sortingIndex,
    this.id,
    this.userId,
  });

  JobHistory copyWith({
    String? position,
    String? jobDescription,
    String? organization,
    String? fromDate,
    String? toDate,
    String? userId,
    int? sortingIndex,
    String? id,
  }) {
    return JobHistory(
      position: position ?? this.position,
      jobDescription: jobDescription ?? this.jobDescription,
      organization: organization ?? this.organization,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      sortingIndex: sortingIndex ?? this.sortingIndex,
      id: id ?? this.id,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'position': position,
      'jobDescription': jobDescription,
      'organization': organization,
      'fromDate': fromDate,
      'toDate': toDate,
      'sortingIndex': sortingIndex,
      'userId': userId,
      'id': id,
    };
  }

  Map<String, dynamic> toMapView() {
    return <String, dynamic>{
      'Position': position,
      'Job Description': jobDescription,
      'Organization': organization,
      'FromDate': fromDate,
      'To Date': toDate,
      'userId': userId,
      'Sort Index': sortingIndex,
      'Id': id,
    };
  }

  factory JobHistory.fromMap(Map<String, dynamic> map) {
    return JobHistory(
      position: map['position'] != null ? map['position'] as String : null,
      id: map['_id'] != null ? map['_id'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
      jobDescription: map['jobDescription'] != null
          ? map['jobDescription'] as String
          : null,
      organization:
          map['organization'] != null ? map['organization'] as String : null,
      fromDate: map['fromDate'] != null ? map['fromDate'] as String : null,
      toDate: map['toDate'] != null ? map['toDate'] as String : null,
      sortingIndex:
          map['sortingIndex'] != null ? map['sortingIndex'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory JobHistory.fromJson(String source) =>
      JobHistory.fromMap(json.decode(source) as Map<String, dynamic>);
}
