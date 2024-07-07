// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:jayproj/models/amount_mitsu_model.dart';
import 'package:jayproj/models/mitsu_model.dart';
import 'package:jayproj/states/scan_page.dart';
import 'package:jayproj/utility/app_constant.dart';
import 'package:jayproj/utility/app_controller.dart';
import 'package:jayproj/utility/app_dialog.dart';
import 'package:jayproj/utility/app_service.dart';
import 'package:jayproj/widgets/widget_button.dart';
import 'package:jayproj/widgets/widget_button_scan.dart';
import 'package:jayproj/widgets/widget_form.dart';
import 'package:jayproj/widgets/widget_text.dart';

class ThirdScan extends StatefulWidget {
  const ThirdScan({super.key});

  @override
  State<ThirdScan> createState() => _ThirdScanState();
}

class _ThirdScanState extends State<ThirdScan> {
  AppController appController = Get.put(AppController());

  final keyForm = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();

  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          children: [
            aboutScan(),
            const SizedBox(height: 32),
            switchDisplayForm(),
            codeForm(),
            const SizedBox(height: 32),
            listViewResult(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Obx switchDisplayForm() {
    return Obx(() => SwitchListTile(
          value: appController.displayForm.value,
          onChanged: (value) {
            appController.displayForm.value = value;

            if (value) {
              appController.textInputType.add(TextInputType.text);
            } else {
              appController.textInputType.add(TextInputType.none);
            }
          },
          title: WidgetText(
              data: appController.displayForm.value
                  ? 'Hint Keyboard'
                  : 'Display Keyboard'),
          controlAffinity: ListTileControlAffinity.leading,
        ));
  }

  Row groupButton({required List<AmountMitsuModel> amountMitsuModels}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        WidgetButton(color: GFColors.DANGER,
          label: 'Save Out',
          pressFunc: () {
            AppDialog().normalDialog(
                title: 'Confirm Save',
                contentWidget: const WidgetText(data: 'Please Confirm Save'),
                firstWidget: WidgetButton(
                  label: 'Confirm',
                  pressFunc: () {

                    AppService()
                        .processSaveOut(amountMitsuModels: amountMitsuModels)
                        .then(
                      (value) async {
                        AppService()
                            .processCancel(amountMitsuModels: amountMitsuModels, fromScanIn: false)
                            .then(
                          (value) {
                            Get.back();
                            setState(() {});
                          },
                        );
                      },
                    );
                  },
                ));
          },
        ),
        const SizedBox(width: 8),
        WidgetButton(
          label: 'Cancel',
          gfButtonType: GFButtonType.outline2x,
          pressFunc: () {
            AppDialog().normalDialog(
                title: 'Confirm Delete',
                firstWidget: WidgetButton(
                  label: 'Confirm',
                  pressFunc: () {
                    AppService()
                        .processCancel(amountMitsuModels: amountMitsuModels, fromScanIn: false)
                        .then(
                      (value) {
                        Get.back();
                        setState(() {});
                      },
                    );
                  },
                ));
          },
        ),
      ],
    );
  }

  FutureBuilder<List<AmountMitsuModel>> listViewResult() {
    return FutureBuilder(
      future: AppService().readAmountMitsuDataWhereLoginforThirdScan(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<AmountMitsuModel> amountMitsuModels = snapshot.data!;
          return ListView(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            children: [
              const Divider(
                color: Colors.grey,
              ),
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
              const Divider(
                color: Colors.grey,
              ),
              ListView.builder(
                itemCount: amountMitsuModels.length,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => Slidable(
                  key: const ValueKey(0),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    extentRatio: 0.5,
                    children: <Widget>[
                      SlidableAction(
                        onPressed: (context) {
                          String id = amountMitsuModels[index].id;

                          print('##30june you delete id --> $id');

                          AppService().processDeleteById(id: id, fromScanIn: false).then(
                            (value) {
                              setState(() {});
                            },
                          );
                        },
                        backgroundColor: GFColors.PRIMARY,
                        label: 'Del',
                      ),
                      SlidableAction(
                        onPressed: (context) {
                          String id = amountMitsuModels[index].id;
                          String currentStatus =
                              amountMitsuModels[index].status;

                          print(
                              'id ---> $id, currentStatus ---> $currentStatus');

                          int status = int.parse(currentStatus);
                          status++;

                          String newStatus = (status % 2).toString();

                          print('newStatus ===> $newStatus');

                          AppService()
                              .processUpdateStatus(id: id, newStatus: newStatus)
                              .then(
                            (value) {
                              setState(() {});
                            },
                          );
                        },
                        label: AppConstant.titleSlids[
                            int.parse(amountMitsuModels[index].status)],
                        backgroundColor: AppConstant
                            .colors[int.parse(amountMitsuModels[index].status)],
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                            color: AppConstant.colorBGs[
                                int.parse(amountMitsuModels[index].status)]),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: WidgetText(
                                // data: amountMitsuModels[index].id,
                                data: (index + 1).toString(),
                                textStyle: AppConstant().h3Style(
                                    color: AppConstant.colorTexts[int.parse(
                                        amountMitsuModels[index].status)]),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: WidgetText(
                                data: amountMitsuModels[index].code,
                                textStyle: AppConstant().h3Style(
                                    color: AppConstant.colorTexts[int.parse(
                                        amountMitsuModels[index].status)]),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: WidgetText(
                                data: amountMitsuModels[index].name,
                                textStyle: AppConstant().h3Style(
                                    color: AppConstant.colorTexts[int.parse(
                                        amountMitsuModels[index].status)]),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: WidgetText(
                                data: amountMitsuModels[index].qty,
                                textStyle: AppConstant().h3Style(
                                    color: AppConstant.colorTexts[int.parse(
                                        amountMitsuModels[index].status)]),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
              //  const Divider(
              //           color: Colors.grey,
              //         ),
              const SizedBox(height: 32),
              groupButton(amountMitsuModels: amountMitsuModels),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget codeForm() {
    return Obx(() => Form(
          key: keyForm,
          child: WidgetForm(
            keyboardType: appController.textInputType.last,
            readOnly: !appController.displayForm.value,
            focusNode: focusNode,
            autofocus: true,
            textEditingController: textEditingController,
            validateFunc: (p0) {
              if (p0?.isEmpty ?? true) {
                return 'Please Fill Code';
              } else {
                return null;
              }
            },
            onFieldSubmitted: (p0) async {
              if (keyForm.currentState!.validate()) {
                await findResultFromCode(code: textEditingController.text).then(
                  (value) {
                    textEditingController.clear();
                    FocusScope.of(context).requestFocus(focusNode);
                  },
                );
              }
            },
            label: 'code :',
            suffixWidget: WidgetButton(
              gfButtonType: GFButtonType.outline,
              label: 'Scan',
              pressFunc: () async {
                if (keyForm.currentState!.validate()) {
                  await findResultFromCode(code: textEditingController.text)
                      .then(
                    (value) {
                      textEditingController.clear();
                    },
                  );
                }
              },
            ),
          ),
        ));
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
                await findResultFromCode(code: value);
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
                    SizedBox(
                      width: Get.width * 0.4,
                      child: WidgetText(data: 'mame : ${mitsuModel.name}'),
                    ),
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

  Future<void> findResultFromCode({required String code}) async {
    appController.resultQR.value = code.toUpperCase().toString();

    AmountMitsuModel? amountMitsuModel = await AppService()
        .readAmountMitsuData(code: appController.resultQR.value, fromScanIn: false);

    appController.contentWidgets.add(WidgetText(data: amountMitsuModel!.name));
    setState(() {});
  }
}
