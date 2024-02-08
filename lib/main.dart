import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jayproj/states/authen.dart';
import 'package:jayproj/states/main_scan.dart';

void main() {
  HttpOverrides.global = MyHttpOverride();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      // home: MainScan(),
      home: Authen(),
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
