import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umair_liaqat/bloc/home_bloc/home_bloc.dart';
import 'package:umair_liaqat/ui/home/components/home_app_bar.dart';
import 'package:umair_liaqat/ui/portfolio_details/portfolio_details_screen.dart';
import 'package:umair_liaqat/utils/app_enum.dart';
import 'package:umair_liaqat/utils/app_extensions.dart';
import 'package:umair_liaqat/utils/app_sizes.dart';
import 'package:umair_liaqat/utils/app_theme.dart';
import 'package:umair_liaqat/ui/widgets/vertical_headers.dart';

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
      body: PortfolioDetailsScreen(),
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

  final contactMeKey = GlobalKey();

  @override
  void initState() {
    super.initState();

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
    return BlocListener<HomeBloc, HomeState>(
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
              featuredProjectsKey.currentContext!,
              duration: duration,
            );
          }
          if (state.index == 2) {
            Scrollable.ensureVisible(
              contactMeKey.currentContext!,
              duration: duration,
            );
          }
        }
      },
      child: Stack(
        children: [
          Container(
            width: context.width,
            height: context.height,
            padding: AppSizes.appPadding(context),
            color: PortfolioAppTheme.primary,
            child: SingleChildScrollView(
              controller: _controller,
              child: Column(
                children: [
                  SizedBox(height: 0.08 * context.height),
                  AboutMe(key: aboutMeKey),
                  SizedBox(height: context.height * 0.09),
                  FeatureProjects(key: featuredProjectsKey),
                  SizedBox(height: context.height * 0.09),
                  ContactMe(key: contactMeKey)
                ],
              ),
            ),
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
    );
  }

  CrossFadeState _getCrossFadeState(BuildContext context) {
    final currentHeaderAxis = context.read<HomeBloc>().appBarHeaderAxis;
    return currentHeaderAxis == AppBarHeadersAxis.horizontal
        ? CrossFadeState.showSecond
        : CrossFadeState.showFirst;
  }
}
