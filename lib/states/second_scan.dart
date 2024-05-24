import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jayproj/models/amount_mitsu_model.dart';
import 'package:jayproj/models/mitsu_model.dart';
import 'package:jayproj/states/scan_page.dart';
import 'package:jayproj/utility/app_constant.dart';
import 'package:jayproj/utility/app_controller.dart';
import 'package:jayproj/utility/app_service.dart';
import 'package:jayproj/widgets/widget_button_scan.dart';
import 'package:jayproj/widgets/widget_text.dart';

class SecondScan extends StatefulWidget {
  const SecondScan({super.key});

  @override
  State<SecondScan> createState() => _SecondScanState();
}

class _SecondScanState extends State<SecondScan> {
  AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          Get.to(const ScanPage())?.then(
            (value) {
              print('##24may value ที่ได้จากการ Scan ----> $value');
              appController.resultQR.value = value.toString();
              setState(() {});
            },
          );
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          children: [
            aboutScan(),
            FutureBuilder(
              future: AppService()
                  .readAmountMitsuData(code: appController.resultQR.value),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  AmountMitsuModel amountMitsuModel = snapshot.data!;
                  return Container(
                    decoration: AppConstant().radiusBorder(),
                    margin: const EdgeInsets.only(top: 32),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            WidgetText(data: 'code : ${amountMitsuModel.code}'),
                            WidgetText(data: 'name : ${amountMitsuModel.name}'),
                          ],
                        ),
                        WidgetText(data: 'QTY : ${amountMitsuModel.qty}'),
                      ],
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Row aboutScan() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const WidgetButtonScan(),
        FutureBuilder(
          future:
              AppService().readMitsuData(code: appController.resultQR.value),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              MitsuModel mitsuModel = snapshot.data!;
              return Container(
                margin: const EdgeInsets.only(left: 32),
                padding: const EdgeInsets.all(8),
                decoration: AppConstant().radiusBorder(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    WidgetText(data: 'code : ${mitsuModel.code}'),
                    WidgetText(data: 'mame : ${mitsuModel.name}'),
                    WidgetText(data: 'type : ${mitsuModel.type}'),
                    WidgetText(data: 'gprice : ${mitsuModel.gprice}'),
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }
}
