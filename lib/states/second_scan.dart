// ignore_for_file: avoid_print

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
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        children: [
          aboutScan(),
          const SizedBox(height: 32),
          FutureBuilder(
            future: AppService().readAmountMitsuDataWhereLogin(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<AmountMitsuModel> amountMitsuModels = snapshot.data!;
                return ListView(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    const Divider(color: Colors.grey,),
                    const Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: WidgetText(data: 'No:'),
                        ),
                        Expanded(
                          flex: 2,
                          child: WidgetText(data: 'Code'),
                        ),
                        Expanded(
                          flex: 2,
                          child: WidgetText(data: 'Name'),
                        ),
                        Expanded(
                          flex: 1,
                          child: WidgetText(data: 'QTY'),
                        ),
                      ],
                    ),
                    const Divider(color: Colors.grey,),
                    ListView.builder(
                      itemCount: amountMitsuModels.length,
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Column(mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child:
                                    WidgetText(data: amountMitsuModels[index].id),
                              ),
                              Expanded(
                                flex: 2,
                                child:
                                    WidgetText(data: amountMitsuModels[index].code),
                              ),
                              Expanded(
                                flex: 2,
                                child:
                                    WidgetText(data: amountMitsuModels[index].name),
                              ),
                              Expanded(
                                flex: 1,
                                child:
                                    WidgetText(data: amountMitsuModels[index].qty),
                              ),
                            ],
                          ),
                          const Divider(color: Colors.grey,),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }

  Row aboutScan() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            Get.to(const ScanPage())?.then(
              (value) async {
                print('##24may value ที่ได้จากการ Scan ----> $value');
                appController.resultQR.value = value.toString();

                AmountMitsuModel? amountMitsuModel = await AppService()
                    .readAmountMitsuData(code: appController.resultQR.value);

                appController.contentWidgets
                    .add(WidgetText(data: amountMitsuModel!.name));
                setState(() {});
              },
            );
          },
          child: const WidgetButtonScan(),
        ),
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
