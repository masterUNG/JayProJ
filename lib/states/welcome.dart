import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jayproj/utility/app_constant.dart';
import 'package:jayproj/widgets/widget_button.dart';
import 'package:jayproj/widgets/widget_image_asset.dart';
import 'package:jayproj/widgets/widget_text.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppConstant()
            .radialBox(),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              WidgetText(
                data: 'Welcome !',
                textStyle: AppConstant().h1Style(),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                child: WidgetImageAsset(
                  path: 'images/qr.png',
                  size: Get.width * 0.3,
                ),
              ),
              WidgetButton(
                label: 'Get Start',
                pressFunc: () {
                  Get.offAllNamed('/authen');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
