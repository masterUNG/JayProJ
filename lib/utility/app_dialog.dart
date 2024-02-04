import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jayproj/widgets/widget_button.dart';
import 'package:jayproj/widgets/widget_text.dart';

class AppDialog {
  void normalDialog({
    required String title,
    Widget? contentWidget,
  }) {
    Get.dialog(AlertDialog(
      title: WidgetText(data: title),
      content: contentWidget,
      actions: [
        WidgetButton(
          label: 'OK',
          pressFunc: () => Get.back(),
        )
      ],
    ));
  }
}
