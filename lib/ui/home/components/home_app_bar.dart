import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umair_liaqat/bloc/home_bloc/home_bloc.dart';
import 'package:umair_liaqat/utils/app_enum.dart';
import 'package:umair_liaqat/utils/app_extensions.dart';
import 'package:umair_liaqat/utils/app_theme.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Umair Liaqat",
              style: textTheme.headlineMedium!.copyWith(
                  color: PortfolioAppTheme.white, fontWeight: FontWeight.w400),
            ),
            context.width > DeviceType.ipad.getMaxWidth()
                ? const HorizontalHeaders()
                : const AppBarMenu(),
          ],
        ),
      ),
    );
  }
}

class AppBarMenu extends StatelessWidget {
  const AppBarMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return SizedBox(
          width: 40,
          child: AnimatedCrossFade(
            crossFadeState: _getCrossFadeState(context),
            firstChild: TextButton(
              onPressed: () => _menuBtnClicked(context),
              child: Icon(
                Icons.menu,
                color: Colors.white,
              ),
            ),
            secondChild: TextButton(
              onPressed: () => _closeBtnClicked(context),
              child: const Icon(Icons.close),
            ),
            duration: const Duration(milliseconds: 200),
          ),
        );
      },
    );
  }

  _menuBtnClicked(BuildContext context) {
    context.read<HomeBloc>().add(
          ChangeAppBarHeadersAxis(AppBarHeadersAxis.vertical),
        );
  }

  _closeBtnClicked(BuildContext context) {
    context.read<HomeBloc>().add(
          ChangeAppBarHeadersAxis(AppBarHeadersAxis.horizontal),
        );
  }

  CrossFadeState _getCrossFadeState(BuildContext context) {
    final currentHeaderAxis = context.read<HomeBloc>().appBarHeaderAxis;
    return currentHeaderAxis == AppBarHeadersAxis.horizontal
        ? CrossFadeState.showFirst
        : CrossFadeState.showSecond;
  }
}

class HorizontalHeaders extends StatelessWidget {
  const HorizontalHeaders({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Row(
          children: List.generate(
            AppBarHeaders.values.length,
            (index) => CustomHeaderBtn(headerIndex: index),
          ),
        );
      },
    );
  }
}

class CustomHeaderBtn extends StatelessWidget {
  const CustomHeaderBtn({super.key, required this.headerIndex});
  final int headerIndex;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return TextButton(
      onPressed: () {
        context.read<HomeBloc>().add(ChangeAppBarHeadersIndex(headerIndex));
      },
      style: TextButton.styleFrom(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
        child: Text(
          AppBarHeaders.values[headerIndex].getString(),
          style: textTheme.titleSmall!.copyWith(
            fontWeight: FontWeight.w800,
            color: _getHeaderColor(
              currentIndex: context.read<HomeBloc>().appBarHeaderIndex,
              headerIndex: headerIndex,
            ),
          ),
        ),
      ),
    );
  }

  Color _getHeaderColor({required currentIndex, required int headerIndex}) {
    if (currentIndex == headerIndex) {
      return PortfolioAppTheme.nameColor;
    } else {
      return PortfolioAppTheme.white;
    }
  }
}
