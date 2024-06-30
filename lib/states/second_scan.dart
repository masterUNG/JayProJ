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

class SecondScan extends StatefulWidget {
  const SecondScan({super.key});

  @override
  State<SecondScan> createState() => _SecondScanState();
}

class _SecondScanState extends State<SecondScan> {
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
          },
          title: WidgetText(
              data: appController.displayForm.value
                  ? 'Hint Form'
                  : 'Display Form'),
          controlAffinity: ListTileControlAffinity.leading,
        ));
  }

  Row groupButton({required List<AmountMitsuModel> amountMitsuModels}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        WidgetButton(
          label: 'Save',
          pressFunc: () {
            AppDialog().normalDialog(
                title: 'Confirm Save',
                contentWidget: const WidgetText(data: 'Please Confirm Save'),
                firstWidget: WidgetButton(
                  label: 'Confirm',
                  pressFunc: () {
                    AppService()
                        .processSave(amountMitsuModels: amountMitsuModels)
                        .then(
                      (value) async {
                        AppService()
                            .processCancel(amountMitsuModels: amountMitsuModels)
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
                        .processCancel(amountMitsuModels: amountMitsuModels)
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
      future: AppService().readAmountMitsuDataWhereLogin(),
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

                          AppService().processDeleteById(id: id).then(
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
    return Obx(() => appController.displayForm.value
        ? Form(
            key: keyForm,
            child: WidgetForm(
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
                  await findResultFromCode(code: textEditingController.text)
                      .then(
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
          )
        : const SizedBox());
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
                      width: 200,
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
        .readAmountMitsuData(code: appController.resultQR.value);

    appController.contentWidgets.add(WidgetText(data: amountMitsuModel!.name));
    setState(() {});
  }
}
