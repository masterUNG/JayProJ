import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jayproj/states/scan_page.dart';
import 'package:jayproj/widgets/widget_button_scan.dart';
import 'package:jayproj/widgets/widget_text.dart';

class SecondScan extends StatelessWidget {
  const SecondScan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          Get.to(ScanPage())?.then(
            (value) {
              print('##24may value ที่ได้จากการ Scan ----> $value');
            },
          );
        },
        child: WidgetButtonScan(),
      ),
    );
  }
}
