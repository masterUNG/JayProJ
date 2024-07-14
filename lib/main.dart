// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jayproj/states/authen.dart';
import 'package:jayproj/states/main_home.dart';
import 'package:jayproj/states/main_scan.dart';
import 'package:jayproj/states/test_from.dart';
import 'package:jayproj/states/welcome.dart';

String? initialRoute;

var getPages = <GetPage<dynamic>>[
  GetPage(
    name: '/welcome',
    page: () => const Welcome(),
  ),
  GetPage(
    name: '/authen',
    page: () => const Authen(),
  ),
  GetPage(
    name: '/mainScan',
    page: () => const MainScan(),
  ),
  GetPage(
    name: '/mainHome',
    page: () => const TestForm(),
    // page: () => const MainHome(),
  ),
];

Future<void> main() async {
  HttpOverrides.global = MyHttpOverride();

  await GetStorage.init().then((value) {
    var data = GetStorage().read('data');
    print('## data ที่อ่านได้จาก main ---> $data');

    if (data == null) {
      // initialRoute = '/authen';
      initialRoute = '/welcome';
      runApp(const MyApp());
    } else {
      initialRoute = '/mainHome';
      runApp(const MyApp());
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: getPages,
      initialRoute: initialRoute,
      theme: ThemeData(useMaterial3: true),
    );
  }
}

class MyHttpOverride extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}
