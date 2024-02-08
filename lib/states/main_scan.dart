// ignore_for_file: public_member_api_docs, sort_constructors_first, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:jayproj/states/scan_page.dart';
import 'package:jayproj/utility/app_constant.dart';
import 'package:jayproj/utility/app_controller.dart';
import 'package:jayproj/utility/app_dialog.dart';
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
  void initState() {
    super.initState();

    AppService()
        .processFindLocation()
        .then((value) => print('position --> ${appController.positions.last}'));

    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          aboutScan(),
          displayData(),
        ],
      )),
    );
  }

  Container aboutScan() {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buttonScan(),
          displayResult(),
        ],
      ),
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
                  Container(
                    decoration: AppConstant().radiusBorder(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: Get.width * 0.5 - 26,
                              child: RadioListTile(
                                value: 1,
                                groupValue: appController.chooseStatus.last,
                                onChanged: (value) {
                                  appController.chooseStatus.add(value);
                                },
                                title: const WidgetText(data: 'สมบูรณ์'),
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.5 - 26,
                              child: RadioListTile(
                                value: 2,
                                groupValue: appController.chooseStatus.last,
                                onChanged: (value) {
                                  appController.chooseStatus.add(value);
                                },
                                title: const WidgetText(data: 'ไม่สมบูรณ์'),
                              ),
                            ),
                          ],
                        ),
                        appController.chooseStatus.last == null
                            ? const SizedBox()
                            : appController.chooseStatus.last == 2
                                ? DropdownButton(
                                    value: appController
                                        .chooseNonConpleateTitles.last,
                                    hint: const WidgetText(
                                        data: 'โปรดเลือกความไม่สมบูรณ์'),
                                    items: AppConstant.nonCompleateTitles
                                        .map(
                                          (e) => DropdownMenuItem(
                                            child: WidgetText(data: e),
                                            value: e,
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (value) {
                                      appController.chooseNonConpleateTitles
                                          .add(value);
                                    },
                                  )
                                : const SizedBox(),
                      ],
                    ),
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
                  urlImage: appController.dataModels.last.img_bill)
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    WidgetImageFile(file: appController.files.last),
                    WidgetButton(
                      label: 'Save',
                      pressFunc: () {
                        if (appController.chooseStatus.last == null) {
                          AppDialog().normalDialog(
                              title: 'สมบูรณ์ หรือ ไม่ ?',
                              contentWidget: const WidgetText(
                                  data:
                                      'โปรดเลือก สมบูรณ์ หรือ ไม่สมบูรณ์ พร้อมเหตุผล'));
                        } else if (appController.chooseStatus.last == 2) {
                          //เลือกไม่สมบูรณ์
                          if (appController.chooseNonConpleateTitles.last ==
                              null) {
                            // ยังไม่ได้เลือกเหตุผล
                            AppDialog().normalDialog(
                                title: 'ยังไม่มีเหตุผล ?',
                                contentWidget: const WidgetText(
                                    data: 'โปรดเลือกความไม่สมบูรณ์'));
                          } else {
                            //เลือกเหตุผลแล้ว
                            AppService().processUploadAndEditData();
                          }
                        } else {
                          //เลือกสมบูรณ์
                          AppService().processUploadAndEditData();
                        }
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
