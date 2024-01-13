import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jayproj/states/scan_page.dart';
import 'package:jayproj/utility/app_constant.dart';
import 'package:jayproj/utility/app_controller.dart';
import 'package:jayproj/widgets/widget_image_asset.dart';
import 'package:jayproj/widgets/widget_text.dart';

class MainScan extends StatefulWidget {
  const MainScan({super.key});

  @override
  State<MainScan> createState() => _MainScanState();
}

class _MainScanState extends State<MainScan> {
  AppController appController = Get.put(AppController());

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

  Widget displayResult() {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.centerLeft,
        width: 200,
        height: 40,
        decoration: AppConstant().radiusBorder(),
        child: appController.resultQR.isEmpty
            ? const WidgetText(data: 'Please Scan')
            : WidgetText(data: appController.resultQR.value),
      );
    });
  }

  InkWell buttonScan() {
    return InkWell(
      onTap: () {
        Get.to(const ScanPage())!.then((value) {

          if (value == null) {
            appController.resultQR.value = '';
          } else {

             String result = value;
          print('## result ---> $result');
          appController.resultQR.value = result;



          }

         
        });

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
