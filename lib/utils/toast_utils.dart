import 'package:flutter/material.dart';
import 'package:umair_liaqat/ui/widgets/common_widgets/progress_dialog.dart';
import 'package:umair_liaqat/utils/app_strings.dart';

class ToastUtils {
  static void showLoader(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ProgressDialog(
          text: Strings.pleaseWait,
        );
      },
    );
  }
}
