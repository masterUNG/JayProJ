import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:jayproj/states/main_scan.dart';
import 'package:jayproj/states/second_scan.dart';
import 'package:jayproj/utility/app_constant.dart';
import 'package:jayproj/utility/app_controller.dart';
import 'package:jayproj/utility/app_service.dart';
import 'package:jayproj/widgets/widget_sign_out.dart';
import 'package:jayproj/widgets/widget_text.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  var bodys = <Widget>[
    const MainScan(),
    const SecondScan(),
  ];

  var titles = <String>[
    'Main Scan',
    'Second Scan',
  ];

  var icons = <IconData>[
    Icons.qr_code,
    Icons.qr_code_scanner,
  ];

  List<BottomNavigationBarItem> items = [];

  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();

     AppService()
        .processFindLocation()
        .then((value) => print('position --> ${appController.positions.last}'));

    AppService().processFindUserLogin();

    for (var i = 0; i < bodys.length; i++) {
      items.add(
        BottomNavigationBarItem(
          icon: Icon(icons[i]),
          label: titles[i],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetX<AppController>(
      init: AppController(),
      builder: (AppController appController) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                WidgetText(
                  data: titles[appController.indexBody.value],
                  // textStyle: AppConstant()
                  //     .h2Style(size: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 8),
                displayNameLogin(),
              ],
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 16),
                child: const WidgetSighOut(),
              )
            ],
          ),
          body: bodys[appController.indexBody.value],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: appController.indexBody.value,
            items: items,
            onTap: (value) {
              appController.indexBody.value = value;
            },
          ),
        );
      },
    );
  }

  Widget displayNameLogin() {
    return appController.currentUserModels.isEmpty
        ? const SizedBox()
        : SizedBox(
            // width: 200,
            child: Row(
              children: [
                WidgetText(
                  data: 'สวัสดี คุณ ',
                  textStyle: AppConstant().h3Style(color: GFColors.PRIMARY),
                ),
                WidgetText(
                  data: appController.currentUserModels.last.mem_name,
                  textStyle: AppConstant().h3Style(color: Colors.purple),
                ),
              ],
            ),
          );
  }
}
