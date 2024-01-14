// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:jayproj/states/scan_page.dart';
import 'package:jayproj/utility/app_constant.dart';
import 'package:jayproj/utility/app_controller.dart';
import 'package:jayproj/utility/app_service.dart';
import 'package:jayproj/widgets/widget_button.dart';
import 'package:jayproj/widgets/widget_head_tail.dart';
import 'package:jayproj/widgets/widget_icon_button.dart';
import 'package:jayproj/widgets/widget_image_asset.dart';
import 'package:jayproj/widgets/widget_image_file.dart';
import 'package:jayproj/widgets/widget_image_network.dart';
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
          child: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buttonScan(),
                displayResult(),
              ],
            ),
          ),
          displayData(),
        ],
      )),
    );
  }

  Obx displayData() {
    return Obx(() {
      return appController.dataModels.isEmpty
          ? const SizedBox()
          : Container(
              padding: const EdgeInsets.all(8),
              decoration: AppConstant().radiusBorder(),
              margin: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const WidgetText(data: 'ข้อมูล :'),
                  WidgetHeadTail(
                    head: 'InvDate :',
                    tail: appController.dataModels.last.invdate,
                  ),
                  WidgetHeadTail(
                    head: 'InvCode :',
                    tail: appController.dataModels.last.invcode,
                  ),
                  WidgetHeadTail(
                    head: 'ชื่อ :',
                    tail: appController.dataModels.last.invname,
                  ),
                  WidgetHeadTail(
                    head: 'ยอดรวม :',
                    tail: appController.dataModels.last.invsumtt,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const WidgetText(data: 'ImageBill :'),
                  const SizedBox(
                    height: 16,
                  ),
                  displayImage(),
                ],
              ),
            );
    });
  }

  Widget displayImage() {
    return Obx(() {
      return Stack(
        children: [
          appController.files.isEmpty
              ? WidgetImageNetwork(
                  urlImage: appController.dataModels.last.imgBill)
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    WidgetImageFile(file: appController.files.last),
                    WidgetButton(
                      label: 'Save',
                      pressFunc: () {



                        AppService().processUploadAndEditData();



                        
                      },
                    )
                  ],
                ),
          WidgetIconButton(
            iconData: Icons.add_a_photo_outlined,
            pressFunc: () {
              AppService().processTakePhoto();
            },
          )
        ],
      );
    });
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

            if (appController.files.isNotEmpty) {
              appController.files.clear();
            }

            appController.resultQR.value = result;

            AppService().processCheckQRcode(number: result.trim());
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
