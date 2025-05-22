import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umair_liaqat/models/job_history.dart';
import 'package:umair_liaqat/models/project_model.dart';
import 'package:umair_liaqat/models/qualification_model.dart';
import 'package:umair_liaqat/models/user_model.dart';
import 'package:umair_liaqat/utils/app_enum.dart';
import 'package:umair_liaqat/utils/app_strings.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<ChangeAppBarHeadersIndex>(_changeAppBarHeadersIndex);
    on<ChangeAppBarHeadersAxis>(_changeAppBarHeadersAxis);
    on<ChangeAppBarHeadersColorByColor>(_changeAppBarHeadersColorByColor);
    on<GetUserData>(_getUserData);
  }
  int _appBarHeaderIndex = 0;
  UserModel? userModel;
  int get appBarHeaderIndex => _appBarHeaderIndex;

  FutureOr<void> _changeAppBarHeadersIndex(
    ChangeAppBarHeadersIndex event,
    Emitter<HomeState> emit,
  ) {
    _appBarHeaderIndex = event.index;
    emit(AppBarHeadersIndexChanged(_appBarHeaderIndex));
  }

  FutureOr<void> _changeAppBarHeadersColorByColor(
    ChangeAppBarHeadersColorByColor event,
    Emitter<HomeState> emit,
  ) {
    _appBarHeaderIndex = event.index;
    emit(AppBarHeadersColorChangedByIndex(_appBarHeaderIndex));
  }

  //
  AppBarHeadersAxis _appBarHeaderAxis = AppBarHeadersAxis.horizontal;
  AppBarHeadersAxis get appBarHeaderAxis => _appBarHeaderAxis;

  FutureOr<void> _changeAppBarHeadersAxis(
    ChangeAppBarHeadersAxis event,
    Emitter<HomeState> emit,
  ) {
    _appBarHeaderAxis = event.headersAxis;
    emit(AppBarHeadersAxisChanged(_appBarHeaderAxis));
  }

  Future<void> _getUserData(GetUserData event, Emitter<HomeState> state) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(DatabaseCollections.user)
          .get();

      List<ProjectModel> projectsList = await getProjects() ?? [];
      List<JobHistory> jobsList = await getJobHistory() ?? [];
      List<QualificationModel> qualificationsList =
          await getQualifications() ?? [];
      if (querySnapshot.docs.isNotEmpty) {
        var data = querySnapshot.docs.first.data() as Map<String, dynamic>;
        userModel = UserModel.fromMap(data);
        userModel!.projects = projectsList;
        userModel!.qualifications = qualificationsList;
        userModel!.jobs = jobsList;
      }
    } catch (e) {
      log("Error while fetching user information: ${e.toString()}");
    }
  }

  Future<List<ProjectModel>?> getProjects() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(DatabaseCollections.projects)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs
            .map(
              (doc) => ProjectModel.fromMap(doc.data() as Map<String, dynamic>),
            )
            .toList();
      }
    } catch (e) {
      log("Error while fetching projects information: ${e.toString()}");
    }
    return null;
  }

  Future<List<QualificationModel>?> getQualifications() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(DatabaseCollections.qualifications)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs
            .map(
              (doc) => QualificationModel.fromMap(
                  doc.data() as Map<String, dynamic>),
            )
            .toList();
      }
    } catch (e) {
      log("Error while fetching qualifications information: ${e.toString()}");
    }
    return null;
  }

  Future<List<JobHistory>?> getJobHistory() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(DatabaseCollections.jobHistory)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs
            .map(
              (doc) => JobHistory.fromMap(doc.data() as Map<String, dynamic>),
            )
            .toList();
      }
    } catch (e) {
      log("Error while fetching jobs information: ${e.toString()}");
    }
    return null;
  }
}
