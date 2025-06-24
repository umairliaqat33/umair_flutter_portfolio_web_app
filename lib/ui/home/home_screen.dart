import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marquee/marquee.dart';
import 'package:umair_liaqat/bloc/home_bloc/home_bloc.dart';
import 'package:umair_liaqat/models/job_history.dart';
import 'package:umair_liaqat/models/qualification_model.dart';
import 'package:umair_liaqat/ui/home/components/education_part.dart';
import 'package:umair_liaqat/ui/home/components/home_app_bar.dart';
import 'package:umair_liaqat/ui/home/components/work_history_part.dart';
import 'package:umair_liaqat/ui/login_screen/login_screen.dart';
import 'package:umair_liaqat/ui/widgets/buttons/normal_button.dart';
import 'package:umair_liaqat/ui/widgets/common_widgets/progress_dialog.dart';
import 'package:umair_liaqat/utils/app_enum.dart';
import 'package:umair_liaqat/utils/app_extensions.dart';
import 'package:umair_liaqat/utils/app_sizes.dart';
import 'package:umair_liaqat/utils/app_strings.dart';
import 'package:umair_liaqat/utils/app_theme.dart';
import 'package:umair_liaqat/ui/widgets/common_widgets/vertical_headers.dart';

import 'components/about_me.dart';
import 'components/contact_me.dart';
import 'components/featured_projects.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: HomeBody(),
    );
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final ScrollController _controller = ScrollController();

  final aboutMeKey = GlobalKey();

  final featuredProjectsKey = GlobalKey();
  final qualificationsKey = GlobalKey();
  final workHistoryKey = GlobalKey();

  final contactMeKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(GetUserData());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initListenerForInteractWithHeaderIndex();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _initListenerForInteractWithHeaderIndex() {
    _controller.addListener(() {
      double controllerHeight = _controller.offset;
      if (_controller.position.extentAfter == 0.0) {
        context.read<HomeBloc>().add(ChangeAppBarHeadersColorByColor(2));
      } else if (controllerHeight < 100) {
        context.read<HomeBloc>().add(ChangeAppBarHeadersColorByColor(0));
      } else if (controllerHeight < (500)) {
        context.read<HomeBloc>().add(ChangeAppBarHeadersColorByColor(1));
      } else {
        context.read<HomeBloc>().add(ChangeAppBarHeadersColorByColor(2));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is AppBarHeadersIndexChanged) {
            Navigator.of(context).maybePop();
            const duration = Duration(milliseconds: 300);
            if (state.index == 0) {
              Scrollable.ensureVisible(
                aboutMeKey.currentContext!,
                duration: duration,
              );
            }
            if (state.index == 1) {
              Scrollable.ensureVisible(
                workHistoryKey.currentContext!,
                duration: duration,
              );
            }
            if (state.index == 2) {
              Scrollable.ensureVisible(
                qualificationsKey.currentContext!,
                duration: duration,
              );
            }
            if (state.index == 3) {
              Scrollable.ensureVisible(
                featuredProjectsKey.currentContext!,
                duration: duration,
              );
            }
            if (state.index == 4) {
              Scrollable.ensureVisible(
                contactMeKey.currentContext!,
                duration: duration,
              );
            }
          }
        },
        child: context.watch<HomeBloc>().state.isLoading
            ? Dialog(
                insetPadding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                child: ProgressDialog(text: Strings.pleaseWait))
            : context.watch<HomeBloc>().state.userModel == null
                ? Dialog(
                    insetPadding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    child: SizedBox(
                      width: AppSizes.textfieldWidth(context),
                      child: NormalButton(
                        label: "User data not found, please login",
                        onTap: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                            (route) => false,
                          );
                        },
                      ),
                    ),
                  )
                : Stack(
                    children: [
                      Container(
                        width: context.width,
                        height: context.height,
                        color: PortfolioAppTheme.primary,
                        child: SingleChildScrollView(
                            controller: _controller,
                            child: Padding(
                              padding: AppSizes.appPadding(context),
                              child: BlocBuilder<HomeBloc, HomeState>(
                                builder: (BuildContext context, state) {
                                  sortBySortingIndex<QualificationModel>(
                                    context
                                            .watch<HomeBloc>()
                                            .state
                                            .userModel
                                            ?.qualifications ??
                                        [],
                                    (model) => model.sortingIndex,
                                  );
                                  sortBySortingIndex<JobHistory>(
                                    context
                                            .watch<HomeBloc>()
                                            .state
                                            .userModel
                                            ?.jobs ??
                                        [],
                                    (model) => model.sortIndex,
                                    isReversed: true,
                                  );
                                  // if (context.watch<HomeBloc>().state.userModel == null) {
                                  //   return AlertDialog(
                                  //       content:
                                  //           ProgressDialog(text: Strings.pleaseWait));
                                  // }
                                  String skillsText = context
                                          .watch<HomeBloc>()
                                          .state
                                          .userModel
                                          ?.skills ??
                                      "";

                                  String marqueeText =
                                      skillsText.replaceAll(', ', '        • ');
                                  return Column(
                                    children: [
                                      SizedBox(height: 0.08 * context.height),
                                      AboutMe(
                                        key: aboutMeKey,
                                        userModel: context
                                            .watch<HomeBloc>()
                                            .state
                                            .userModel,
                                      ),
                                      SizedBox(height: context.height * 0.02),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: context.width * 0.05),
                                        height: 60,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(
                                                color: Colors.white,
                                                width: 1,
                                              ),
                                              bottom: BorderSide(
                                                color: Colors.white,
                                                width: 1,
                                              ),
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            vertical: 20,
                                          ),
                                          child: Marquee(
                                            text: marqueeText,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            scrollAxis: Axis.horizontal,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            blankSpace: 20.0,
                                            velocity: 100.0,
                                            pauseAfterRound:
                                                Duration(seconds: 1),
                                            startPadding: 10.0,
                                            accelerationDuration:
                                                Duration(seconds: 1),
                                            accelerationCurve: Curves.linear,
                                            decelerationDuration:
                                                Duration(milliseconds: 500),
                                            decelerationCurve: Curves.easeOut,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: context.height * 0.04),
                                      WorkHistoryPart(
                                        key: workHistoryKey,
                                        jobHistoryList: context
                                                .watch<HomeBloc>()
                                                .state
                                                .userModel
                                                ?.jobs ??
                                            [],
                                      ),
                                      SizedBox(height: context.height * 0.09),
                                      EducationPart(
                                        key: qualificationsKey,
                                        qualifications: context
                                                .watch<HomeBloc>()
                                                .state
                                                .userModel
                                                ?.qualifications ??
                                            [],
                                      ),
                                      SizedBox(height: context.height * 0.09),
                                      ProjectsSection(
                                        key: featuredProjectsKey,
                                        projectsList: context
                                                .watch<HomeBloc>()
                                                .state
                                                .userModel
                                                ?.projects ??
                                            [],
                                      ),
                                      SizedBox(height: context.height * 0.09),
                                      ContactMe(
                                        key: contactMeKey,
                                        userModel: context
                                            .watch<HomeBloc>()
                                            .state
                                            .userModel,
                                      ),
                                      SizedBox(height: context.height * 0.09),
                                    ],
                                  );
                                },
                              ),
                            )),
                      ),
                      BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          return AnimatedCrossFade(
                            sizeCurve: Curves.bounceInOut,
                            alignment: Alignment.topCenter,
                            crossFadeState: _getCrossFadeState(context),
                            firstChild: Container(
                              color: PortfolioAppTheme.greyButtonColor,
                              child: const VerticalHeaders(),
                            ),
                            secondChild: Container(),
                            duration: const Duration(milliseconds: 200),
                          );
                        },
                      )
                    ],
                  ),
      ),
    );
  }

  CrossFadeState _getCrossFadeState(BuildContext context) {
    final currentHeaderAxis = context.read<HomeBloc>().appBarHeaderAxis;
    return currentHeaderAxis == AppBarHeadersAxis.horizontal
        ? CrossFadeState.showSecond
        : CrossFadeState.showFirst;
  }

  void sortBySortingIndex<T>(List<T> list, int? Function(T) getSortingIndex,
      {bool isReversed = false}) {
    list.sort((a, b) {
      final aIndex = getSortingIndex(a) ?? 0;
      final bIndex = getSortingIndex(b) ?? 0;
      return isReversed ? bIndex.compareTo(aIndex) : aIndex.compareTo(bIndex);
    });
  }
}
