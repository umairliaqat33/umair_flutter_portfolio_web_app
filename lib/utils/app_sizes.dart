import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

bool isTablet(BuildContext context) {
  var shortestSide = MediaQuery.of(context).size.shortestSide;
  return shortestSide > 600;
}

bool isIpad(BuildContext context) {
  if (!Theme.of(context).platform.toString().contains('iOS')) return false;
  return isTablet(context) && MediaQuery.of(context).size.width > 768;
}

bool isIphone(BuildContext context) {
  if (!Theme.of(context).platform.toString().contains('iOS')) return false;
  return !isTablet(context);
}

bool isLandScape(BuildContext context) {
  return MediaQuery.orientationOf(context) == Orientation.landscape;
}

enum DeviceState {
  tabletLandscape,
  tabletPortrait,
  phoneLandscape,
  phonePortrait
}

DeviceState getDeviceState(BuildContext context) {
  bool tablet = isTablet(context);
  bool landscape = isLandScape(context);

  if (tablet && landscape) return DeviceState.tabletLandscape;
  if (tablet && !landscape) return DeviceState.tabletPortrait;
  if (!tablet && landscape) return DeviceState.phoneLandscape;
  return DeviceState.phonePortrait;
}

class AppSizes {
  static double dropDownHeight(BuildContext context) {
    DeviceState state = getDeviceState(context);
    switch (state) {
      case DeviceState.phoneLandscape:
        return 20.w;
      case DeviceState.tabletLandscape:
        return 25.w;
      case DeviceState.tabletPortrait:
        return 45.w;
      case DeviceState.phonePortrait:
        return 45.w;
    }
  }

  static double fontSize(BuildContext context) {
    DeviceState state = getDeviceState(context);
    switch (state) {
      case DeviceState.phoneLandscape:
        return 8.sp;
      case DeviceState.tabletLandscape:
        return 8.sp;
      case DeviceState.tabletPortrait:
        return 10.sp;
      case DeviceState.phonePortrait:
        return 16.sp;
    }
  }

  static double textfieldWidth(BuildContext context) {
    DeviceState state = getDeviceState(context);
    switch (state) {
      case DeviceState.phoneLandscape:
        return 600.w;
      case DeviceState.tabletLandscape:
        return 600.w;
      case DeviceState.tabletPortrait:
        return 600.w;
      case DeviceState.phonePortrait:
        return 600.w;
    }
  }

  static double infoCardTitleFontSize(BuildContext context) {
    DeviceState state = getDeviceState(context);
    switch (state) {
      case DeviceState.phoneLandscape:
        return 16.sp;
      case DeviceState.tabletLandscape:
        return 16.sp;
      case DeviceState.tabletPortrait:
        return 16.sp;
      case DeviceState.phonePortrait:
        return 16.sp;
    }
  }

  static EdgeInsets appPadding(BuildContext context) {
    DeviceState state = getDeviceState(context);
    switch (state) {
      case DeviceState.phoneLandscape:
        return EdgeInsets.symmetric(horizontal: 40.w);
      case DeviceState.tabletLandscape:
        return EdgeInsets.symmetric(horizontal: 30.w);
      case DeviceState.tabletPortrait:
        return EdgeInsets.symmetric(horizontal: 30.w);
      case DeviceState.phonePortrait:
        return EdgeInsets.symmetric(horizontal: 40.w);
    }
  }
}

class HomeScreenSizes {
  static double workHistoryLeftSize(BuildContext context) {
    DeviceState state = getDeviceState(context);
    switch (state) {
      case DeviceState.phoneLandscape:
        return 200.w;
      case DeviceState.tabletLandscape:
        return 200.w;
      case DeviceState.tabletPortrait:
        return 200.w;
      case DeviceState.phonePortrait:
        return 200.w;
    }
  }

  static double projectDialogWidth(BuildContext context) {
    DeviceState state = getDeviceState(context);
    switch (state) {
      case DeviceState.phoneLandscape:
        return 800.w;
      case DeviceState.tabletLandscape:
        return 800.w;
      case DeviceState.tabletPortrait:
        return 800.w;
      case DeviceState.phonePortrait:
        return 800.w;
    }
  }

  static double projectDialogImageHeight(BuildContext context) {
    DeviceState state = getDeviceState(context);
    switch (state) {
      case DeviceState.phoneLandscape:
        return 500.w;
      case DeviceState.tabletLandscape:
        return 500.w;
      case DeviceState.tabletPortrait:
        return 500.w;
      case DeviceState.phonePortrait:
        return 800.w;
    }
  }
}

class PortfolioDetailsSizes {
  static double imageSize(BuildContext context) {
    DeviceState state = getDeviceState(context);
    switch (state) {
      case DeviceState.phoneLandscape:
        return 307.w;
      case DeviceState.tabletLandscape:
        return 307.w;
      case DeviceState.tabletPortrait:
        return 307.w;
      case DeviceState.phonePortrait:
        return 307.w;
    }
  }

  static EdgeInsets imageSectionPadding(BuildContext context) {
    DeviceState state = getDeviceState(context);
    switch (state) {
      case DeviceState.phoneLandscape:
        return EdgeInsets.all(
          14.w,
        );
      case DeviceState.tabletLandscape:
        return EdgeInsets.all(
          14.w,
        );
      case DeviceState.tabletPortrait:
        return EdgeInsets.all(
          14.w,
        );
      case DeviceState.phonePortrait:
        return EdgeInsets.all(
          14.w,
        );
    }
  }
}
