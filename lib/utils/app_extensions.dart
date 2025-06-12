import 'package:flutter/material.dart';
import 'package:umair_liaqat/utils/app_strings.dart';

import 'app_enum.dart';

extension AppBarHeaderExtension on AppBarHeaders {
  String getString() {
    switch (this) {
      case AppBarHeaders.home:
        return Strings.home;
      case AppBarHeaders.projects:
        return "${Strings.project}s";
      case AppBarHeaders.contact:
        return Strings.contact;
      case AppBarHeaders.qualification:
        return "${Strings.qualification}s";
      case AppBarHeaders.workHistory:
        return Strings.jobHistory;
    }
  }
}

extension MediaQueryExtension on BuildContext {
  Size get _size => MediaQuery.of(this).size;
  double get width => _size.width;
  double get height => _size.height;
}

extension TapExtension on Widget {
  Widget onTapWidget({
    required void Function() onTap,
    HitTestBehavior? hitTestBehavior,
  }) {
    return GestureDetector(
      behavior: hitTestBehavior ?? HitTestBehavior.opaque,
      onTap: () async {
        onTap.call();
      },
      child: this,
    );
  }
}

extension DeviceTypeExtension on DeviceType {
  int getMinWidth() {
    switch (this) {
      case DeviceType.mobile:
        return 320;
      case DeviceType.ipad:
        return 481;
      case DeviceType.smallScreenLaptop:
        return 769;
      case DeviceType.largeScreenDesktop:
        return 1025;
      case DeviceType.extraLargeTV:
        return 1201;
    }
  }

  int getMaxWidth() {
    switch (this) {
      case DeviceType.mobile:
        return 480;
      case DeviceType.ipad:
        return 768;
      case DeviceType.smallScreenLaptop:
        return 1024;
      case DeviceType.largeScreenDesktop:
        return 1200;
      case DeviceType.extraLargeTV:
        return 3840; // any number more than 1200
    }
  }
}
