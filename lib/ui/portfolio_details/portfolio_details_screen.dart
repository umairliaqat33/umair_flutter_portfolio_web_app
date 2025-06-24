import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umair_liaqat/bloc/details_bloc/details_bloc.dart';
import 'package:umair_liaqat/bloc/details_bloc/details_events.dart';
import 'package:umair_liaqat/bloc/details_bloc/details_state.dart';
import 'package:umair_liaqat/bloc/login_bloc/login_bloc.dart';
import 'package:umair_liaqat/bloc/login_bloc/login_event.dart';
import 'package:umair_liaqat/models/job_history.dart';
import 'package:umair_liaqat/models/project_model.dart';
import 'package:umair_liaqat/models/qualification_model.dart';
import 'package:umair_liaqat/models/user_model.dart';
import 'package:umair_liaqat/ui/portfolio_details/components/project_details_widget.dart';
import 'package:umair_liaqat/ui/portfolio_details/components/qualification_details_widget.dart';
import 'package:umair_liaqat/ui/portfolio_details/components/user_profile_details_widget.dart';
import 'package:umair_liaqat/ui/portfolio_details/components/work_history_details_widget.dart';
import 'package:umair_liaqat/utils/app_sizes.dart';
import 'package:umair_liaqat/utils/app_strings.dart';

class PortfolioDetailsScreen extends StatefulWidget {
  const PortfolioDetailsScreen({super.key});

  @override
  State<PortfolioDetailsScreen> createState() => _PortfolioDetailsScreenState();
}

class _PortfolioDetailsScreenState extends State<PortfolioDetailsScreen> {
  final _userDetailsFormKey = GlobalKey<FormState>();
  final _workHistoryFormKey = GlobalKey<FormState>();
  final _qualificationFormKey = GlobalKey<FormState>();
  final _projectFormKey = GlobalKey<FormState>();

  List<ProjectModel> projectsList = [];
  List<QualificationModel> qualificationsList = [];
  List<JobHistory> workHistoryList = [];
  UserModel? user;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.read<LoginBloc>().add(
                    LogoutButtonPressed(
                      context,
                    ),
                  );
            },
            icon: Row(
              children: [
                Text(Strings.logout),
                Icon(Icons.logout_rounded),
              ],
            ),
          ),
        ],
      ),
      body: BlocBuilder<DetailsBloc, DetailsState>(
        builder: (BuildContext context, DetailsState state) {
          if (state.jobHistories != null && state.jobHistories!.isNotEmpty) {
            workHistoryList = state.jobHistories ?? [];
          }

          if (state.projectList != null && state.projectList!.isNotEmpty) {
            projectsList = state.projectList ?? [];
          }
          if (state.qualificationsList != null &&
              state.qualificationsList!.isNotEmpty) {
            qualificationsList = state.qualificationsList ?? [];
          }
          if (state.userModel != null) {
            user = state.userModel;
          }
          return SingleChildScrollView(
            child: Padding(
              padding: AppSizes.appPadding(context).copyWith(
                bottom: 30,
              ),
              child: Column(
                children: [
                  UserProfileDetailsWidget(
                    userModel: user,
                    userDetailsFormKey: _userDetailsFormKey,
                    updateUserData: (UserModel user) => updateUserData(user),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  QualificationDetailsWidget(
                    qualificationList: qualificationsList,
                    qualificationFormKey: _qualificationFormKey,
                    addQualification: (qualification) =>
                        addQualification(qualification),
                    deleteQualification: (index, id) => deleteQualification(
                      id,
                      index,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  WorkHistoryDetailsWidget(
                    workHistoryList: workHistoryList,
                    workHistoryFormKey: _workHistoryFormKey,
                    addWorkHistory: (workHistory) =>
                        addWorkHistory(workHistory),
                    editWorkHistory: (index, key) =>
                        editWorkHistory(index, key),
                    deleteWorkHistory: (index, key) =>
                        deleteWorkHistory(index, key),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ProjectDetailsWidget(
                    projectsList: projectsList,
                    projectFormKey: _projectFormKey,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void getUserData() {
    try {
      context.read<DetailsBloc>().add(LoadInitialDetailsEvent());
    } catch (e) {
      log("Error fetching data in portfolio screen: ${e.toString()}");
    }
  }

  void updateUserData(UserModel userModel) {
    try {
      if (_userDetailsFormKey.currentState!.validate()) {
        context.read<DetailsBloc>().add(
              UserDataUpdateEvent(
                context: context,
                name: userModel.name!,
                description: userModel.description!,
                headline1: userModel.headline1!,
                headline2: userModel.headline2!,
                linkedIn: userModel.linkedIn!,
                github: userModel.github!,
                phoneNumber: userModel.phoneNumber!,
                skills: userModel.skills!,
                profilePicture:
                    context.read<DetailsBloc>().state.profilePictureLink ??
                        user?.profilePicture ??
                        "",
              ),
            );
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void deleteQualification(String id, int index) {
    context.read<DetailsBloc>().add(
          DeleteQualification(
            id: id,
            context: context,
          ),
        );
    qualificationsList.removeAt(index);
    setState(() {});
  }

  void addWorkHistory(JobHistory jobHistory) {
    if (_workHistoryFormKey.currentState!.validate()) {
      context.read<DetailsBloc>().add(
            UploadWorkHistory(
              organization: jobHistory.organization!,
              jobPosition: jobHistory.position!,
              sortIndex: jobHistory.sortIndex!,
              fromDate: jobHistory.fromDate!,
              toDate: jobHistory.toDate!,
              description: jobHistory.jobDescription!,
              context: context,
            ),
          );
    }
  }

  void deleteWorkHistory(int index, String id) {
    context.read<DetailsBloc>().add(
          DeleteWorkHistory(
            id: id,
            context: context,
          ),
        );
    workHistoryList.removeAt(index);
    setState(() {});
  }

  void editWorkHistory(int index, String id) {
    setState(() {});
  }

  void addQualification(QualificationModel qualification) {
    if (_qualificationFormKey.currentState!.validate()) {
      context.read<DetailsBloc>().add(
            UploadQualification(
              context: context,
              institute: qualification.instituteName!,
              degreeName: qualification.degreeName!,
              sortIndex: qualification.sortingIndex!,
              completionYear: qualification.completionYear!,
            ),
          );
    }
  }
}
