import 'package:flutter/material.dart';
import 'package:jayproj/utility/app_constant.dart';
import 'package:jayproj/widgets/widget_image_asset.dart';
import 'package:jayproj/widgets/widget_text.dart';

class MainScan extends StatelessWidget {
  const MainScan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        margin: const EdgeInsets.only(top: 80),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buttonScan(),
            displayResult(),
          ],
        ),
      )),
    );
  }

  Container displayResult() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      width: 200,
      height: 40,
      decoration: AppConstant().radiusBorder(),
      child: WidgetText(data: 'data'),
    );
  }

  InkWell buttonScan() {
    return InkWell(
      onTap: () {
        print('You tap');
      },
      child: Container(
        width: 96,
        padding: const EdgeInsets.all(8),
        decoration: AppConstant().radiusBorder(),
        child: const AspectRatio(
          aspectRatio: 1.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              WidgetImageAsset(
                path: 'images/qr.png',
                size: 48,
              ),
              SizedBox(
                height: 8,
              ),
              WidgetText(data: 'Scan')
            ],
          ),
        ),
      ),
    );
  }
}
