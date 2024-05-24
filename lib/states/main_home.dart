import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jayproj/states/main_scan.dart';
import 'package:jayproj/states/second_scan.dart';
import 'package:jayproj/utility/app_controller.dart';
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

  @override
  void initState() {
    super.initState();

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
            title: WidgetText(data: titles[appController.indexBody.value]),
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
}
