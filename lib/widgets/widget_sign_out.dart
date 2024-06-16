import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:jayproj/utility/app_dialog.dart';
import 'package:jayproj/widgets/widget_button.dart';
import 'package:jayproj/widgets/widget_text.dart';

class WidgetSighOut extends StatelessWidget {
  const WidgetSighOut({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WidgetButton(
      label: 'Sign Out',
      pressFunc: () {
        AppDialog().normalDialog(
            title: 'Sign Out ?',
            contentWidget: const WidgetText(data: 'Please Confirm for SignOut'),
            firstWidget: WidgetButton(
              label: 'Comfirm',
              pressFunc: () async {
                await GetStorage()
                    .erase()
                    .then((value) => Get.offAllNamed('/authen'));
              },
            ));
      },
      gfButtonType: GFButtonType.outline,
    );
  }
}
