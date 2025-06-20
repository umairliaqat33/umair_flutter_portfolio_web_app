import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:umair_liaqat/models/job_history.dart';
import 'package:umair_liaqat/models/project_model.dart';
import 'package:umair_liaqat/models/qualification_model.dart';
import 'package:umair_liaqat/models/user_model.dart';
import 'package:umair_liaqat/utils/app_enum.dart';
import 'package:umair_liaqat/utils/collections.dart';

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
  bool isLoading = false;

  FutureOr<void> _changeAppBarHeadersIndex(
    ChangeAppBarHeadersIndex event,
    Emitter<HomeState> emit,
  ) {
    _appBarHeaderIndex = event.index;
    emit(AppBarHeadersIndexChanged(
      _appBarHeaderIndex,
      state.userModel,
    ));
  }

  FutureOr<void> _changeAppBarHeadersColorByColor(
    ChangeAppBarHeadersColorByColor event,
    Emitter<HomeState> emit,
  ) {
    _appBarHeaderIndex = event.index;
    emit(
      AppBarHeadersColorChangedByIndex(
        _appBarHeaderIndex,
        state.userModel,
      ),
    );
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

  Future<void> _getUserData(GetUserData event, Emitter<HomeState> emit) async {
    try {
      emit(
        state.copyWith(
          isLoading: true,
        ),
      );
      final userResponse = await Supabase.instance.client
          .from(Collections.users)
          .select()
          .limit(1)
          .maybeSingle();
      List<ProjectModel> projectsList = await getProjects() ?? [];
      List<JobHistory> jobsList = await getJobHistory() ?? [];
      List<QualificationModel> qualificationsList =
          await getQualifications() ?? [];
      if (userResponse != null) {
        // var data = querySnapshot.docs.first.data() as Map<String, dynamic>;
        userModel = UserModel.fromMap(userResponse);
        userModel?.projects = projectsList;
        userModel?.qualifications = qualificationsList;
        userModel?.jobs = jobsList;
        emit(
          state.copyWith(
            userData: userModel,
          ),
        );
      }
    } catch (e) {
      log("Error while fetching user information: ${e.toString()}");
    } finally {
      emit(
        state.copyWith(
          isLoading: false,
        ),
      );
    }
  }

  Future<List<ProjectModel>?> getProjects() async {
    try {
      final response = await Supabase.instance.client
          .from(Collections.projects)
          .select(); // Optional if needed

      return (response as List<dynamic>)
          .map((data) => ProjectModel.fromMap(data as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log("Error while fetching projects information: $e");
      return null;
    }
  }

  Future<List<QualificationModel>?> getQualifications() async {
    try {
      final response = await Supabase.instance.client
          .from(Collections.qualifications)
          .select()
          .order('sortingIndex', ascending: true);

      return (response as List)
          .map((e) => QualificationModel.fromMap(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log("Error while fetching qualifications: $e");
      return null;
    }
  }

  Future<List<JobHistory>?> getJobHistory() async {
    try {
      final response =
          await Supabase.instance.client.from(Collections.jobHistory).select();

      return (response as List)
          .map((e) => JobHistory.fromMap(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log("Error while fetching jobs information: $e");
      return null;
    }
  }
}
