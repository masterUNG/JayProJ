import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jayproj/widgets/widget_button.dart';
import 'package:jayproj/widgets/widget_text.dart';

class AppDialog {
  void normalDialog({
    required String title,
    Widget? contentWidget,
    Widget? firstWidget,
    Widget? secondWidget,
  }) {
    Get.dialog(
        AlertDialog(
          title: WidgetText(data: title),
          content: contentWidget,
          actions: [
            firstWidget ?? const SizedBox(),
            secondWidget ??
                WidgetButton(
                  label: firstWidget == null ? 'OK' : 'Cancel',
                  pressFunc: () => Get.back(),
                )
          ],
        ),
        barrierDismissible: false);
  }
}
